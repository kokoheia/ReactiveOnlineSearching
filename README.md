# ReactiveOnlineSearching

## Overview
ReactiveOnlineSearching is a MVVM sample app which allows you to search iTunes music data.
This project uses the following Libraries.

- [ReacitveSwift](https://github.com/ReactiveCocoa/ReactiveSwift)
  - Streams of values over time. Tailored for Swift.
- [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
  - Reactive extensions to Cocoa frameworks, built on top of ReactiveSwift.
- [Changeset](https://github.com/osteslag/Changeset)
  - Describes the minimal edits required to go from one Collection of Equatable elements to another
  - This project use it for updating tableView data.

These are the major functions
- Reactively search and get data from iTunes API and show it on a tableView
- Reactively show search words as a title of navigation bar

## Demo
<img src="https://qiita-image-store.s3.amazonaws.com/0/241550/d021d2cc-7617-58fe-27d5-ca3ba1cfb4f2.gif">

## Reference
- [ReactiveSwift Example: Online Searching](https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Documentation/Example.OnlineSearch.md)
- [blog.joanzapata.com - MVVM + ReactiveCocoa 5](https://blog.joanzapata.com/mvvm-reactivecocoa-5/)
- [raywenderlich.com - URLSession Tutorial: Getting Started](https://www.raywenderlich.com/567-urlsession-tutorial-getting-started)
