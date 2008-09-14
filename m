From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Sun, 14 Sep 2008 21:57:27 +0300
Message-ID: <20080914185721.GB6943@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo> <20080912193534.GH7132@frodo> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="S1BNGpv0yoYahz37"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46923 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbYINS6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 14:58:01 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, Sep 15, 2008 at 12:11:46AM +0530, Pandita, Vikram wrote:
> The issues mentioned are _not_ of omap34xx silicon, but of the PHY (ISP15=
04 in SDP-USB expansion board).

Gotcha

> Better still is to move the PHY issues to platform/board specific functio=
n.
> Will try to submit a patch on that.

sounds good to me ;-)

If you can make your patch on top of the ones I have queued for sending,
I'd be glad. Also, if you could test them for me, that would be quite
nice since I only have a buggy version of beagleboard with one ehci
port.

I'm sending my patches attached for you, there's actually one from you
supporting the new version of the expansion board.

--=20
balbi

--S1BNGpv0yoYahz37
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-omap-usb-ehci-clean-up-ehci-omap.c.diff"
Content-Transfer-Encoding: quoted-printable

=46rom bfae28bb4dfa0198bd30584fcfa74682947053eb Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <felipe.balbi@nokia.com>
Date: Sat, 13 Sep 2008 18:21:37 +0300
Subject: [PATCH 1/4] omap: usb: ehci: clean up ehci-omap.c

General cleanup for ehci-omap.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |  135 +++++++++++++++++---------------------=
----
 1 files changed, 55 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index fff4195..f1b5ea5 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -5,7 +5,7 @@
  * Tested on OMAP3430 ES2.0 SDP
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * 	Author: Vikram Pandita <vikram.pandita@ti.com>
+ *	Author: Vikram Pandita <vikram.pandita@ti.com>
  *
  * Based on "ehci-fsl.c" and "ehci-au1xxx.c" ehci glue layers
  *
@@ -31,7 +31,6 @@
=20
 #include "ehci-omap.h"
=20
-
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 /* EHCI connected to External PHY */
=20
@@ -42,10 +41,10 @@
=20
 /* ISSUE1:
  *      ISP1504 for input clocking mode needs special reset handling
- * 	Hold the PHY in reset by asserting RESET_N signal
- * 	Then start the 60Mhz clock input to PHY
- * 	Release the reset after a delay -
- * 		to get the PHY state machine in working state
+ *	Hold the PHY in reset by asserting RESET_N signal
+ *	Then start the 60Mhz clock input to PHY
+ *	Release the reset after a delay -
+ *		to get the PHY state machine in working state
  */
 #define EXTERNAL_PHY_RESET
 #define	EXT_PHY_RESET_GPIO_PORT1	(57)
@@ -89,16 +88,16 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 =
tll_channel_mask)
=20
 	/* Use UTMI Ports of TLL */
 	omap_writel((1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
-			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
+			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
+			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
-	/* Enusre bit is set */
+	/* Ensure bit is set */
 	while (!(omap_readl(OMAP_UHH_HOSTCONFIG) &
 		(1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)));
=20
-	dev_dbg(hcd->self.controller, "\nEntered UTMI MODE: success\n");
+	dev_dbg(hcd->self.controller, "Entered UTMI MODE: success\n");
=20
 	/* Program the 3 TLL channels upfront */
=20
@@ -106,15 +105,15 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u=
8 tll_channel_mask)
=20
 		/* Disable AutoIdle */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1<<OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
+			    ~(1 << OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 		/* Disable BitStuffing */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
+			    ~(1 << OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 		/* SDR Mode */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
+			    ~(1 << OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
=20
 	}
@@ -130,17 +129,17 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u=
8 tll_channel_mask)
 	for (i =3D 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
=20
 		/* Enable only the channel that is needed */
-		if (!(tll_channel_mask & 1<<i))
+		if (!(tll_channel_mask & 1 << i))
 			continue;
=20
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
-			    (1<<OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
+			    (1 << OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
=20
 		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
-		dev_dbg(hcd->self.controller, "\nULPI_SCRATCH_REG[ch=3D%d]"
-			"=3D 0x%02x\n",
-			i+1, omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
+		dev_dbg(hcd->self.controller, "ULPI_SCRATCH_REG[ch=3D%d]"
+			"=3D 0x%02x\n", i + 1,
+			omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
 	}
 }
=20
@@ -150,7 +149,7 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 =
tll_channel_mask)
=20
=20
 /* omap_start_ehc
- * 	- Start the TI USBHOST controller
+ *	- Start the TI USBHOST controller
  */
 static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 {
@@ -180,8 +179,7 @@ static int omap_start_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
=20
 	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
 				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
-		dev_dbg(hcd->self.controller,
-			"idlest2 =3D 0x%x\n",
+		dev_dbg(hcd->self.controller, "idlest2 =3D 0x%x\n",
 			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
 	/* End DPLL5 programming */
=20
@@ -260,9 +258,9 @@ static int omap_start_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
 	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) &
 		(1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT)));
=20
-	dev_dbg(hcd->self.controller, "\n TLL RESET DONE\n");
+	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
=20
-	/* (1<<3) =3D no idle mode only for initial debugging */
+	/* (1 << 3) =3D no idle mode only for initial debugging */
 	omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
 			(1 << OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT) |
 			(1 << OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT),
@@ -280,10 +278,10 @@ static int omap_start_ehc(struct platform_device *dev=
, struct usb_hcd *hcd)
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 	/* Bypass the TLL module for PHY mode operation */
 	omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
-			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
+			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
+			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Ensure that BYPASS is set */
 	while (omap_readl(OMAP_UHH_HOSTCONFIG) &
@@ -313,7 +311,7 @@ static int omap_start_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
 	/* Refer ISSUE2: LINK assumes external charge pump */
=20
 	/* use Port1 VBUS to charge externally Port2:
-	 * 	So for PHY mode operation use Port2 only
+	 *	So for PHY mode operation use Port2 only
 	 */
 	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
 			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
@@ -323,7 +321,7 @@ static int omap_start_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
 			EHCI_INSNREG05_ULPI);
=20
 	while (!(omap_readl(EHCI_INSNREG05_ULPI) &
-		(1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
+		(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
=20
 #endif
=20
@@ -342,17 +340,16 @@ static void omap_stop_ehc(struct platform_device *dev=
, struct usb_hcd *hcd)
 	dev_dbg(hcd->self.controller, ": stopping TI EHCI USB Controller\n");
=20
 	/* Reset OMAP modules for insmod/rmmod to work */
-	omap_writel((1<<1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)));
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)));
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)));
-	dev_dbg(hcd->self.controller,
-		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
+	omap_writel((1 << 1), OMAP_UHH_SYSCONFIG);
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 0)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 1)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 2)));
+	dev_dbg(hcd->self.controller, "UHH RESET DONE OMAP_UHH_SYSSTATUS %x\n",
 			omap_readl(OMAP_UHH_SYSSTATUS));
=20
-	omap_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)));
-	dev_dbg(hcd->self.controller, ":TLL RESEET DONE");
+	omap_writel((1 << 1), OMAP_USBTLL_SYSCONFIG);
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1 << 0)));
+	dev_dbg(hcd->self.controller, ": TLL RESEET DONE");
=20
 	if (ehci_clocks->usbtll_fck_clk !=3D NULL) {
 		clk_disable(ehci_clocks->usbtll_fck_clk);
@@ -452,7 +449,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_devi=
ce *dev)
 	ehci->hcs_params =3D readl(&ehci->caps->hcs_params);
=20
 	/* SET 1 micro-frame Interrupt interval */
-	writel(readl(&ehci->regs->command) | (1<<16), &ehci->regs->command);
+	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
=20
 	retval =3D usb_add_hcd(hcd, dev->resource[1].start,
 				IRQF_DISABLED | IRQF_SHARED);
@@ -497,18 +494,6 @@ static int ehci_hcd_omap_drv_remove(struct platform_de=
vice *dev)
 }
=20
 /*------------------------------------------------------------------------=
-*/
-#ifdef CONFIG_PM
-static int omap_ehci_bus_suspend(struct usb_hcd *hcd)
-{
-	return ehci_bus_suspend(hcd);
-}
-
-static int omap_ehci_bus_resume(struct usb_hcd *hcd)
-{
-	return ehci_bus_resume(hcd);
-}
-#endif
-/*------------------------------------------------------------------------=
-*/
=20
 static const struct hc_driver ehci_omap_hc_driver =3D {
 	.description =3D hcd_name,
@@ -516,53 +501,43 @@ static const struct hc_driver ehci_omap_hc_driver =3D=
 {
 	.hcd_priv_size =3D sizeof(struct ehci_hcd)
 				+ sizeof(struct ehci_omap_clock_defs),
=20
-	/*
-	 * generic hardware linkage
-	 */
+	/* generic hardware linkage */
 	.irq =3D ehci_irq,
 	.flags =3D HCD_MEMORY | HCD_USB2,
=20
-	/*
-	 * basic lifecycle operations
-	 */
+	/* basic lifecycle operations */
 	.reset =3D ehci_init,
 	.start =3D ehci_run,
 	.stop =3D ehci_stop,
 	.shutdown =3D ehci_shutdown,
=20
-	/*
-	 * managing i/o requests and associated device resources
-	 */
+	/* managing i/o requests and associated device resources */
 	.urb_enqueue =3D ehci_urb_enqueue,
 	.urb_dequeue =3D ehci_urb_dequeue,
 	.endpoint_disable =3D ehci_endpoint_disable,
=20
-	/*
-	 * scheduling support
-	 */
+	/* scheduling support */
 	.get_frame_number =3D ehci_get_frame,
=20
-	/*
-	 * root hub support
-	 */
+	/* root hub support */
 	.hub_status_data =3D ehci_hub_status_data,
 	.hub_control =3D ehci_hub_control,
 #ifdef	CONFIG_PM
-	.bus_suspend =3D omap_ehci_bus_suspend,
-	.bus_resume =3D omap_ehci_bus_resume,
+	.bus_suspend =3D ehci_bus_suspend,
+	.bus_resume =3D ehci_bus_resume,
 #endif
 };
=20
-/*------------------------------------------------------------------------=
-*/
-MODULE_ALIAS("omap-ehci");
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_ALIAS("plaform:omap-ehci");
+
 static struct platform_driver ehci_hcd_omap_driver =3D {
-	.probe =3D ehci_hcd_omap_drv_probe,
-	.remove =3D ehci_hcd_omap_drv_remove,
-	.shutdown =3D usb_hcd_platform_shutdown,
-	/*.suspend      =3D ehci_hcd_omap_drv_suspend, */
-	/*.resume       =3D ehci_hcd_omap_drv_resume, */
-	.driver =3D {
-		.name =3D "ehci-omap",
-		.bus =3D &platform_bus_type
+	.probe		=3D ehci_hcd_omap_drv_probe,
+	.remove		=3D ehci_hcd_omap_drv_remove,
+	.shutdown	=3D usb_hcd_platform_shutdown,
+	/*.suspend	=3D ehci_hcd_omap_drv_suspend, */
+	/*.resume	=3D ehci_hcd_omap_drv_resume, */
+	.driver		=3D {
+		.name	=3D "ehci-omap",
 	}
 };
--=20
1.6.0.1.196.g01914


--S1BNGpv0yoYahz37
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-omap-usb-ehci-switch-to-use-gpiolib.diff"
Content-Transfer-Encoding: quoted-printable

=46rom 14a61159787a5797340445594f57f3921d3ab7e8 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <felipe.balbi@nokia.com>
Date: Sat, 13 Sep 2008 18:14:00 +0300
Subject: [PATCH 2/4] omap: usb: ehci: switch to use gpiolib

Quit using omap-specific gpio handling and start using
gpiolib for ehci-omap.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f1b5ea5..c73f832 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -27,7 +27,7 @@
=20
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <mach/gpio.h>
+#include <linux/gpio.h>
=20
 #include "ehci-omap.h"
=20
@@ -222,12 +222,10 @@ static int omap_start_ehc(struct platform_device *dev=
, struct usb_hcd *hcd)
=20
 #ifdef EXTERNAL_PHY_RESET
 	/* Refer: ISSUE1 */
-	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT1);
-	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT1, 0);
-	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
-	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT2, 0);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 0);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 0);
+	gpio_request(EXT_PHY_RESET_GPIO_PORT1, "reset_port1");
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
+	gpio_request(EXT_PHY_RESET_GPIO_PORT2, "reset_port2");
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
 	/* Hold the PHY in RESET for enough time till DIR is high */
 	udelay(EXT_PHY_RESET_DELAY);
 #endif
@@ -303,8 +301,8 @@ static int omap_start_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
 	 * Hold the PHY in RESET for enough time till PHY is settled and ready
 	 */
 	udelay(EXT_PHY_RESET_DELAY);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 1);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 1);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 1);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 1);
 #endif
=20
 #ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
@@ -383,8 +381,8 @@ static void omap_stop_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
=20
=20
 #ifdef EXTERNAL_PHY_RESET
-	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT1);
-	omap_free_gpio(EXT_PHY_RESET_GPIO_PORT2);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
+	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
 #endif
=20
 	dev_dbg(hcd->self.controller,
--=20
1.6.0.1.196.g01914


--S1BNGpv0yoYahz37
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-omap-usb-ehci-fix-usage-of-resources.diff"
Content-Transfer-Encoding: quoted-printable

=46rom 7e25b8e03aec867002163b8618c126f16682ff52 Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <felipe.balbi@nokia.com>
Date: Sat, 13 Sep 2008 18:25:00 +0300
Subject: [PATCH 3/4] omap: usb: ehci: fix usage of resources

use platform_get_irq() and platform_get_resource instead
of trying to access struct resource * directly.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |   62 +++++++++++++++++++++++++++++---------=
----
 1 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index c73f832..4ac18b2 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -407,36 +407,42 @@ static const struct hc_driver ehci_omap_hc_driver;
 static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 {
 	int retval =3D 0;
+	int irq =3D platform_get_irq(dev, 0);
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
+	struct resource *resource;
=20
 	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_probe()");
=20
-	if (usb_disabled())
-		return -ENODEV;
+	if (usb_disabled()) {
+		retval =3D -ENODEV;
+		goto err_disabled;
+	}
=20
-	if (dev->resource[1].flags !=3D IORESOURCE_IRQ) {
-		dev_dbg(&dev->dev, "resource[1] is not IORESOURCE_IRQ");
+	hcd =3D usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
+	if (!hcd) {
 		retval =3D -ENOMEM;
+		goto err_hcd;
 	}
=20
-	hcd =3D usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
-	if (!hcd)
-		return -ENOMEM;
+	resource =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!resource || irq =3D=3D 0) {
+		retval =3D -EINVAL;
+		goto err_resource;
+	}
=20
 	retval =3D omap_start_ehc(dev, hcd);
 	if (retval)
-		return retval;
+		goto err_start;
=20
-	hcd->rsrc_start =3D 0;
-	hcd->rsrc_len =3D 0;
-	hcd->rsrc_start =3D dev->resource[0].start;
-	hcd->rsrc_len =3D dev->resource[0].end - dev->resource[0].start + 1;
+	hcd->rsrc_start =3D resource->start;
+	hcd->rsrc_len =3D resource->end - resource->start + 1;
=20
 	hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
 		dev_err(&dev->dev, "ioremap failed\n");
-		return -ENOMEM;
+		retval =3D -ENOMEM;
+		goto err_ioremap;
 	}
=20
 	ehci =3D hcd_to_ehci(hcd);
@@ -449,16 +455,34 @@ static int ehci_hcd_omap_drv_probe(struct platform_de=
vice *dev)
 	/* SET 1 micro-frame Interrupt interval */
 	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
=20
-	retval =3D usb_add_hcd(hcd, dev->resource[1].start,
-				IRQF_DISABLED | IRQF_SHARED);
-	if (retval =3D=3D 0)
-		return retval;
+	retval =3D usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (retval) {
+		dev_err(&dev->dev, "failed to add hcd\n");
+		goto err_add_hcd;
+	}
=20
-	dev_dbg(hcd->self.controller, "ERR: add_hcd");
-	omap_stop_ehc(dev, hcd);
+	return 0;
+
+err_add_hcd:
+	ehci->hcs_params =3D 0;
+	ehci->regs =3D NULL;
+	ehci->caps =3D NULL;
+	ehci =3D NULL;
 	iounmap(hcd->regs);
+	omap_stop_ehc(dev, hcd);
+
+err_ioremap:
+	hcd->rsrc_start =3D 0;
+	hcd->rsrc_len =3D 0;
+
+err_start:
+	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
=20
+err_hcd:
+err_resource:
+err_disabled:
+	dev_dbg(&dev->dev, "failed to initialized host controller\n");
 	return retval;
 }
=20
--=20
1.6.0.1.196.g01914


--S1BNGpv0yoYahz37
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0004-omap-usb-ehci-support-final-revision-of-usb-board.diff"
Content-Transfer-Encoding: quoted-printable

=46rom 775b30a9724fa3274702621b8e595ad35374bf3b Mon Sep 17 00:00:00 2001
=46rom: Vikram Pandita <vikram.pandita@ti.com>
Date: Sat, 13 Sep 2008 18:31:04 +0300
Subject: [PATCH 4/4] omap: usb: ehci: support final revision of usb board

Code changes for final rev of EHCI/OHCI USB expansion board
750-2099-001(C) with hw bug fixes to support ISP1504 PHY in
input clocking mode.

The board has 12-pin ULPI Port1 and Port2 EHCI pins connected
to ISP1504's. Port3 is connected to ISP1301 for connection to
OHCI.

This is the final USB expansion board that will be released
and so the bug fixes are critical. Changes tested on SDP3430.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |   37 ++++++-------------------------------
 1 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 4ac18b2..f8316d5 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -34,7 +34,7 @@
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 /* EHCI connected to External PHY */
=20
-/* External USB connectivity board: 750-2083-001
+/* External USB connectivity board: 750-2099-001(C)
  * Connected to OMAP3430 SDP
  * The board has Port1 and Port2 connected to ISP1504 in 12-pin ULPI mode
  */
@@ -49,14 +49,7 @@
 #define EXTERNAL_PHY_RESET
 #define	EXT_PHY_RESET_GPIO_PORT1	(57)
 #define	EXT_PHY_RESET_GPIO_PORT2	(61)
-#define	EXT_PHY_RESET_DELAY		(10)
-
-/* ISSUE2:
- * USBHOST supports External charge pump PHYs only
- * Use the VBUS from Port1 to power VBUS of Port2 externally
- * So use Port2 as the working ULPI port
- */
-#define VBUS_INTERNAL_CHARGEPUMP_HACK
+#define	EXT_PHY_RESET_DELAY		(500)
=20
 #endif /* CONFIG_OMAP_EHCI_PHY_MODE */
=20
@@ -223,9 +216,9 @@ static int omap_start_ehc(struct platform_device *dev, =
struct usb_hcd *hcd)
 #ifdef EXTERNAL_PHY_RESET
 	/* Refer: ISSUE1 */
 	gpio_request(EXT_PHY_RESET_GPIO_PORT1, "reset_port1");
-	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 1);
 	gpio_request(EXT_PHY_RESET_GPIO_PORT2, "reset_port2");
-	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 1);
 	/* Hold the PHY in RESET for enough time till DIR is high */
 	udelay(EXT_PHY_RESET_DELAY);
 #endif
@@ -301,26 +294,8 @@ static int omap_start_ehc(struct platform_device *dev,=
 struct usb_hcd *hcd)
 	 * Hold the PHY in RESET for enough time till PHY is settled and ready
 	 */
 	udelay(EXT_PHY_RESET_DELAY);
-	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 1);
-	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 1);
-#endif
-
-#ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
-	/* Refer ISSUE2: LINK assumes external charge pump */
-
-	/* use Port1 VBUS to charge externally Port2:
-	 *	So for PHY mode operation use Port2 only
-	 */
-	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
-			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
-			(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
-			(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
-			(0x26),
-			EHCI_INSNREG05_ULPI);
-
-	while (!(omap_readl(EHCI_INSNREG05_ULPI) &
-		(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
-
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
 #endif
=20
 	return 0;
--=20
1.6.0.1.196.g01914


--S1BNGpv0yoYahz37--
