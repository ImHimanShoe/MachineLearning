import scipy.io
exon  = [[[1, 2], [3, 4], [5, 6]], [[7, 8], [9, 10]]]
scipy.io.savemat('out.mat', mdict={'exon': (exon[0], exon[1])})