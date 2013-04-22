From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Mon, 22 Apr 2013 11:08:22 -0700
Message-ID: <20130422180822.GB10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
 <5174FE16.6080307@ti.com>
 <51750FF8.6000401@ti.com>
 <51752B48.50700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21609 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754472Ab3DVSI1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Apr 2013 14:08:27 -0400
Content-Disposition: inline
In-Reply-To: <51752B48.50700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

* Grygorii Strashko <grygorii.strashko@ti.com> [130422 05:27]:
> On 04/22/2013 01:24 PM, Tomi Valkeinen wrote:
> >On 2013-04-22 12:08, Tomi Valkeinen wrote:
> >>On 2013-04-19 20:13, Tony Lindgren wrote:
> >>
> >>>3. DSS fails with DT booting
> >>>
> >>>Works with legacy booting but fails with DT. I'm almost certain
> >>>the DT booting was working last week or so?
> >>>
> >>>This is what I now get with DT booting:
> >>>
> >>>omapdss DSI error: can't get VDDS_DSI regulator
> >>>omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
> >>>omapdss HDMI error: device hdmi init failed: -517
> >>>omapdss CORE error: driver probe failed: -22
> >>>...
> >>I think this is the issue Christoph Fritz reported earlier, DSS is being
> >>initialized before TWL, and thus DSS doesn't find the regulators.
> >>
> >>The proper fix is of course to make DSS support EPROBE_DEFER, but that's
> >>easier said than done. I'll have a look if I can get it working enough
> >>to fix this issue.
> >Yes, it seems delayed regulator initialization brought up this issue.
> >
> >I hacked DSI driver of omapdss and Taal panel driver to somewhat work
> >with EPROBE_DEFER. But then the issue was with omapfb.
> >
> >omapfb is currently set to start at late_initcall, so that omapdss and
> >panels are loaded before omapfb. But even that's not late enough to get
> >the regulators for omapdss. It seems the regulators get also initialized
> >at the late_initcall level. Changing omapfb to late_initcall_sync was
> >late enough to get things working.
> >
> >Again, making omapdss, panel drivers and omapfb support EPROBE_DEFER and
> >dynamic panel driver insertion is the proper fix, but it's a big job,
> >and there are "interesting" issues with it (like how to know if a panel
> >device will ever get a driver loaded).
> >
> >But is there something wrong with the TWL and regulators? late_initcall
> >sounds rather late for such a core resource. Even if all drivers
> >supported EPROBE_DEFER, won't it cause extra delays in the boot as
> >drivers are getting probed multiple times?
> >
> >As for fixing the DSS problem for 3.10, I don't have any ideas except
> >pure hacks. I'll continue studying this.
> Hi Tomi,
> twl is not initialized because of I2C,
> I2C is not initialized because of pinctrl-single,
> pinctrl-single is initialized at mudule/device init time.
> So, most everything will be shifted at late_initcall time.
> 
> Hack that sequence is here - https://patchwork.kernel.org/patch/2444501/

Hmm I'm pretty sure the LCD was working on panda with DT
few weeks ago?

In any case, all those drivers should be just module_init
so we get out of the race to bottom to initialize drivers
early. Pinctrl is already before i2c in drivers/Makefile.

I suspect there may be some recent regression that has
happened in linux next over past few weeks.

Regards,

Tony
