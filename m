From: David Brownell <david-b@pacbell.net>
Subject: Re: GPIO switch framework (was: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update)
Date: Sun, 21 Dec 2008 12:26:14 -0800
Message-ID: <200812211226.14555.david-b@pacbell.net>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com> <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com> <1229600573.5895.432.camel@jani-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:34134 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751142AbYLUU0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Dec 2008 15:26:17 -0500
In-Reply-To: <1229600573.5895.432.camel@jani-desktop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Juha =?iso-8859-1?q?Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, Brian Swetland <swetland@google.com>, lockwood@android.com

On Thursday 18 December 2008, Jani Nikula wrote:
> On Tue, 2008-12-16 at 11:35 +0530, ext Trilok Soni wrote:
> 
> > OK, I found other guys (android ??) using such home brew frameworks.
> > Time to write a switch framework.
> 
> To start a discussion on what such a GPIO switch framework should be
> like if someone were to write it, here's a list of the kind of things
> I'd like to see in it (mostly from gpio-switch.c):
> 
> * Based on or integrated in the gpiolib.

As noted earlier:  such a thing should be a "switch" framework,
with "gpio" just on implementation.  Not every switch will be
implemented as a GPIO.


> * Dynamically changeable notification callbacks in kernel.

Not clear what this means.  Reconfigure the switch type
on the fly?  I'm not a big fan of the event namespace
which <linux/notifier.h> defines, I hope that's not what
is meant here ... though maybe its callback model is OK,
adding and removing callbacks is easy enough.

Current OMAP gpio-switch has a single callback, and
that might be part of the problem.  Linux has a single
callback for things like timers and request completions;
but these switches have different lifecycle model.

Decoupling caller/switch and callee(s)/callbacks() may
provide a better model.


> * Sysfs notifications to userspace.

Why sysfs in particular, rather than some /dev/input/*
event channel?  Note that input devices already decouple
the event reporters and event receivers fairly well.


> * Debouncing for the notifications to filter spurious events.
> 
> * Dynamically adjustable debounce timeouts.

Debouncing might not be a framework issue; at first
thought, it seems like something the GPIO glue into
that framework might need to handle.


> * Arbitrary names for the GPIOs in sysfs instead of (or in addition to)
> the gpiolib style "gpioN".

This mostly sounds to me like an input device...

Except maybe for the notion that in-kernel software
needs to be responsive to the events too.  I seem to
recall "push those policies to userspace" arguments
cropping up in similar cases.  (My two cents:  kernel
is full of policy, sometimes reconfigurable; easy to
believe system integrity can require a few more.)


> Anything else? I didn't see anything in the Android source that couldn't
> be covered with this.

The Android stuff seems already split into a class
and GPIO glue.  (Hence my CC to Mike Lockwood, the
author of that drivers/switch code.)

Any reason you couldn't use that as-is, maybe after
updating it a bit?  Add some GPIO debouncing, use
input framework not miscdev in the core, different
headset issues, etc.

- Dave


> 
> 
> Jani.
> 
> 
> 


