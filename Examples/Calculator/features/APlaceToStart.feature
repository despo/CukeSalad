Feature: A Place To Start
	As Harry, a calculating individual
	I want to know when my calculator is on
	So that I know when I can start calculating

Background:
	Given I have a Calculator
	When I attempt to switch on the calculator
	Then I should get the answer '0'
