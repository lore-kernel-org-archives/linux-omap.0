From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.4: camera and unlock buttons produce tons of interrupts (was
 Re: N900 sleep mode)
Date: Thu, 7 Apr 2016 10:40:20 -0700
Message-ID: <20160407174019.GM16484@atomide.com>
References: <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160405205137.GA10196@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [160405 13:52]:
> Hi!
> 
> > > Ok, I realized that _something_ set up my keyboard on console, too, so
> > > I'm able to do "init 1" and still interact with the console.
> > > 
> > > cm_idlest1_core blocking bits are now 0x42 pretty consistently. But
> > > they stay 0x42, even when screen is on (and screen on prevents low
> > > power, right?) so I guess they are not the whole story.
> > 
> > Yes they stay at 0x42. And it seems you've configured the UART
> > idle timeouts too.
> 
> Yes, thanks for the script ;-).
> 
> > > I'm able to get down to 50mA power consumption with screen off. I was
> > > getting 90mA with X, wifi in powersave and screen off.
> > > 
> > > Head proximity sensor is still on in this configuration. But I guess
> > > that should not keep the system busy...?
> > > 
> > > Ok, wait a moment, I'm getting "Camera Focus", "Camera Capture" and
> > > "Lock button" interrupts ... at something like 20/second. Without
> > > touching anything. Hmm. Also "pm_wkup", but that might be
> > > expected. Plus, 49052000.gpio and 49054000.gpio are rather
> > > active. Might be related to the above. Also "gp_timer" and
> > > 48070000.i2c are active, perhaps also related. I don't think I have
> > > the camera working...
> > 
> > Hmm that does not sound right at all for the GPIOs. The pm_wkup
> > interrupt triggers every time you hit wfi pretty much, so that
> > should be OK.
> 
> Wifi was down at that point.
> 
> Some more testing: after boot, interrupt counts stay low, as
> expected. But when I attempt to enable power management, they start
> rising. Sometimes 60/second, sometimes less.
> 
> Things are fine as long as I don't enable the off mode; when I enable
> the off mode, "echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode"
> interrupt counts start rising immediately. "echo 0 >
> /sys/kernel/debug/pm_debug/enable_off_mode" stops that.
> 
> But no matter what configuration, activity LEDs still indicate it is
> busy, and idle power consumption is cca 53mA.

Not seeing that here at all. My n900 with v4.6-rc2 and omap2plus_defconfig
booted with u-boot keeps hitting off mode with both LEDs going off just
fine. It's waking up about once a second or a litte bit more often.

Care to post your .config somewhere, I could give that a try?

Regards,

Tony
