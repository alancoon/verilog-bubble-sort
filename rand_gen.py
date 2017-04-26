import random

for i in range(32):
	print 'n[' + str(i) + '] <= ' + str(random.sample(xrange(1, 255), 1))[1:-1] + ';'