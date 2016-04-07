From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
Date: Thu, 7 Apr 2016 16:41:34 -0700
Message-ID: <20160407234134.GQ16484@atomide.com>
References: <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd>
 <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd>
 <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd>
 <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160407230150.GA16552@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160407 16:02]:
> Hi!
> 
> > > gzipped config is attached.
> > > 
> > > Note that I'm still using NOLO. I enabled the sleep, then went to
> > > runlevel 1. LEDs still stay on, 55mA power consumption. That was with
> > > 1 in off_mode.
> > 
> > Nothing idling for me with your .config.. And it seems slower to boot
> > compared to omap2plus_defconfig? Maybe because of the extra GPIO
> > interrupts?
> 
> Extra interrupts only happen when enable_off_mode is 1, so that should
> not be an issue during boot.

OK maybe it's just the extra driver probe time then.

> > Looks like you have 117 additional entries in .config enabled compared
> > to omap2plus_defconfig. Maybe go back to omap2plus_defconfig with minimal
> > changes and verify it idles properly first?
> > 
> > I'm suspecting it's some driver(s) you have enabled causing the
> > issue.
> 
> I guess so. Do you (or anyone else) have minimum non-modular config
> for N900 that boots with video? Could I get lsmod from your system?
> (Yes, I still have nightmares from getting .config that works).

Well I've been just using omap2plus_defconfig with:

# modprobe tsc2005
# modprobe gpio_backlight
# modprobe panel_sony_acx565akm
# modprobe omapfb

# echo 255 > /sys/class/backlight/acx565akm/brightness

And then the following to blank for idle:

# echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank

But in the world of eternal regressions, I'm not seeing anything
on the framebuffer with v4.6-rc2 :( No idea what broke it or when
as my n900 is in the rack.

Anyways, below is also my lsmod output.

Regards,

Tony


Module                  Size  Used by
panel_sharp_ls037v7dw01     4148  0
ads7846                12959  0
hwmon                   4213  1 ads7846
gpio_keys               9053  0
twl4030_keypad          3896  0
matrix_keymap           2801  1 twl4030_keypad
omapfb                 39255  1
cfbfillrect             3614  1 omapfb
cfbimgblt               2416  1 omapfb
cfbcopyarea             3187  1 omapfb
panel_sony_acx565akm     7895  1
omapdss               269684  4 panel_sharp_ls037v7dw01,omapfb,panel_sony_acx565akm
gpio_backlight          2804  0
tsc2005                 1782  0
tsc200x_core            7337  1 tsc2005
ledtrig_default_on      1119  0
leds_gpio               3530  0
led_class               5418  1 leds_gpio
rtc_twl                 6234  0
twl4030_wdt             2711  0
