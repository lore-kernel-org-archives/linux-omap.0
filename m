From: Pavel Machek <pavel@ucw.cz>
Subject: Re: "advanced" LED controllers
Date: Wed, 25 Feb 2015 22:49:41 +0100
Message-ID: <20150225214940.GA29527@amd>
References: <20150219211424.GN13603@saruman.tx.rr.com>
 <20150223223457.GA4073@amd>
 <20150223225836.GB4355@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150223225836.GB4355@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon 2015-02-23 16:58:36, Felipe Balbi wrote:
> On Mon, Feb 23, 2015 at 11:34:57PM +0100, Pavel Machek wrote:
> > On Thu 2015-02-19 15:14:24, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > Do we have support for LED controllers which can handle patterns of
> > > different kinds ? I mean, currently, if we have an LED controller such
> > > as TPIC2810 [1] which can control 8 different leds and each LED
> > > corresponds to one bit on register 0x44, we could control leds by just
> > > "playing" a wave file on the controller and create easy patterns with
> > > that.

> > > [1] http://www.ti.com/product/tpic2810
> > > 
> > > ps: tpic2810 is probably the simplest example, lp551, lp5523 and others
> > > have even more advanced pattern engines which can even handle RGB leds.
> > 
> > Well... some more advanced pattern engines can actually run code, up
> > to and including prime number computation. So yes, this is complex,
> > and how to handle it nicely is a question...
> > 
> > I have "notcc" to compile for that.
> 
> right, the point is that this is a solution which only works with lp5523
> and IMO linux led subsystem should do a little more for such devices.

Well, question is what we want. Possibilities I see:

1) We won't support all the features, just some common subset. Kernel
will get commands for LED controller and translate them. Question is
what reasonable subset is, then.

I guess "delay", "set led brightness to X", "jump" would be minimal
shared command set. lp5523 can do also "slowly increase/decrease
brightness to X" (I believe we should support that one), arithmetics,
conditional jumps, and communications between 3 threads.

2) We want to support all the features. I guess that would mean doing
compilation in userspace, and having "compiler" for each led
controller. Having common source code would still be nice.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
