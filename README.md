# Lab 11 - Counters and Dividers

In this lab, we learned how to make clock dividers from two types of counters.

## Rubric

| Item | Description | Value |
| ---- | ----------- | ----- |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |

## Names

Geordie Baksheeff and Erick Beltran

## Summary

Learning how to implement modulo counters and how to use T FlipFlops to divide clock signals

## Lab Questions

### 1 - Why does the Modulo Counter actually divide clocks by 2 * Count?

The modulo counter divides by twice the count because it only toggles the output after reaching a specified count. It takes one full count to change the output, and another full clock to change it back. And a full clock cycle needs both to change.

### 2 - Why does the ring counter's output go to all 1s on the first clock cycle?

The flip-flops are connected so that each stage uses the previous stage's output.

### 3 - What width of ring counter would you use to get to an output of ~1KHz?

The Basys board uses 100MHz 

100,000,000 / 2^n = 1000

You would need a 17-bit ripple counter to get 762Hz, which is closer to 1KHz than 16-bit

