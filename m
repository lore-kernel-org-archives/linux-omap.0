From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
Date: Fri, 8 Apr 2016 01:01:50 +0200
Message-ID: <20160407230150.GA16552@amd>
References: <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160407213229.GO16484@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > gzipped config is attached.
> > 
> > Note that I'm still using NOLO. I enabled the sleep, then went to
> > runlevel 1. LEDs still stay on, 55mA power consumption. That was with
> > 1 in off_mode.
> 
> Nothing idling for me with your .config.. And it seems slower to boot
> compared to omap2plus_defconfig? Maybe because of the extra GPIO
> interrupts?

Extra interrupts only happen when enable_off_mode is 1, so that should
not be an issue during boot.

> Looks like you have 117 additional entries in .config enabled compared
> to omap2plus_defconfig. Maybe go back to omap2plus_defconfig with minimal
> changes and verify it idles properly first?
> 
> I'm suspecting it's some driver(s) you have enabled causing the
> issue.

I guess so. Do you (or anyone else) have minimum non-modular config
for N900 that boots with video? Could I get lsmod from your system?
(Yes, I still have nightmares from getting .config that works).

Thanks and best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
