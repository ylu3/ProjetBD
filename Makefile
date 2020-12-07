all: testInsertionJDBC testSelectionJDBC testSuppressionJDBC exeTestInsertionJDBC exeTestSelectionJDBC exeTestSuppressionJDBC

testInsertionJDBC:
	javac -d bin -classpath ./bin:./bin/ojdbc6.jar -sourcepath src src/TestInsertionJDBC.java

exeTestInsertionJDBC:
	java -classpath ./bin:./bin/ojdbc6.jar TestInsertionJDBC


testSelectionJDBC:
	javac -d bin -classpath ./bin:./bin/ojdbc6.jar -sourcepath src src/TestSelectionJDBC.java

exeTestSelectionJDBC:
	java -classpath ./bin:./bin/ojdbc6.jar TestSelectionJDBC


testSuppressionJDBC:
	javac -d bin -classpath ./bin:./bin/ojdbc6.jar -sourcepath src src/TestSuppressionJDBC.java

exeTestSuppressionJDBC:
	java -classpath ./bin:./bin/ojdbc6.jar TestSuppressionJDBC