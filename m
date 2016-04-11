From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
Date: Mon, 11 Apr 2016 11:41:30 +0200
Message-ID: <20160411094130.GA5753@amd>
References: <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160411093023.GC11814@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > > > gzipped config is attached.
> > > > > 
> > > > > Note that I'm still using NOLO. I enabled the sleep, then went to
> > > > > runlevel 1. LEDs still stay on, 55mA power consumption. That was with
> > > > > 1 in off_mode.
> > > > 
> > > > Nothing idling for me with your .config.. And it seems slower to boot
> > > > compared to omap2plus_defconfig? Maybe because of the extra GPIO
> > > > interrupts?
> > > 
> > > Extra interrupts only happen when enable_off_mode is 1, so that should
> > > not be an issue during boot.
> > 
> > OK maybe it's just the extra driver probe time then.
> 
> Ok, I did try to minimize config differences. I'm still booting from
> NOLO. Now I'm doing the tests from init=... boot. idlest1_core
> blocking bits says 0042. But the LEDs still don't blink.
> 
> I made config with pretty minimal differences from defconfig (making
> required drivers =y, lockdep off so that video works).
> 
> Do you think you could try with my config?

Ok, it works now. I was doing tests in daylight so it was poorly
visible. The right part of keyboard stays lit (but that's expected
AFAICT), but the left part blinks.

Thanks!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
