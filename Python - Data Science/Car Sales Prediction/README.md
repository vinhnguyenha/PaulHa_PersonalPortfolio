A detailed project explanation would be discussed in the video below.

[Click Here for Google Drive Link to Project Explanation](https://drive.google.com/file/d/1sWZq4zgPz8RfJ5k4a2Df8ibA1cgnalou/view?usp=drive_link)

This project is about used car sales prediction. The primary objective of this project is to implement regression (a type of machine learning algorithm) in order to investigate a model that could provide 
accurate results.

In terms of accuracy, the ultimate goal is to maximize the accuracy rate (also means to minimize the percentage of prediction error). As you may or may not know, there are no models that work perfectly in every
datasets. However, there are some methods to improve the prediction performance of each model.

**1. Data Cleaning**

- Machine learning algorithms cannot directly handle categorical data, therefore all the categorical feature must be encoded as numerical values before being used as inputs.
- Missing values must be treated carefully, either to delete rows where missing values exist, or to impute mean/mode/median to replace them.
- Some numerical features (or columns) in this dataset are incorrectly formatted, so they should be converted into their correct format.

**2. Feature Engineering**

- Feature engineering is the process of selecting, manipulating and transforming raw data into features that can be used in supervised learning.
- In this project, I ranked the importance of features to understand which features (column) play the most significant role in the prediction performance. After identifying the ranking of each feature, I then
applied polynomial terms and interaction terms in order to enhance predictive power.
- In the end, I remove features which have least contribution to the prediction performance (based on the ranking).

**3. Hyperparameter Tuning**

- Hyperparameter tuning involves optimizing the settings of hyperparameters to improve the performance and accuracy of a machine learning model. Hyperparameters are parameters that are set before the learning
process begins and are not learned from the data.
- How Hyperparameter Tuning Improves Accuracy:
  + *Prevents Overfitting and Underfitting:* Properly tuned hyperparameters can help balance the bias-variance tradeoff. For instance, setting an appropriate complexity for a model (like the depth of a decision
tree) ensures that it captures the underlying patterns without overfitting to the noise in the training data.
  + *Optimizes Model Performance:* Different hyperparameters can significantly impact a model's performance. For example, the regularization parameter in ridge or lasso regression can control the amount of
shrinkage applied to coefficients, impacting both the model's accuracy and its ability to generalize.
  + *Enhances Training Efficiency:* Proper hyperparameter values can make the training process more efficient, leading to faster convergence and better use of computational resources.

After completing the above stages, I trained several regression models and compared them to understand which model provides the best prediction result.

For any enquiries, please email to havinhnguyen24@gmail.com.

Thank you for viewing my projects!
