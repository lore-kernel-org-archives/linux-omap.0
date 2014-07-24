From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Nokia N900 FB regression?
Date: Thu, 24 Jul 2014 23:01:00 +0300
Message-ID: <20140724200100.GA5336@drone.musicnaut.iki.fi>
References: <20140722212318.GC2615@drone.musicnaut.iki.fi>
 <20140723073706.GH18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:36967 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934176AbaGXUBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2014 16:01:09 -0400
Content-Disposition: inline
In-Reply-To: <20140723073706.GH18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

Hi,

On Wed, Jul 23, 2014 at 12:37:06AM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [140722 14:25]:
> > Hi,
> > 
> > Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
> > the framebuffer stopped working on N900 (nothing on screen).
> > 
> > I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
> > Enable twl4030 off-idle configuration for selected omaps).
> > With this commit reverted, I can see the Tux again with 3.16-rc6.
> > 
> > Any ideas?
> 
> Hmm, OK yeah that enables the deeper idle states. I have tested
> this on n900, but only have remote access to it so could not see
> the framebuffer.
> 
> Sounds like there's some twl regulator that we cannot idle
> by default on n900. Here are the steps to narrow it down:
> 
> 1. Try ti,twl4030-power-idle in omap3-n900.dts instead of
>    ti,twl4030-power-idle-osc-off. This probably won't help
>    unless you're enabling off-idle though, so if it does not
>    help, just keep on using ti,twl4030-power-idle-osc-off.
> 
> 2. Try commenting out one or more of the TWL_REMAP_SLEEP or
>    TWL_REMAP_OFF lines in omap3_idle_rconfig in file
>    drivers/mfd/twl4030-power.c. That's the recommended init
>    sequence like the comments in the code mention. Chances
>    are we're missing a regulator_get somewhere but finding
>    out which one in omap3_idle_rconfig will help narrow it
>    down :)

It's VAUX1 - commenting that out alone fixes the issue. But I think we
are defining that one properly in the DTS (vdds_sdi-supply = <&vaux1>),
and also I checked that sdi_init_regulator() succeeds...

BTW, this issue can be also detected without seeing the framebuffer,
from dmesg:

# dmesg|grep omapfb
[    2.785705] omapfb omapfb: no displays
[    2.786041] omapfb omapfb: failed to setup omapfb
[    2.786102] platform omapfb: Driver omapfb requests probe deferral
[    4.038055] acx565akm spi1.2: omapfb: acx565akm rev ab LCD detected
[    5.421325] omapfb omapfb: Failed to enable display 'lcd'
[    5.431335] omapfb omapfb: failed to initialize default display
[    5.450408] omapfb omapfb: failed to setup omapfb
[    5.455444] omapfb: probe of omapfb failed with error -1

A.
