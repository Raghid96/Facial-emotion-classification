## Import the packages needed for the crossvalidation, classifier and numpy
from mat4py import loadmat
import numpy as np
import scipy.io as sio
## Cross validation
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.model_selection import GridSearchCV
## Plotting tools
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings("ignore")
warnings.filterwarnings(action='ignore',category=DeprecationWarning)
warnings.filterwarnings(action='ignore',category=FutureWarning)
## Training and accuracy
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
## Confusion matrix packages
from sklearn.metrics import confusion_matrix
from sklearn.metrics import plot_confusion_matrix
## Package of the classifiers
from sklearn.ensemble import AdaBoostClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC


## Loading the input data from matlab file
data_X = loadmat('X_big.mat') # The input matrix with [features x # of emotions] 


## READING THE LABELS FROM A TEXT FILE
contents = []
f=open("lables.txt", "r")
if f.mode == 'r':
    line =f.read()
    contents.append(line.split('\n'))


y_input = [] # The input labels
for i in range(0,405):
    
    if contents[0][i].split(' ')[1] == " ":
         y_input.append("tom")
    else:
         y_input.append(contents[0][i].split(' ')[1])

## The name of all the classes = emotions
class_names = ["Anger","Disgust","Fear","Happy","Sadness","Surprise"]



# Split the data into training and test set
train_set_attr, test_set_attr, train_set_class, test_set_class = train_test_split(data_X['mat'], y_input, test_size = 0.20)


##---------------------Cross validation KNN--------------
# ada=KNeighborsClassifier()
# search_grid={'n_neighbors':[2,3,4,5],'leaf_size':[10,20,30,40],'p':[1,2,3,4,5]}
# crossvalidation= KFold(n_splits=10,shuffle=True,random_state=1)
# search = GridSearchCV(estimator = ada, param_grid=search_grid, scoring='accuracy' ,n_jobs=1,cv= crossvalidation)
# search.fit(data_X['mat'],y_input)
# print(search.best_params_)

##------------------------TRAINING KNN------------------------
classifier_knn = KNeighborsClassifier(n_neighbors=5, leaf_size=10, p=2)
classifier_knn.fit(train_set_attr,train_set_class)
pred = classifier_knn.predict(test_set_attr)


##------------------------KNN Confusion Matrix---------------
np.set_printoptions(precision=2)
# Plot non-normalized confusion matrix
titles_options = [("Confusion matrix, without normalization KNN", None),
                  ("Normalized confusion matrix KNN", 'true')]
for title, normalize in titles_options:
    disp = plot_confusion_matrix(classifier_knn, test_set_attr, test_set_class,
                                 display_labels=class_names,
                                 cmap=plt.cm.Blues,
                                 normalize=normalize)
    disp.ax_.set_title(title)

    print(title)
    print(disp.confusion_matrix)

plt.show()


# #------------------- Cross validation SVC -----------------------------
# svc_clf=SVC()
# search_grid={ : [1, 3, 5, 10], 'kernel': ['linear', 'rbf', 'poly']} #'degree': [1, 3, 5]} #, 'gamma' : [0.1, 1, 10, 100]} #: [0.1, 1, 10, 100, 1000],}
# crossvalidation= KFold(n_splits=10,shuffle=True,random_state=1)
# search = GridSearchCV(estimator = svc_clf, param_grid=search_grid, scoring='accuracy' ,n_jobs=1,cv= crossvalidation)
# search.fit(data_X['mat'],y_input)
# print(search.best_params_)


# # #-----------------TRAINING SVC--------------------------
clf_svc = SVC(C=1.0, kernel='rbf', degree=3, gamma='scale')
clf_svc.fit(train_set_attr, train_set_class)
pred_svc = clf_svc.predict(test_set_attr)

##---------------------confusion matrix SVC---------------------
np.set_printoptions(precision=2)
titles_options = [("Confusion matrix, without normalization SVC", None),
                  ("Normalized confusion matrix SVC", 'true')]
for title, normalize in titles_options:
    disp = plot_confusion_matrix(clf_svc, test_set_attr, test_set_class,
                                 display_labels=class_names,
                                 cmap=plt.cm.Blues,
                                 normalize=normalize)
    disp.ax_.set_title(title)
    print(title)
    print(disp.confusion_matrix)
plt.show()


##---------------Cross validation Randomforest-------------
# ada=RandomForestClassifier()
# search_grid={'n_estimators':[100,500,1000,1500], 'criterion':['gini', 'entropy']}
# crossvalidation= KFold(n_splits=10,shuffle=True,random_state=1)
# search = GridSearchCV(estimator = ada, param_grid=search_grid, scoring='accuracy' ,n_jobs=1,cv= crossvalidation)
# search.fit(data_X['mat'],y_input)
# print(search.best_params_)


# ##-----------------Random Forest----------------
clf_randf = RandomForestClassifier(n_estimators=2000,max_depth=6, criterion='entropy')
clf_randf.fit(train_set_attr, train_set_class)
pred_randf = clf_randf.predict(test_set_attr)

##----------------Confusion Matrix RandomFores--------------
np.set_printoptions(precision=2)
titles_options = [("Confusion matrix, without normalization Random Forest", None),
                  ("Normalized confusion matrix Random Forest", 'true')]
for title, normalize in titles_options:
    disp = plot_confusion_matrix(clf_randf, test_set_attr, test_set_class,
                                 display_labels=class_names,
                                 cmap=plt.cm.Blues,
                                 normalize=normalize)
    disp.ax_.set_title(title)
    print(title)
    print(disp.confusion_matrix)
plt.show()

##-----------------ADA cross validation--------------------
# ada=AdaBoostClassifier()
# search_grid={'n_estimators':[100,500,1000,1500], 'learning_rate' :[0.01, 0.1, 0.3,0.7, 1]}
# crossvalidation= KFold(n_splits=10,shuffle=True,random_state=1)
# search = GridSearchCV(estimator = ada, param_grid=search_grid, scoring='accuracy' ,n_jobs=1,cv= crossvalidation)
# search.fit(data_X['mat'],y_input)
# print(search.best_params_)



##------------------Ada boost ----------------
clf_ada = AdaBoostClassifier(n_estimators=500, learning_rate=0.7, random_state=0)
clf_ada.fit(train_set_attr, train_set_class)
pred_ada = clf_ada.predict(test_set_attr)

# ##------------------Ada boost Confusion Matrix-----------
np.set_printoptions(precision=2)
titles_options = [("Confusion matrix, without normalization Ada boost", None),
                  ("Normalized confusion matrix Ada boost", 'true')]
for title, normalize in titles_options:
    disp = plot_confusion_matrix(clf_ada, test_set_attr, test_set_class,
                                 display_labels=class_names,
                                 cmap=plt.cm.Blues,
                                 normalize=normalize)
    disp.ax_.set_title(title)
    print(title)
    print(disp.confusion_matrix)
plt.show()


