From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900 FB regression?
Date: Fri, 25 Jul 2014 04:13:48 -0700
Message-ID: <20140725111347.GD29045@atomide.com>
References: <20140722212318.GC2615@drone.musicnaut.iki.fi>
 <20140723073706.GH18374@atomide.com>
 <20140724200100.GA5336@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50839 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751713AbaGYLPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 07:15:14 -0400
Content-Disposition: inline
In-Reply-To: <20140724200100.GA5336@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

* Aaro Koskinen <aaro.koskinen@iki.fi> [140724 13:03]:
> Hi,
> 
> On Wed, Jul 23, 2014 at 12:37:06AM -0700, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [140722 14:25]:
> > > Hi,
> > > 
> > > Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
> > > the framebuffer stopped working on N900 (nothing on screen).
> > > 
> > > I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
> > > Enable twl4030 off-idle configuration for selected omaps).
> > > With this commit reverted, I can see the Tux again with 3.16-rc6.
> > > 
> > > Any ideas?
> > 
> > Hmm, OK yeah that enables the deeper idle states. I have tested
> > this on n900, but only have remote access to it so could not see
> > the framebuffer.
> > 
> > Sounds like there's some twl regulator that we cannot idle
> > by default on n900. Here are the steps to narrow it down:
> > 
> > 1. Try ti,twl4030-power-idle in omap3-n900.dts instead of
> >    ti,twl4030-power-idle-osc-off. This probably won't help
> >    unless you're enabling off-idle though, so if it does not
> >    help, just keep on using ti,twl4030-power-idle-osc-off.
> > 
> > 2. Try commenting out one or more of the TWL_REMAP_SLEEP or
> >    TWL_REMAP_OFF lines in omap3_idle_rconfig in file
> >    drivers/mfd/twl4030-power.c. That's the recommended init
> >    sequence like the comments in the code mention. Chances
> >    are we're missing a regulator_get somewhere but finding
> >    out which one in omap3_idle_rconfig will help narrow it
> >    down :)
> 
> It's VAUX1 - commenting that out alone fixes the issue. But I think we
> are defining that one properly in the DTS (vdds_sdi-supply = <&vaux1>),
> and also I checked that sdi_init_regulator() succeeds...

OK, looks like the LCD panel is also using V28 from vaux1. It
goes to the "Main flex connector" pin 26.

It also seems that other devices are also using V28 like
accelerometer, main camera cover switch, usd card hot-swap
detection sensor, tvout analog switch, fm transmitter.. And
it's marked as regulator-always-on because of battery cover
switch.

So I'll just send a patch to disable the twl configuration
for n900 for now as anything else would be quite intrusive. I'll
look into it more later on once I have access to my n900.
 
> BTW, this issue can be also detected without seeing the framebuffer,
> from dmesg:
> 
> # dmesg|grep omapfb
> [    2.785705] omapfb omapfb: no displays
> [    2.786041] omapfb omapfb: failed to setup omapfb
> [    2.786102] platform omapfb: Driver omapfb requests probe deferral
> [    4.038055] acx565akm spi1.2: omapfb: acx565akm rev ab LCD detected
> [    5.421325] omapfb omapfb: Failed to enable display 'lcd'
> [    5.431335] omapfb omapfb: failed to initialize default display
> [    5.450408] omapfb omapfb: failed to setup omapfb
> [    5.455444] omapfb: probe of omapfb failed with error -1

OK thanks. I bet I was doing testing on omap2plus_defconfig
only that does not even have the LCD enabled.

Regards,

Tony
