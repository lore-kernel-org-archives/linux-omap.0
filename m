From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 8/8] clk: ti: clk-7xx: Prevent possible ERR_PTR dereference
Date: Wed, 13 May 2015 15:54:47 +0900
Message-ID: <1431500087-2275-9-git-send-email-k.kozlowski@samsung.com>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:38322 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbbEMGzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 02:55:21 -0400
In-reply-to: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The return value of clk_get_sys() was immediately used in
clk_set_parent() and clk_set_rate(). The first one may return ERR_PTR
and the latter only checks if supplied argument is non-NULL.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/ti/clk-7xx.c | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 5d2217ae4478..ce1a77092788 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -308,44 +308,52 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	{ .node_name = NULL },
 };
 
-int __init dra7xx_dt_clk_init(void)
+static void __init dra7xx_dt_clk_abe_dpll_init(void)
 {
 	int rc;
 	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
 
-	ti_dt_clocks_register(dra7xx_clks);
-
-	omap2_clk_disable_autoidle_all();
-
 	abe_dpll_mux = clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
 	sys_clkin2 = clk_get_sys(NULL, "sys_clkin2");
 	dpll_ck = clk_get_sys(NULL, "dpll_abe_ck");
 
+	if (IS_ERR(abe_dpll_mux) || IS_ERR(sys_clkin2) || IS_ERR(dpll_ck)) {
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+		return;
+	}
+
 	rc = clk_set_parent(abe_dpll_mux, sys_clkin2);
 	if (!rc)
 		rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+}
 
-	dpll_ck = clk_get_sys(NULL, "dpll_abe_m2x2_ck");
-	rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ * 2);
-	if (rc)
-		pr_err("%s: failed to configure ABE DPLL m2x2!\n", __func__);
-
-	dpll_ck = clk_get_sys(NULL, "dpll_gmac_ck");
-	rc = clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure GMAC DPLL!\n", __func__);
+static int __init dra7xx_dt_clk_dpll_init(const char *clk_name,
+				    unsigned long rate)
+{
+	int rc = -EINVAL;
+	struct clk *clk;
 
-	dpll_ck = clk_get_sys(NULL, "dpll_usb_ck");
-	rc = clk_set_rate(dpll_ck, DRA7_DPLL_USB_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure USB DPLL!\n", __func__);
+	clk = clk_get_sys(NULL, clk_name);
+	if (!IS_ERR(clk))
+		rc = clk_set_rate(clk, rate);
 
-	dpll_ck = clk_get_sys(NULL, "dpll_usb_m2_ck");
-	rc = clk_set_rate(dpll_ck, DRA7_DPLL_USB_DEFFREQ/2);
 	if (rc)
-		pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
+		pr_err("%s: failed to configure %s!\n", __func__, clk_name);
 
 	return rc;
 }
+
+int __init dra7xx_dt_clk_init(void)
+{
+	ti_dt_clocks_register(dra7xx_clks);
+
+	omap2_clk_disable_autoidle_all();
+
+	dra7xx_dt_clk_abe_dpll_init();
+	dra7xx_dt_clk_dpll_init("dpll_abe_m2x2_ck", DRA7_DPLL_ABE_DEFFREQ * 2);
+	dra7xx_dt_clk_dpll_init("dpll_gmac_ck", DRA7_DPLL_GMAC_DEFFREQ);
+	dra7xx_dt_clk_dpll_init("dpll_usb_ck", DRA7_DPLL_USB_DEFFREQ);
+	return dra7xx_dt_clk_dpll_init("dpll_usb_m2_ck", DRA7_DPLL_USB_DEFFREQ/2);
+}
-- 
1.9.1

