From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: zoom3: enable ehci support
Date: Mon, 28 Dec 2009 16:04:10 -0800
Message-ID: <20091229000410.GT3512@atomide.com>
References: <1261165300-25985-1-git-send-email-vikram.pandita@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AC76@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50711 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbZL2AEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 19:04:15 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AC76@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [091219 03:12]:
> > Zoom3 board has omap3630 EHCI port2 connected to a ULPI phy.
> > GPIO_64 is connected to the PHY reset pin.
> > 
> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > Cc: Gadiyar, Anand <gadiyar@ti.com>
> 
> Except for one comment (see below),
> 
> Acked-by: Anand Gadiyar <gadiyar@ti.com>
> 
> > ---
> >  arch/arm/mach-omap2/board-zoom3.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
> > index a9fe918..a5e8036 100644
> > --- a/arch/arm/mach-omap2/board-zoom3.c
> > +++ b/arch/arm/mach-omap2/board-zoom3.c
> > @@ -20,6 +20,8 @@
> >  
> >  #include <plat/common.h>
> >  #include <plat/board.h>
> > +#include <plat/usb.h>
> > +#include <plat/mux.h>
> 
> I don't think you need plat/mux.h here?
> 
> The omap_mux_init_gpio() call that you added, is declared
> in mux.h, that's included on the next line.

Correct, plat/mux.h should not be included for omap3 any longer.

It will also disappear for omap2 over next few weeks once I get
around fixing omap2 to use the new mux code.

Regards,

Tony

 
> >  
> >  #include "mux.h"
> >  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> > @@ -51,11 +53,25 @@ static struct omap_board_mux board_mux[] __initdata = {
> >  #define board_mux	NULL
> >  #endif
> >  
> > +static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
> > +	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> > +	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> > +	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> > +
> > +	.phy_reset  = true,
> > +	.reset_gpio_port[0]  = -EINVAL,
> > +	.reset_gpio_port[1]  = 64,
> > +	.reset_gpio_port[2]  = -EINVAL
> > +};
> > +
> >  static void __init omap_zoom_init(void)
> >  {
> >  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
> >  	zoom_peripherals_init();
> >  	zoom_debugboard_init();
> > +
> > +	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
> > +	usb_ehci_init(&ehci_pdata);
> >  }
> >  
> >  MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
> > -- 
> > 1.6.6.rc0.66.ge160d
> > 
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
