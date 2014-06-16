// Generated by CoffeeScript 1.7.1
(function() {
  var DesktopManager, FlipAnimation, Manager, MobileManager, desktopManager, manager, mobileManager,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  FlipAnimation = window.FlipAnimation;

  Manager = (function() {
    function Manager() {
      this.container = document.getElementById('container');
      this.challenges = [document.getElementById('challenge1'), document.getElementById('challenge2'), document.getElementById('challenge3'), document.getElementById('challenge4')];
      this.submit = document.getElementById('submit');
      this.scoreboard = document.getElementById('scoreboard');
      this.description = document.getElementById('description');
    }

    return Manager;

  })();

  DesktopManager = (function(_super) {
    __extends(DesktopManager, _super);

    function DesktopManager() {
      DesktopManager.__super__.constructor.call(this);
      this.numFlipped = null;
    }

    DesktopManager.prototype.setup = function() {
      var challenge, i, _i, _len, _ref, _results;
      this.container.className = 'container-desktop';
      _ref = this.challenges;
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        challenge = _ref[i];
        _results.push((function(_this) {
          return function(i) {
            return challenge.onclick = function() {
              return _this.itemClicked(i);
            };
          };
        })(this)(i));
      }
      return _results;
    };

    DesktopManager.prototype.handleResize = function() {
      var cellHeight, cellWidth, image, imageSize, label, minSize, textSize, _i, _j, _len, _len1, _ref, _ref1, _results;
      cellWidth = window.innerWidth / 2;
      cellHeight = window.innerHeight / 2;
      minSize = Math.min(cellWidth, cellHeight);
      imageSize = Math.min(minSize - 100, 200);
      textSize = Math.min((cellHeight - imageSize) / 2, cellWidth / 15, 30);
      _ref = document.getElementsByClassName('challenge-image');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        image = _ref[_i];
        image.style.width = imageSize + 'px';
        image.style.height = imageSize + 'px';
        image.style.left = ((cellWidth - imageSize) / 2) + 'px';
        image.style.top = ((cellHeight - imageSize) / 2) + 'px';
      }
      _ref1 = document.getElementsByClassName('challenge-title');
      _results = [];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        label = _ref1[_j];
        label.style['font-size'] = textSize + 'px';
        _results.push(label.style.top = (cellHeight - textSize - 10) + 'px');
      }
      return _results;
    };

    DesktopManager.prototype.itemClicked = function(number) {
      var challenge, delay, end, i, start, _i, _len, _ref, _ref1, _ref2;
      if (FlipAnimation.isAnimating()) {
        return;
      }
      if (this.numFlipped != null) {
        if (this.numFlipped !== number) {
          return;
        }
        _ref = [180, 0], start = _ref[0], end = _ref[1];
      } else {
        _ref1 = [0, 180], start = _ref1[0], end = _ref1[1];
        this.moveDivs(number);
      }
      delay = 0;
      _ref2 = this.challenges;
      for (i = _i = 0, _len = _ref2.length; _i < _len; i = ++_i) {
        challenge = _ref2[i];
        if (i === number) {
          continue;
        }
        new FlipAnimation(challenge, start, end, 0.8).start(delay);
        delay += 200;
      }
      if (this.numFlipped != null) {
        return this.numFlipped = null;
      } else {
        return this.numFlipped = number;
      }
    };

    DesktopManager.prototype.moveDivs = function(idx) {
      var challenge, divs, i, index, x, _i, _len, _ref, _results;
      divs = [this.submit, this.scoreboard, this.description];
      index = 0;
      _ref = this.challenges;
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        challenge = _ref[i];
        if (i === idx) {
          continue;
        }
        x = divs[index++];
        if (x.parentElement != null) {
          x.parentElement.removeChild(x);
        }
        x.style.display = 'block';
        console.log('appending', x);
        _results.push(challenge.getElementsByClassName('back')[0].appendChild(x));
      }
      return _results;
    };

    return DesktopManager;

  })(Manager);

  MobileManager = (function(_super) {
    __extends(MobileManager, _super);

    function MobileManager() {
      MobileManager.__super__.constructor.call(this);
    }

    MobileManager.prototype.setup = function() {
      return this.container.className = 'container-mobile';
    };

    MobileManager.prototype.handleResize = function() {};

    return MobileManager;

  })(Manager);

  manager = null;

  mobileManager = null;

  desktopManager = null;

  window.onresize = function() {
    if (window.isMobileBrowser() && manager !== mobileManager) {
      manager = mobileManager;
      manager.setup();
    } else if (manager !== desktopManager) {
      manager = desktopManager;
      manager.setup();
    }
    return manager.handleResize();
  };

  window.onload = function() {
    mobileManager = new MobileManager();
    desktopManager = new DesktopManager();
    return window.onresize();
  };

}).call(this);
