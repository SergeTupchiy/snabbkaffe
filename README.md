Snabbkaffe
==========

[Check documentation for the latest version.](https://kafka4beam.github.io/snabbkaffe-docs)

Snabbkaffe is a trace-based test framework for Erlang.

It works like this:

 1) Programmer manually instruments the code with trace points
 2) Testcases are split in two parts:
    - *Run stage* where the program runs and emits event trace
    - *Check stage* where trace is collected and validated against the
      spec(s)
 3) Trace points become ordinary log messages in the release build

This approach can be used in a component test involving an ensemble of
interacting processes. It has a few nice properties:

 + Checks can be separated from the program execution
 + Checks are independent from each other and fully composable
 + Trace contains complete history of the process execution, thus
   making certain types of concurrency bugs, like livelocks, easier to
   detect

## Getting started
