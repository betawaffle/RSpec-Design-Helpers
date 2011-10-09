RSpec-Design-Helper is a gem that enhances RSpec for the simple first steps of BDD.

When the need for a class first appears, you can easily generate failing specs that describe the interface to your class.

## implements
Specifies that the `subject` must implement the specified methods.

**Use When**: You are designing the class, and you want to ensure that it exposes
  a field with a method implementation.

```ruby
class FailingUser
end

class PassingUser
  def name
    'Billy Chatteroonski'
  end
end

describe FailingUser do
  implements :name # One spec fails. A FailingUser.new does not have a :new method
end

describe PassingUser
  implements :name # One spec passes. A PassingUser.new has a :new method.
end
```

## class_implements
Specifies that the `described_class` must implement the specified methods.

**Use When**:

```ruby
class FailingUser
end

class PassingUser
  def species
    Human
  end
end

describe FailingUser do
  class_implements :species # fails one spec.
end

describe PassingUser do
  class_implements :species # passes one spec.
end
```

# Persistent Classes (a.k.a. Models)

## is_persistible
Specifies that instances of `described_class` respond to `save`, `save!` and `reload`

**Use When**:

```ruby
```

## persists
Specifies that the `subject` is able to assign a sample value, save itself, then reload itself.

**Use When**:

```ruby
```
