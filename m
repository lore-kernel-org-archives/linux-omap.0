From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP3 EHCI: drop unnecessary debug writes,
	per Vikram Pandita
Date: Thu, 11 Dec 2008 14:22:39 -0700
Message-ID: <20081211212233.22860.28517.stgit@localhost.localdomain>
References: <20081211212030.22860.49518.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51040 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076AbYLKVZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 16:25:12 -0500
In-Reply-To: <20081211212030.22860.49518.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Drop some PRCM-related register writes that now appear to be
unnecessasry:

http://marc.info/?l=linux-omap&m=122901972412835&w=2

Cc: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/host/ehci-omap.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1b3266c..5252e75 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -186,22 +186,6 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
 	/* End DPLL5 programming */
 
-
-	/* PRCM settings for USBHOST:
-	 * Interface clk un-related to domain transition
-	 */
-	cm_write_mod_reg(0 << OMAP3430ES2_AUTO_USBHOST_SHIFT,
-				OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
-
-	/* Disable sleep dependency with MPU and IVA */
-	cm_write_mod_reg((0 << OMAP3430ES2_EN_MPU_SHIFT) |
-				(0 << OMAP3430ES2_EN_IVA2_SHIFT),
-				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
-
-	/* Disable Automatic transition of clock */
-	cm_write_mod_reg(0 << OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT,
-				OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
-
 	/* Enable Clocks for USBHOST */
 	ehci_clocks->usbhost_ick_clk = clk_get(&dev->dev,
 						USBHOST_ICKL);


