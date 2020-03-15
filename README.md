# Markovian Decision Process

This work has the goal to show how Markovian Decision Process works. We take a look how policy iteration and value iteration works. The matlab script provides visual feedback to understand how the algorithm works.

We describe a planning scenario in which we want the agent to go to a specific square of the grid while avoiding obstacles. To do so we give bigger reward to the goal square and we penalize the square corresponding to the obstacle. The actions of the robot are not deterministic. We define utility as the sum of rewards along the path. Finding the optimal policy is to find the actions that maximize utility.

## How to use

1. git clone https://github.com/StephaneSobucki/Hidden-markov-model-policy.git
2. run PolicyIteration or ValueIteration script in MATLAB

## Results

You can find results and comparison between the two differents algorithms in the report.
