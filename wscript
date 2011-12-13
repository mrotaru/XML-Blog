# !/bin/env/python
import os
import sys
import glob
from subprocess import *
from shutil import copy

top = '.'
out = 'build'

def options( opt ):
    pass

def configure( cnf ):
    cnf.find_program( "msxsl" )

def build( ctx ):

    for f in glob.glob('*.xml'):
        ctx( 
                rule='msxsl ../${SRC[0]} ../${SRC[1]} -o ${TGT}', 
                source = [ str( f ), 'transform.xsl' ], 
                target = str( f ).replace( '.xml','.html' ) 
           )

    copy( 'style.css', out )

# vim:filetype=python
