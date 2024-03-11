from pyspark import SparkContext

# Create a SparkContext
sc = SparkContext("local", "RDD Example")
# Create an RDD with employee data
employee_data_rdd = sc.parallelize(
    [
        (1, "John Doe", 50000, "HR"),
        (2, "Jane Smith", 60000, "HR"),
        (3, "Michael Johnson", 75000, "Dev"),
        (4, "Emily Brown", 70000, "Dev"),
        (5, "David Lee", 80000, "Test"),
    ]
)

# Extract salaries
salaries_rdd = employee_data_rdd.map(lambda x: x[2])
# Calculate the total salary
total_salary = salaries_rdd.reduce(lambda x, y: x + y)
print(total_salary)
# Adjust required key and value
DeptsSalaries = employee_data_rdd.map(lambda x: (x[3], x[2]))
# calculate total salary per each key
DeptsSalariesGroup = DeptsSalaries.reduceByKey(lambda x, y: x + y)
# Different ways of printing the result
# 1. Using collect
print(DeptsSalariesGroup.collect())
# 2. Using for loop
for row in DeptsSalariesGroup.collect():
    print(row)

# 3. Using for loop with tuple unpacking
for e, s in DeptsSalariesGroup.collect():
    print(f"Dept. {e} has total salaries {s}")
