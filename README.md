## Overview

This is the code for [this](https://youtu.be/J9kbZ5I8gdM) video on Youtube by Siraj Raval on how to build a biomedical startup. I basically saw [these](https://github.com/re-search/DocProduct) Colab demos of this BioBERT model answering medical questions pretty acurately and got hype. I thought, why not apply [this](https://github.com/rxlabz/sytody) type of interface to that as a backend, paywall it, and hey! You've got yourself a business, serving the underserved st scale at a very low cost. This app works, but there are still TODOs, i'll list them below. 

## Usage

Install [flutter](http://flutter.io). Then, install all dependencies and run using these commands. I prefer running it using Android Studio, but terminal works too. 

```bash
flutter packages get
flutter run
```

:tv: [Video demo](https://youtu.be/7MGuNZfgGWw)

## TODOs - Make a PR if you fix any

- Take the model [here](https://colab.research.google.com/drive/11hAr1qo7VCSmIjWREFwyTFblU2LVeh1R) and integrate it into the app. My previous healthcare [app](https://github.com/llSourcell/How_to_Build_a_healthcare_startup) nicely integrated tensorflow lite. 
- Parse the input using keyword recognition. You can use an existing API like [this](https://www.twinword.com/api/text-classification.php) to categorize words as symptoms, medications, or side effects. Train a new model on a health dataset for the most accuracy, have it learn to classify those 3 keywords from a given corpus. Once the input is parsed properly into those categories, it can be fed into the existing model. 
- Finish Integrating Firebase
- Finish Integrating Payments

## Credits

[rxlabs](https://github.com/rxlabz/sytody) and the Doc Product team. Also the Flutter team. 
