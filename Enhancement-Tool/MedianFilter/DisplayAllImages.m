
IMG = imread('../Images/George.jpg');
IMG1 = imread('../Images/GeorgeMedian5.jpg');
IMG2 = imread('../Images/GeorgeMedian10.jpg');
IMG3 = imread('../Images/GeorgeMedian20.jpg');
subplot(221),imshow(IMG),title('Original')
subplot(222),imshow(IMG1),title('Median r=5');
subplot(223),imshow(IMG2),title('Median r=10');
subplot(224),imshow(IMG3),title('Median r=20');