import os
import cv2
aux = os.listdir('PNG/')

for i in aux:
    if i.endswith('.png'):
        teste = cv2.imread('PNG/'+i)
        resized = cv2.resize(teste,(256,256))
        cv2.imwrite('n256/'+i,resized)

