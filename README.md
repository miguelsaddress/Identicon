# Identicon

This is a project from Udemy's course `The Complete Elixir and Phoenix Bootcamp` by [Stephen Gider](https://github.com/StephenGrider)
Given a string representing a username, Identicon will build a unique image to represent that user.

## How to run

Install the dependencies with `mix deps.get` and then, for example, inside the elixir console run:

```
iex> Identicon.main("miguelsaddress")
```
After that you should now have an image named after `miguelsaddress.png`


![Result](miguelsaddress.png)

## Generate the docs

After the dependencies have been installed, run `mix docs`

## Run the tests

Run `mix test`
