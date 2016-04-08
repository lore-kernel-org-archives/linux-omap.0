From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
Date: Fri, 8 Apr 2016 11:19:35 +0200
Message-ID: <20160408091934.GA15221@amd>
References: <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160407234134.GQ16484@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > Looks like you have 117 additional entries in .config enabled compared
> > > to omap2plus_defconfig. Maybe go back to omap2plus_defconfig with minimal
> > > changes and verify it idles properly first?
> > > 
> > > I'm suspecting it's some driver(s) you have enabled causing the
> > > issue.
> > 
> > I guess so. Do you (or anyone else) have minimum non-modular config
> > for N900 that boots with video? Could I get lsmod from your system?
> > (Yes, I still have nightmares from getting .config that works).
> 
> Well I've been just using omap2plus_defconfig with:
> 
> # modprobe tsc2005
> # modprobe gpio_backlight
> # modprobe panel_sony_acx565akm
> # modprobe omapfb
> 
> # echo 255 > /sys/class/backlight/acx565akm/brightness
> 
> And then the following to blank for idle:
> 
> # echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
> 
> But in the world of eternal regressions, I'm not seeing anything
> on the framebuffer with v4.6-rc2 :( No idea what broke it or when
> as my n900 is in the rack.

Well, for the record, framebuffer works in my config with v4.6-rc2. So
that is another config issue. Hopefully it is not the same issue ;-).

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
