From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Tue, 29 Apr 2014 08:05:30 -0700
Message-ID: <20140429150529.GA27571@atomide.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com>
 <535A4470.2000509@ti.com>
 <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com>
 <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com>
 <20140428164528.GM20807@atomide.com>
 <535F37E9.8090609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36918 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012AbaD2PFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 11:05:35 -0400
Content-Disposition: inline
In-Reply-To: <535F37E9.8090609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140428 22:26]:
> On 28/04/14 19:45, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140427 23:53]:
> >> On 25/04/14 18:31, Tony Lindgren wrote:
> >>
> >>> Chances are any mux register in the syscon area already works with
> >>> pinctrl-single,pins or pinctrl-single,bits option. The ones in the
> >>> padconf area should be already mapped so the driver just has to
> >>> request them.
> >>
> >> If using the padconf (say omap4_padconf_global for omap4), doesn't that
> >> mean we need to have platform specific bits in the driver? Isn't that
> >> something we've been trying to remove all the time?
> > 
> > No, it's all done in a Linux generic way during driver probe, see
> > drivers/base/pinctrl.c. You just need to define the default pins
> > in the .dts files. If you need dynamic remuxing in the driver,
> > you can define other named states that the driver can then toggle
> > with pinctrl_select_state().
> 
> omap4_padconf_global is a syscon node, not pinctrl. As syscon just gives
> a raw regmap to its memory area, the driver needs to know about the OMAP
> control registers to use it.

That would be probably best set up the same way we have already set up
for example omap4_padconf_global: tisyscon@4a1005a0. Then drivers can
access it using regmap, see how drivers/regulator/pbias-regulator.c
sets up the pbias regulator with regmap for MMC.
 
> Pinctrl-single cannot be used for CONTROL_DSIPHY register, as the
> register contents are a bit funny and DSI1 and DSI2 bits are mixed
> together. And CONTROL_DSIPHY is already in the memory region defined by
> the omap4_padconf_global, so I guess it wouldn't be good to map parts of
> the same memory region in a pinctrl node.

If it's more than a mux, then it should not be set up as a pinctrl
register. Looks like CONTROL_DSIPHY is already available for drivers
via regmap as it falls into the *_padconf_global mappings for omap4
and omap5.

Regards,

Tony
