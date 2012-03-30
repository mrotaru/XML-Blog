# !/bin/env/python
import os
import sys
import glob
from subprocess import *
from shutil import copy
from shutil import copytree

top = '.'
out = 'build'

def options( opt ):
    pass

def configure( cnf ):
    cnf.find_program( "xsltproc" )

def build( ctx ):
    for f in glob.glob('posts/*.xml'):
        ctx( 
                rule='xsltproc -o ${TGT} ../${SRC[1]} ../posts/${SRC[0]}', 
                source = [ str( f ), 'make_meta.xsl' ], 
                target = 'meta/' + os.path.basename( f ).replace( '.xml', '_meta.xml' )
           )

    for f in glob.glob('posts/*.xml'):
        ctx( 
                rule='fop -c ../fop.xconf -xml ../posts/${SRC[0]} -xsl ../${SRC[1]} -pdf ${TGT}', 
                source = [ str( f ), 'make_pdf.xsl' ], 
                target = 'pdf/' + os.path.basename( f ).replace( '.xml', '.pdf' )
           )

def files( ctx ):
    copy( 'style.css', out )
    copytree( 'img/', out + '/img' )

def html( ctx ):
    # gives out an error: 'Context' object is not callable;
    # looks like Context is only callable from 'build'
    for f in glob.glob('posts/*.xml'):
        ctx( 
                rule='xsltproc -o ${TGT} ../${SRC[1]} ../posts/${SRC[0]}', 
                source = [ str( f ), 'transform.xsl' ], 
                target = str( f ).replace( '.xml','.html' ) 
           )

def rmfiles( ctx ):
    call( 'rm ' + out + '/style.css' )
    call( 'rm -rf ' + out + '/img' )

def titles( ctx ):
    call( 'xsltproc -o posts_with_titles.xml make_posts_with_titles.xsl posts.xml' )

# vim:filetype=python
