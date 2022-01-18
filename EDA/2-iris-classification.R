####################################
# https://www.youtube.com/watch?v=dRqtLxZVRuw&ab_channel=DataProfessor #
# http://github.com/dataprofessor  #
####################################

# Importing libraries
library(datasets) # Contains the Iris data set
library(caret) # Package for machine learning algorithms / CARET stands for Classification And REgression Training

dir = dirname(rstudioapi::getSourceEditorContext()$path)
setwd(dir)
getwd()
# Importing the Iris data set
data(iris)

# Check to see if there are missing data?
sum(is.na(iris))


# To achieve reproducible model; set the random seed number
set.seed(100)

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(iris$Species, p=0.8, list = FALSE)
TrainingSet <- iris[TrainingIndex,] # Training Set
TestingSet <- iris[-TrainingIndex,] # Test Set

# Compare scatter plot of the 80 and 20 data subsets

plot(TrainingSet, main = "Training Set", col= "red")
plot(TestingSet, main = "Testing Set", col= "red")

# better visualization
library(cowplot)
p1<-ggplot(TrainingSet, aes(Sepal.Length, Sepal.Width))+ geom_point()
p2<-ggplot(TestingSet, aes(Sepal.Length, Sepal.Width))+ geom_point()
plot_grid(p1, p2, labels = "AUTO")


###############################
# SVM model (polynomial kernel)

# Build Training model
Model <- train(Species ~ ., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit, # if there is  missing value, will be deleted.
               preProcess=c("scale","center"), # scale data by mean centering
               trControl= trainControl(method="none"),
               tuneGrid = data.frame(degree=1,scale=1,C=1)
)

# Build CV model
# see for Cross Validation explanation https://youtu.be/dRqtLxZVRuw?t=625
Model.cv <- train(Species ~ ., data = TrainingSet,
                  method = "svmPoly",
                  na.action = na.omit,
                  preProcess=c("scale","center"),
                  trControl= trainControl(method="cv", number=10),
                  tuneGrid = data.frame(degree=1,scale=1,C=1)
)


# Apply model for prediction
Model.training <-predict(Model, TrainingSet) # Apply model to make prediction on Training set
Model.testing <-predict(Model, TestingSet) # Apply model to make prediction on Testing set
Model.cv <-predict(Model.cv, TrainingSet) # Perform cross-validation

# Model performance (Displays confusion matrix and statistics)
Model.training.confusion <-confusionMatrix(Model.training, TrainingSet$Species)
Model.testing.confusion <-confusionMatrix(Model.testing, TestingSet$Species)
Model.cv.confusion <-confusionMatrix(Model.cv, TrainingSet$Species)

print(Model.training.confusion)
print(Model.testing.confusion)
print(Model.cv.confusion)

# Feature importance
# https://youtu.be/dRqtLxZVRuw?t=1040
Importance <- varImp(Model)
plot(Importance)
plot(Importance, col = "red")
