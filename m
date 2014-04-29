From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Tue, 29 Apr 2014 10:38:39 -0700
Message-ID: <20140429173838.GB27571@atomide.com>
References: <535A4470.2000509@ti.com>
 <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com>
 <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com>
 <20140428164528.GM20807@atomide.com>
 <535F37E9.8090609@ti.com>
 <20140429150529.GA27571@atomide.com>
 <535FD10B.4020108@ti.com>
 <535FD43B.3030102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48245 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbaD2Ris (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 13:38:48 -0400
Content-Disposition: inline
In-Reply-To: <535FD43B.3030102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140429 09:33]:
> On 29/04/14 19:19, Tomi Valkeinen wrote:
> > On 29/04/14 18:05, Tony Lindgren wrote:
> > 
> >>> omap4_padconf_global is a syscon node, not pinctrl. As syscon just gives
> >>> a raw regmap to its memory area, the driver needs to know about the OMAP
> >>> control registers to use it.
> >>
> >> That would be probably best set up the same way we have already set up
> >> for example omap4_padconf_global: tisyscon@4a1005a0. Then drivers can
> >> access it using regmap, see how drivers/regulator/pbias-regulator.c
> >> sets up the pbias regulator with regmap for MMC.
> > 
> > Right, but it means that the driver will contain platform specific code
> > for all the omap revisions it supports. Isn't that wrong?
> > 
> > I already have a patch for DSI that uses the syscon-method, and it works
> > fine. But it's quite ugly, imo, to fiddle with the OMAP control
> > registers in a driver.

Anything using the system control module registers should be a separate
driver. And it should ideally be implemeting some Linux generic framework
that the consumer driver can then use. That leaves out the need to export
custom functions.

I guess we don't have a PHY framework for displays though, so how about
just a separate minimal driver under drivers/video/omap2 that uses the
syscon?
 
> Oh, also, if I do that, I need to know both the SoC version and the DSS
> version in the driver.

Don't you get all you need in the compatible string? Something like
compatible ti,dss-phy-omap5?

Regards,

Tony
