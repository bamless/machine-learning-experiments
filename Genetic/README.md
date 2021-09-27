# Genetic algorithm

In this experiment we simulate a game of snake and train a snake to move around using a simple
genetic algorithm on neural a multi-layer neural network.

Given the simplicity of the algorithm it may take a bit of time to converge to an optimal solution.
The simulation will automatically restart if progress has plateaued and no significant improvements 
have been made for a while.

Controls:
 - Press `f` to speed up the simulation
 - Press `s` to run the simulation at a slow pace
 - Press `a` to toggle between viewing all the snakes or one at a time
 - Press `b` toggle to show the current best snake in the simulation (i.e. the one with max fitness)

If you want, you can mess around with hyperparameters in the code to see how the simulation is
affected when they're changed. The most important ones are:
 - The function that calculates the fitness of a snake: found in `NeuralNetSnake.computeFitness()`.
 - The number of layers of the neural network controlling each snake: found in the constructor of
   `NeuralNetSnake`. You can change the activation function too, as it's defined as a generic
   interface that can be swapped out.