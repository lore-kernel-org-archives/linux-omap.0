From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: GPIO switch framework (was: Re: [PATCH] ARM: OMAP: Add support for
	dynamic GPIO switch update)
Date: Thu, 18 Dec 2008 13:42:53 +0200
Message-ID: <1229600573.5895.432.camel@jani-desktop>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215134010.GA10709@mail.solidboot.com>
	 <1229352752.5895.325.camel@jani-desktop>
	 <20081215152920.GA11007@mail.solidboot.com>
	 <1229356723.5895.348.camel@jani-desktop>
	 <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17697 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYLRLru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 06:47:50 -0500
In-Reply-To: <5d5443650812152205k4d6c7back8bae8aa61487eb6c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: ext Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Tue, 2008-12-16 at 11:35 +0530, ext Trilok Soni wrote:

> OK, I found other guys (android ??) using such home brew frameworks.
> Time to write a switch framework.

To start a discussion on what such a GPIO switch framework should be
like if someone were to write it, here's a list of the kind of things
I'd like to see in it (mostly from gpio-switch.c):

* Based on or integrated in the gpiolib.

* Dynamically changeable notification callbacks in kernel.

* Sysfs notifications to userspace.

* Debouncing for the notifications to filter spurious events.

* Dynamically adjustable debounce timeouts.

* Arbitrary names for the GPIOs in sysfs instead of (or in addition to)
the gpiolib style "gpioN".

Anything else? I didn't see anything in the Android source that couldn't
be covered with this.


Jani.


