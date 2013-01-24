From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: deferred STP
Date: Thu, 24 Jan 2013 18:11:21 +0200
Message-ID: <20130124161121.GD23053@blackmetal.musicnaut.iki.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
 <20130123200540.GE23057@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130123200540.GE23057-R3WNPi76c83LsdW6vOPryG4HOFkwEHDbMR2xtNvyitY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 23, 2013 at 10:05:41PM +0200, Aaro Koskinen wrote:
> On Wed, Jan 23, 2013 at 12:23:02PM +0200, Felipe Balbi wrote:
> > Hi folks,
> > 
> > it's now rebased on today's i2c-embedded/for-next. I boot tested with my
> > Blaze board.
> > 
> > Aaro, if you could verify it doesn't break N900, I'd be glad.
> 
> It works, but it still introduces a ~4 second delay during the boot:
> 
> [    0.180847] usbcore: registered new device driver usb
> [    0.181518] musb-omap2430 musb-omap2430: invalid resource
> [    4.289093] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
> [    4.289276] twl 1-0048: power (irq 343) chaining IRQs 346..353
> [    4.321228] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
> [    4.446655] VUSB1V5: 1500 mV normal standby

This delay is coming from omap_i2c_wait_for_bb(), with ARDY interrupt
disabled we need to poll for BB bit longer, it seems for every transfer.

Replacing msleep(1) with usleep_range(800, 1200) drops it half, and with
just cpu_relax() the delay is gone - but obviously may increase the CPU
time usage.

BTW, with TWL RTC on OMAP boards you can quickly sanity check I2C
throughput:

	while /bin/true; do cat /sys/class/rtc/rtc0/time ; done | uniq -c

For these patches I get (ignoring the first line of the output):

Before:
     88 00:13:07
     89 00:13:08
     89 00:13:09
     88 00:13:10
     89 00:13:11

After:
     26 00:00:30
     26 00:00:31
     26 00:00:32
     26 00:00:33
     26 00:00:34

After + omap_i2c_wait_for_bb() msleep() replaced with cpu_relax():
     91 00:04:59
     90 00:05:00
     91 00:05:01
     90 00:05:02
     91 00:05:03

A.
