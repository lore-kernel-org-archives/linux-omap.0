From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Wed, 30 Apr 2014 10:56:51 -0700
Message-ID: <20140430175651.GB12362@atomide.com>
References: <535A6C40.10609@ti.com>
 <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com>
 <20140428164528.GM20807@atomide.com>
 <535F37E9.8090609@ti.com>
 <20140429150529.GA27571@atomide.com>
 <535FD10B.4020108@ti.com>
 <535FD43B.3030102@ti.com>
 <20140429173838.GB27571@atomide.com>
 <5360948A.5020607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54271 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752135AbaD3R46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2014 13:56:58 -0400
Content-Disposition: inline
In-Reply-To: <5360948A.5020607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140429 23:14]:
> On 29/04/14 20:38, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140429 09:33]:
> >> On 29/04/14 19:19, Tomi Valkeinen wrote:
> >>> On 29/04/14 18:05, Tony Lindgren wrote:
> >>>
> >>>>> omap4_padconf_global is a syscon node, not pinctrl. As syscon just gives
> >>>>> a raw regmap to its memory area, the driver needs to know about the OMAP
> >>>>> control registers to use it.
> >>>>
> >>>> That would be probably best set up the same way we have already set up
> >>>> for example omap4_padconf_global: tisyscon@4a1005a0. Then drivers can
> >>>> access it using regmap, see how drivers/regulator/pbias-regulator.c
> >>>> sets up the pbias regulator with regmap for MMC.
> >>>
> >>> Right, but it means that the driver will contain platform specific code
> >>> for all the omap revisions it supports. Isn't that wrong?
> >>>
> >>> I already have a patch for DSI that uses the syscon-method, and it works
> >>> fine. But it's quite ugly, imo, to fiddle with the OMAP control
> >>> registers in a driver.
> > 
> > Anything using the system control module registers should be a separate
> > driver. And it should ideally be implemeting some Linux generic framework
> > that the consumer driver can then use. That leaves out the need to export
> > custom functions.
> 
> Ok.
> 
> > I guess we don't have a PHY framework for displays though, so how about
> > just a separate minimal driver under drivers/video/omap2 that uses the
> > syscon?
> 
> Well, this one is not really about DSI PHY. The CONTROL_DSIPHY register
> is not in the DSI PHY block, but in the control module, and it is used
> to enable/disable the pins (for omap4/5) and to set pull up/down for the
> pins (only for omap4). Oddly, for omap5, there's also a normal padconfig
> register for the DSI pins, but not so for omap4.
> 
> To me it looks like a pad config register. I don't know why there's a
> separate odd register for it and it's not using the normal padconfig system.
> 
> I'd like to use the pinctrl framework for it, but the pinctrl-single
> cannot handle such a funny register. So, if "Anything using the system
> control module registers should be a separate driver", then I guess I
> need to write a pinctrl driver for this single register?

Have you checked out pinctrl-single,bits binding? That should allow
you to map random bits in a single register to a pinctrl driver
instance.
 
> >> Oh, also, if I do that, I need to know both the SoC version and the DSS
> >> version in the driver.
> > 
> > Don't you get all you need in the compatible string? Something like
> > compatible ti,dss-phy-omap5?
> 
> We do use different compatible strings for different major versions of
> the DSS blocks, like ti,omap5-dsi. But that exactly same DSS block could
> be used on some other SoC, with different control stuff.
> 
> We could use separate compatible string for each SoC that uses DSS, but
> then we're really encoding the SoC version into the compatible string,
> not DSS version.
> 
> Of course, if there will be a separate driver managing the
> CONTROL_DSIPHY register, then that one should use compatible string
> specific to the SoC, as it's not a DSS driver at all.

Yeah probably using pinctrl-single,bits, or a separate driver with syscon
makes most sense here.

Regards,

Tony
