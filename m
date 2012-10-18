From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Thu, 18 Oct 2012 15:18:04 +0300
Message-ID: <1350562684.2143.52.camel@sokoban>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
	 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
	 <20121018103334.GA1449@arwen.pp.htv.fi>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349Ab2JRMSN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 08:18:13 -0400
In-Reply-To: <20121018103334.GA1449@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, 2012-10-18 at 13:33 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 18, 2012 at 12:20:10PM +0300, Tero Kristo wrote:
> > Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
> > PHY functions for OMAP4, but this causes a problem with core retention
> > as the MUSB module remains enabled if omap-usb2 phy driver is not used.
> > This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
> > 
> > Fixed by adding a minimal function back that disables the USB PHY in
> > case omap-usb2 driver is not used.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/omap_phy_internal.c |   27 +++++++++++++++++++++++++++
> >  1 files changed, 27 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
> > index d992db8..6a4b9cf 100644
> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > @@ -33,6 +33,33 @@
> >  #include "soc.h"
> >  #include "control.h"
> >  
> > +#define CONTROL_DEV_CONF		0x300
> > +#define PHY_PD				0x1
> > +
> > +#ifndef CONFIG_OMAP_USB2
> 
> this is a tristate, meaning that can be a module.

Ok, so extra check for that needed.

> 
> > +static int __init omap4430_phy_power_down(void)
> > +{
> > +	void __iomem *ctrl_base;
> > +
> > +	if (!cpu_is_omap44xx())
> > +		return 0;
> > +
> > +	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
> > +	if (!ctrl_base) {
> > +		pr_err("control module ioremap failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Power down the phy */
> > +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> > +
> > +	iounmap(ctrl_base);
> > +
> > +	return 0;
> > +}
> > +early_initcall(omap4430_phy_power_down);
> > +#endif
> 
> I think you could do it even if the driver is enabled.

Actually not at least now, it looks like the driver is not controlling
this bit at all, so the driver would fail if we do this.

> 
> Just to make sure I understand the issue right: is the PHY enabled by
> default or did bootloader left this enabled ?

The reset value for the register is zero (at least according to TRM), so
it is enabled from boot. Also, I couldn't find any code from the u-boot
that would touch this bit with a quick look.

-Tero

