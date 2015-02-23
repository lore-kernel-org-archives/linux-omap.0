From: Pavel Machek <pavel@ucw.cz>
Subject: Re: "advanced" LED controllers
Date: Mon, 23 Feb 2015 23:34:57 +0100
Message-ID: <20150223223457.GA4073@amd>
References: <20150219211424.GN13603@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150219211424.GN13603@saruman.tx.rr.com>
Sender: linux-leds-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu 2015-02-19 15:14:24, Felipe Balbi wrote:
> Hi,
> 
> Do we have support for LED controllers which can handle patterns of
> different kinds ? I mean, currently, if we have an LED controller such
> as TPIC2810 [1] which can control 8 different leds and each LED
> corresponds to one bit on register 0x44, we could control leds by just
> "playing" a wave file on the controller and create easy patterns with
> that.
> 
> AFAICT, in linux today we would have to register each of the 8 LEDs as a
> different LED and have driver magic to write the proper bits on register
> 0x44, that seems a bit overkill, specially when we want to make
> patterns: instead of writing 0xff we would have to write 0x80, 0x40,
> 0x20, 0x10, 0x08, 0x04, 0x02, 0x01 separately and have the driver cache
> the previous results so we don't end up switching off other LEDs.
> 
> IOW, what could be handled with a single write, currently needs 8.
> 
> I wonder if there's any work happening to support these slightly more
> inteligent LED engines.
> 
> regards
> 
> [1] http://www.ti.com/product/tpic2810
> 
> ps: tpic2810 is probably the simplest example, lp551, lp5523 and others
> have even more advanced pattern engines which can even handle RGB leds.

Well... some more advanced pattern engines can actually run code, up
to and including prime number computation. So yes, this is complex,
and how to handle it nicely is a question...

I have "notcc" to compile for that.

#!/usr/bin/python3
#
# NOTification Compiler
#
# for LP5523 chip.
#
# Copyright 2014 Pavel Machek <pavel@ucw.cz>, GPLv3
#
# http://wiki.maemo.org/LED_patterns#Lysti_Format_Engine_Patterns_and_Commands
# http://www.ti.com/general/docs/lit/getliterature.tsp?genericPartNumber=lp5523&fileType=pdf
#
# Seems to have A,B local variables, C global variable,
#
# 2.6.28-omap1 seems to cut execution after 16 steps.

import sys



									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
