From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 11/31] CLK: TI: omap5: Initialize USB_DPLL at boot
Date: Fri, 2 Aug 2013 19:25:30 +0300
Message-ID: <1375460751-23676-12-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40748 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab3HBQ04 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:56 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

From: Roger Quadros <rogerq@ti.com>

USB_DPLL must be initialized and locked at boot so that
USB modules can work.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-54xx.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 52133e7..d539080 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -19,6 +19,12 @@
 
 #define OMAP5_DPLL_ABE_DEFFREQ				98304000
 
+/*
+ * OMAP543x TRM, section "3.6.3.9.5 DPLL_USB Preferred Settings"
+ * states it must be at 960MHz
+ */
+#define OMAP5_DPLL_USB_DEFFREQ				960000000
+
 static struct omap_dt_clk omap54xx_clks[] = {
 	DT_CLK(NULL, "timer_32k_ck", "sys_32k_ck"),
 	DT_CLK("omap_timer.1", "sys_ck", "sys_clkin"),
@@ -38,7 +44,7 @@ static struct omap_dt_clk omap54xx_clks[] = {
 int __init omap5xxx_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck;
+	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
 
 	of_clk_init(NULL);
 
@@ -55,5 +61,15 @@ int __init omap5xxx_clk_init(void)
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
+	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
+	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure USB DPLL!\n", __func__);
+
+	usb_dpll = clk_get_sys(NULL, "dpll_usb_m2_ck");
+	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ/2);
+	if (rc)
+		pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
+
 	return 0;
 }
-- 
1.7.9.5

