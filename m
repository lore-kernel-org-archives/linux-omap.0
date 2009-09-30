From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap3: ehci: remove DPLL5 programming
Date: Wed, 30 Sep 2009 23:07:01 +0530
Message-ID: <1254332221-29490-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46206 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480AbZI3RhC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Sep 2009 13:37:02 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8UHb38h015975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 12:37:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

omap3: ehci: remove DPLL5 programming

DPLL5 programming should be taken care of by the clock framework.
The driver should not need to worry about programming this
explicitly.

Also, the DPLL5 m and n values used were valid only for a
specific value of the system clock. So they would not work
correctly for other input frequencies anyway.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Needs http://patchwork.kernel.org/patch/46216/ to
ensure the DPLL is locked correctly.

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f2771cf..7efc2f5 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -225,8 +225,6 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 
 /*-------------------------------------------------------------------------*/
 
-#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
-
 /* omap_start_ehc
  *	- Start the TI USBHOST controller
  */
@@ -239,29 +237,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
 
-	/* Start DPLL5 Programming:
-	 * Clock Framework is not doing this now:
-	 * This will be done in clock framework later
-	 */
-	/* Enable DPLL 5 : Based on Input of 13Mhz*/
-	cm_write_mod_reg((12 << OMAP3430ES2_PERIPH2_DPLL_DIV_SHIFT)|
-			(120 << OMAP3430ES2_PERIPH2_DPLL_MULT_SHIFT),
-			PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
-
-	cm_write_mod_reg(1 << OMAP3430ES2_DIV_120M_SHIFT,
-			PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
-
-	cm_write_mod_reg((7 << OMAP3430ES2_PERIPH2_DPLL_FREQSEL_SHIFT) |
-			(7 << OMAP3430ES2_EN_PERIPH2_DPLL_SHIFT),
-			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
-
-	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
-				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
-		dev_dbg(omap->dev, "idlest2 = 0x%x\n",
-			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
-	/* End DPLL5 programming */
-
-
 	/* Enable Clocks for USBHOST */
 	omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
 	if (IS_ERR(omap->usbhost_ick)) {
