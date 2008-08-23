From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Sat, 23 Aug 2008 16:22:39 -0700
Message-ID: <20080823232238.GL4713@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com> <20080805104643.GP7193@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59040 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYHWXWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 19:22:41 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E314F6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [080821 05:49]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org On Behalf Of Tony Lindgren
> > * Pandita, Vikram <vikram.pandita@ti.com> [080630 17:03]:
> > >
> > >
> > >    Code changes for final rev of EHCI/OHCI USB expansion board 750-2099-001(C)
> > >    with h/w bug fixes to support ISP1504 PHY in input clocking mode
> > >
> > >    The board has 12-pin ULPI Port1 and Port2 EHCI pins connected to ISP1504's.
> > >    Port3 is connected to ISP1301 for connection to OHCI.
> > >
> > >  - This is the final USB expansion board that will be released and
> > >    so the bug fixes are critical
> > >
> > >  - Changes tested on SDP3430
> > 
> > These should be sent via linux-usb list, please also Cc 
> > linux-omap list.
> > 
> > Thanks,
> > 
> > Tony
> 
> 
> Er Tony, the bus glue for OMAP is not present upstream. This patch fixes
> something in that bus glue code, which currently exists only in your tree.
> Care to push this to your tree for now?
> 
> I'll get the ehci-omap code in better shape and submit separately to the
> linux-usb list.

Well we should really sync all usb code with mainline now that musb is
merged. Can you repost patches against mainline for linux-usb? I can
then reset drivers/usb to be in sync with mainline and we can move
all USB related discussion to linux-usb.

Tony

> 
> 
> - Anand
> 
> 
> > 
> > 
> > > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > > ---
> > >  drivers/usb/host/ehci-omap.c |   37 ++++++-------------------------------
> > >  1 file changed, 6 insertions(+), 31 deletions(-)
> > >
> > > Index: linux-omap-2.6/drivers/usb/host/ehci-omap.c
> > > ===================================================================
> > > --- linux-omap-2.6.orig/drivers/usb/host/ehci-omap.c    2008-05-02 14:11:56.000000000 +0530
> > > +++ linux-omap-2.6/drivers/usb/host/ehci-omap.c 2008-05-02 15:05:40.000000000 +0530
> > > @@ -35,7 +35,7 @@
> > >  #ifdef CONFIG_OMAP_EHCI_PHY_MODE
> > >  /* EHCI connected to External PHY */
> > >
> > > -/* External USB connectivity board: 750-2083-001
> > > +/* External USB connectivity board: 750-2099-001(C)
> > >   * Connected to OMAP3430 SDP
> > >   * The board has Port1 and Port2 connected to ISP1504 in 12-pin ULPI mode
> > >   */
> > > @@ -50,14 +50,7 @@
> > >  #define EXTERNAL_PHY_RESET
> > >  #define        EXT_PHY_RESET_GPIO_PORT1        (57)
> > >  #define        EXT_PHY_RESET_GPIO_PORT2        (61)
> > > -#define        EXT_PHY_RESET_DELAY             (10)
> > > -
> > > -/* ISSUE2:
> > > - * USBHOST supports External charge pump PHYs only
> > > - * Use the VBUS from Port1 to power VBUS of Port2 externally
> > > - * So use Port2 as the working ULPI port
> > > - */
> > > -#define VBUS_INTERNAL_CHARGEPUMP_HACK
> > > +#define        EXT_PHY_RESET_DELAY             (500)
> > >
> > >  #endif /* CONFIG_OMAP_EHCI_PHY_MODE */
> > >
> > > @@ -228,8 +221,8 @@ static int omap_start_ehc(struct platfor
> > >         omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT1, 0);
> > >         omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
> > >         omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT2, 0);
> > > -       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 0);
> > > -       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 0);
> > > +       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 1);
> > > +       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 1);
> > >         /* Hold the PHY in RESET for enough time till DIR is high */
> > >         udelay(EXT_PHY_RESET_DELAY);
> > >  #endif
> > > @@ -305,26 +298,8 @@ static int omap_start_ehc(struct platfor
> > >          * Hold the PHY in RESET for enough time till PHY is settled and ready
> > >          */
> > >         udelay(EXT_PHY_RESET_DELAY);
> > > -       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 1);
> > > -       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 1);
> > > -#endif
> > > -
> > > -#ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
> > > -       /* Refer ISSUE2: LINK assumes external charge pump */
> > > -
> > > -       /* use Port1 VBUS to charge externally Port2:
> > > -        *      So for PHY mode operation use Port2 only
> > > -        */
> > > -       omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
> > > -                       (2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
> > > -                       (1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
> > > -                       (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
> > > -                       (0x26),
> > > -                       EHCI_INSNREG05_ULPI);
> > > -
> > > -       while (!(omap_readl(EHCI_INSNREG05_ULPI) &
> > > -               (1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
> > > -
> > > +       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 0);
> > > +       omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 0);
> > >  #endif
> > >
> > >         return 0;
