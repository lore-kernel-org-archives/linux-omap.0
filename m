From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 15/36] CLK: TI: omap5: Initialize USB_DPLL at boot
Date: Wed, 25 Sep 2013 11:48:21 +0300
Message-ID: <1380098922-30340-16-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411Ab3IYIuL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 04:50:11 -0400
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
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
index efa81ab..e39e03d 100644
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
 static struct ti_dt_clk omap54xx_clks[] = {
 	DT_CLK(NULL, "pad_clks_src_ck", "pad_clks_src_ck"),
 	DT_CLK(NULL, "pad_clks_ck", "pad_clks_ck"),
@@ -220,7 +226,7 @@ static struct ti_dt_clk omap54xx_clks[] = {
 int __init omap5xxx_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck;
+	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
 
 	of_clk_init(NULL);
 
@@ -237,5 +243,15 @@ int __init omap5xxx_clk_init(void)
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

