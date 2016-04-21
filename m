From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Thu, 21 Apr 2016 23:28:08 +0200
Message-ID: <20160421212808.GA31979@amd>
References: <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160421130450.GQ29406@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> > CONFIG_HSI breaks power management completely, so power management
> > with modem will be another topic.  
> 
> Sebastian, any idea why power management does not work for HSI?
> 
> > > > > In the meantime, I found what is causing the rention mode to break for
> > > > > me: CONFIG_HSI (aka wireless modem support). With HSI off, it seems to work.
> > > > > 
> > > > > I still get problems with the camera button, in config similar to
> > > > > defconfig.  For some reason, I'm even getting (autorepeating) ^@ on
> > > > > console. As long as I hold camera button down, I even get it into off
> > > > > mode for brief period.
> > > > 
> > > > Ok, if I turn off CONFIG_KEYBOARD_GPIO, I get it into off
> > > > mode... once per screen blank, for about a second. (Does CONFIG_KEYBOARD_GPIO also cause
> > > > problems for you?)
> > > > 
> > > > Any idea why it enters off mode only once after each screenblank?
> > > 
> > > After disabling CONFIG_PROVE_LOCKING, loading the LCD modules, and
> > > blanking the screen, my n900 hits off mode just fine about once
> > > a second. Sounds like you still have some extra devices enabled
> > > causing it.
> > 
> > I checked again... also with vanilla 4.6-rc2 to double check... same effect.
> > 
> > Aha, got it... cat-ing /sys/kernel/debug/pm_debug/count breaks the
> > off mode. If I don't do that (tm), it seems to work way better.
> 
> So what is result? Is power management working for CONFIG_KEYBOARD_GPIO?

camera and unlock button GPIOs seem to break the powermanagement,
too. I disabled it for now.

Next hint I got from Sebastian was that I may need to enable power
management in /sys.

pavel@n900:/my/tui/ofone$ cat
/sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/runtime_status
active
pavel@n900:/my/tui/ofone$ cat
/sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/autosuspend_delay_ms
cat:
/sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/autosuspend_delay_ms:
Input/output error
root@n900:/my/tui/ofone# cat
/sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/control
auto

I could not get it to sleep :-(.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
