module Network.Neuron
( Neuron(..)

, ActivationFunction
, ActivationFunction'
, sigmoidNeuron
, tanhNeuron
, recluNeuron

, sigmoid
, sigmoid'
, tanh
, tanh'
, reclu
, reclu'
, input
) where

-- | Using this structure allows users of the library to create their own
--   neurons by creating two functions - an activation function and its
--   derivative - and packaging them up into a neuron type.
data Neuron a = Neuron { activation :: (ActivationFunction a)
                       , activation' :: (ActivationFunction' a)
                       }

type ActivationFunction a = a -> a
type ActivationFunction' a = a -> a

-- | Our provided neuron types: sigmoid, tanh, reclu
sigmoidNeuron :: (Floating a) => Neuron a
sigmoidNeuron = Neuron sigmoid sigmoid'

tanhNeuron :: (Floating a) => Neuron a
tanhNeuron = Neuron tanh tanh'

recluNeuron :: (Floating a) => Neuron a
recluNeuron = Neuron reclu reclu'

-- | The sigmoid activation function, a standard activation function defined
--   on the range (0, 1).
sigmoid :: (Floating a) => a -> a
sigmoid t = 1 / (1 + exp (-1 * t))

-- | The derivative of the sigmoid function conveniently can be computed in
--   terms of the sigmoid function.
sigmoid' :: (Floating a) => a -> a
sigmoid' t = s * (1 - s)
              where s = sigmoid t

-- | The hyperbolic tangent activation function is provided in Prelude. Here
--   we provide the derivative. As with the sigmoid function, the derivative
--   of tanh can be computed in terms of tanh.
tanh' :: (Floating a) => a -> a
tanh' t = 1 - s ^ 2
               where s = tanh t

-- | The rectified linear activation function. This is a more "biologically
--   accurate" activation function that still retains differentiability.
reclu :: (Floating a) => a -> a
reclu t = log (1 + exp t)

-- | The derivative of the rectified linear activation function is just the
--   sigmoid.
reclu' :: (Floating a) => a -> a
reclu' t = sigmoid t

-- | Input neurons
input :: (Floating a) => a -> a
input t = t
