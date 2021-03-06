Strut
=======

#### GUI / Authoring Tool for ImpressJS ####

This project intends to create an extensible, maintainable, and clean editor for authoring ImpressJS presentations.
I hope this project can also serve as an example of a browser based rich client as the project matures.

### Prior Art ###

Whats the difference between ```Strut``` and ```Impressionist```?
From a developer's perspective, everything.  

In ```Strut``` there is an object for each major component.  The 
[Slides](https://github.com/tantaman/Strut/blob/master/client/src/coffee/model/presentation/Slide.coffee), 
[SlidePreviews](https://github.com/tantaman/Strut/blob/master/client/src/coffee/ui/editor/TransitionSlideSnapshot.coffee), 
[TransitionEditor](https://github.com/tantaman/Strut/blob/master/client/src/coffee/ui/editor/TransitionEditor.coffee), 
[SlideEditor](https://github.com/tantaman/Strut/blob/master/client/src/coffee/ui/editor/SlideEditor.coffee),
etc. all have their own objects so its easy to
track down and make changes to a component.  ```Strut``` uses [RequireJS](http://requirejs.org/) to keep source files small and
focused.  [BackboneJS](http://documentcloud.github.com/backbone/) is used for ```Strut's``` data model and serialization as well as for binding events in the 
view layers.  

In addition to having organized code, the [markup for Strut](https://github.com/tantaman/Strut/tree/master/client/web/scripts/ui/editor/res/templates) is also 
split up by component and placed in [HandlebarsJS](http://handlebarsjs.com/) template files. 

### Preview ###

A github hosted preview is available at: http://tantaman.github.com/Strut/client/web/index.html

The preview currently points to the development version of Strut.

Current features:

 * Slide creation
 * Text & image insertion
 * Text and image manipulation (skew, rotate, scale)
 * Fonts and font styles
 * Undo/Redo for some operations
 * Transition configuration
 * ImpressJS preview generation

### Building ###

Most of Strut is written in Coffeescript and uses precompiled templates for HTML rendering.

To compile the CoffeeScript

1. Install CoffeeScript (npm install coffeescript)
2. cd to the Strut/client directory
3. run `rake compileCoffee[w]`  (omit [w] to not watch for changes)

To compile the templates

1. Install Handlebars (npm install handlebars)
2. cd to the Strut/client directory
3. run `rake compileTpls`

Navigate to client/web/index.html to view Strut.

### Contributing ###

Here is the basic layout of the source:

* Presentation Model: src/coffee/model/presentation
* Editor UI Layer: src/coffee/ui/editor
* Model -> ImpressJS Rendering: src/coffee/ui/impress_renderer

templates for UI components are contained in web/scripts/ui/COMPONENT_NAME/res/templates
in order to package related markup and backing UI (not model) code into modules.

### Acknowledgements ###

* Impressionist https://github.com/hsivaramx/Impressionist
* ImpressJS (of course) https://github.com/bartaz/impress.js/
* BackboneJS http://documentcloud.github.com/backbone/
* CoffeeScript http://coffeescript.org/
* RequireJS http://requirejs.org/
* JQuery http://jquery.com/
* Rake http://rubyforge.org/projects/rake/
* HandlebarsJS http://handlebarsjs.com/
* DustJS http://akdubya.github.com/dustjs/
* Class class http://ejohn.org/blog/simple-javascript-inheritance/