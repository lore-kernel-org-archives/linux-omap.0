From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP3 EHCI: use clock framework to program DPLL5,
	DPLL5_M2_CLK
Date: Thu, 11 Dec 2008 14:22:40 -0700
Message-ID: <20081211212239.22860.56824.stgit@localhost.localdomain>
References: <20081211212030.22860.49518.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51042 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130AbYLKVZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 16:25:12 -0500
In-Reply-To: <20081211212030.22860.49518.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

For testing only, not for merging.

Use the clock framework to program DPLL5, DPLL5_M2_CLK.
---
 drivers/usb/host/ehci-omap.c |   57 +++++++++++++++++++++++++++---------------
 1 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 5252e75..2057f58 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -70,6 +70,8 @@ struct ehci_omap_clock_defs {
 	struct clk	*usbhost1_48m_fck_clk;
 	struct clk	*usbtll_fck_clk;
 	struct clk	*usbtll_ick_clk;
+	struct clk	*dpll5_clk;
+	struct clk	*dpll5_m2_clk;
 };
 
 /* Clock names as per clock framework: May change so keep as #defs */
@@ -163,28 +165,29 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 				((char *)hcd_to_ehci(hcd)) +
 					sizeof(struct ehci_hcd));
 
-	/* Start DPLL5 Programming:
-	 * Clock Framework is not doing this now:
-	 * This will be done in clock framework later
+	/*
+	 * Make sure DPLL5 is programmed for 120MHz
+	 * XXX should be done at DPLL init time
+	 * XXX dpll rates should be assigned to clk->rate at init time
+	 * XXX enable DPLL autoidle
 	 */
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
-		dev_dbg(hcd->self.controller,
-			"idlest2 = 0x%x\n",
-			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
-	/* End DPLL5 programming */
+	ehci_clocks->dpll5_clk = clk_get(&dev->dev, "dpll5_ck");
+	if (IS_ERR(ehci_clocks->dpll5_clk)) {
+		WARN_ON(1);
+		return PTR_ERR(ehci_clocks->dpll5_clk);
+	};
+	if (clk_get_rate(ehci_clocks->dpll5_clk) != 120000000)
+		clk_set_rate(ehci_clocks->dpll5_clk, 120000000);
+	clk_enable(ehci_clocks->dpll5_clk);
+
+	/* Program dpll5_m2_clk divider for no division */
+	ehci_clocks->dpll5_m2_clk = clk_get(&dev->dev, "dpll5_m2_ck");
+	if (IS_ERR(ehci_clocks->dpll5_m2_clk)) {
+		WARN_ON(1);
+		return PTR_ERR(ehci_clocks->dpll5_m2_clk);
+	};
+	clk_enable(ehci_clocks->dpll5_m2_clk);
+	clk_set_rate(ehci_clocks->dpll5_m2_clk, 120000000);
 
 	/* Enable Clocks for USBHOST */
 	ehci_clocks->usbhost_ick_clk = clk_get(&dev->dev,
@@ -375,6 +378,18 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 		ehci_clocks->usbtll_ick_clk = NULL;
 	}
 
+	if (ehci_clocks->dpll5_m2_clk != NULL) {
+		clk_disable(ehci_clocks->dpll5_m2_clk);
+		clk_put(ehci_clocks->dpll5_m2_clk);
+		ehci_clocks->dpll5_m2_clk = NULL;
+	}
+
+	if (ehci_clocks->dpll5_clk != NULL) {
+		clk_disable(ehci_clocks->dpll5_clk);
+		clk_put(ehci_clocks->dpll5_clk);
+		ehci_clocks->dpll5_clk = NULL;
+	}
+
 
 #ifdef EXTERNAL_PHY_RESET
 	gpio_free(EXT_PHY_RESET_GPIO_PORT1);


