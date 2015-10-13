#!/usr/bin/env python2
import fontforge
import sys

_, src, dest = sys.argv

f = fontforge.open(src)
f.save(dest)