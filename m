From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Tue, 12 Apr 2016 14:30:13 +0200
Message-ID: <20160412123013.GA12296@amd>
References: <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412121658.GA32486@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> > > Ok, it works now. I was doing tests in daylight so it was poorly
> > > visible. The right part of keyboard stays lit (but that's expected
> > > AFAICT), but the left part blinks.
> > 
> > During idle, both should go off and are doing so for me. Both LEDs off
> > indicates off mode, left LED off is for retention mode. So you still
> > have something blocking off mode, maybe check:
> > 
> > echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
> 
> What is the power difference between retention and off? I'm now down
> to cca 25mA, which should be around 50 hours standby time. Not ideal,
> but should be usable.
> 
> In the meantime, I found what is causing the rention mode to break for
> me: CONFIG_HSI (aka wireless modem support). With HSI off, it seems to work.
> 
> I still get problems with the camera button, in config similar to
> defconfig.  For some reason, I'm even getting (autorepeating) ^@ on
> console. As long as I hold camera button down, I even get it into off
> mode for brief period.

Ok, if I turn off CONFIG_KEYBOARD_GPIO, I get it into off
mode... once per screen blank, for about a second. (Does CONFIG_KEYBOARD_GPIO also cause
problems for you?)

Any idea why it enters off mode only once after each screenblank?

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
