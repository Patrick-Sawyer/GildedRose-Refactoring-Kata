# Gilded Rose

Here is my attempt to solve the Gilded Rose challenge. Here is the original repo for the challenge. Run rspec in the root directory to see test results.

https://github.com/makersacademy/course/blob/master/individual_challenges/gilded_rose.md

## Approach

For this challenge I realised you just needed to execute the 'update_quality' method twice when an item was conjured in most cases. So i exctracted the code from within the for loop in this method to another method, which i called update. I passed the item as an argument to this method. When an item was conjured the update method was called twice, with the sell_in day increasing by 1 just before hand as it would still be the same day. I had to write some other code to deal with Sulfuras, to make sure the sell_in did not change.

The most challenging part was the tests for the Backstage pass tickets, as the amount the quality changes varies. I wrote quite long tests for these, checking the quality changed the right amount.

I also tested edge cases, no quality goes above 50, backstage pass tickets drop to 0 after the concert etc.

I tested all 'special' item types, when both conjured and non conjured.

Ideally I would have used doubles for the items but I couldn't get the values of the doubles to change when the code tried to change them. Also, part of the challenge specified that we were not to touch the Item Class at all, so I felt it was OK to use Item instances in the tests for the Gilded Rose class.
