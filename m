From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 7/8] clk: ti: clk-54xx: Prevent possible ERR_PTR dereference
Date: Wed, 13 May 2015 15:54:46 +0900
Message-ID: <1431500087-2275-8-git-send-email-k.kozlowski@samsung.com>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

The return value of clk_get_sys() was immediately used in
clk_set_parent() and clk_set_rate(). The first one may return ERR_PTR
and the latter only checks if supplied argument is non-NULL.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/ti/clk-54xx.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 96c69a335975..1e7ed6334ab4 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -222,39 +222,56 @@ static struct ti_dt_clk omap54xx_clks[] = {
 	{ .node_name = NULL },
 };
 
-int __init omap5xxx_dt_clk_init(void)
+static void __init omap5xxx_dt_clk_abe_dpll_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
-
-	ti_dt_clocks_register(omap54xx_clks);
-
-	omap2_clk_disable_autoidle_all();
+	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck;
 
 	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_clk_mux");
 	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
+	if (IS_ERR(abe_dpll_ref) || IS_ERR(sys_32k_ck)) {
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+		return;
+	}
+
 	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
+
 	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
-	if (!rc)
+	if (!rc && !IS_ERR(abe_dpll))
 		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
 	abe_dpll = clk_get_sys(NULL, "dpll_abe_m2x2_ck");
-	if (!rc)
+	if (!rc && !IS_ERR(abe_dpll))
 		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ * 2);
 	if (rc)
 		pr_err("%s: failed to configure ABE m2x2 DPLL!\n", __func__);
+}
 
-	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
-	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure USB DPLL!\n", __func__);
+static void __init omap5xxx_dt_clk_usb_dpll_init(const char *clk_name,
+					  unsigned long rate)
+{
+	int rc = -EINVAL;
+	struct clk *clk;
+
+	clk = clk_get_sys(NULL, clk_name);
+	if (!IS_ERR(clk))
+		rc = clk_set_rate(clk, rate);
 
-	usb_dpll = clk_get_sys(NULL, "dpll_usb_m2_ck");
-	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ/2);
 	if (rc)
-		pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
+		pr_err("%s: failed to configure %s!\n", __func__, clk_name);
+}
+
+int __init omap5xxx_dt_clk_init(void)
+{
+	ti_dt_clocks_register(omap54xx_clks);
+
+	omap2_clk_disable_autoidle_all();
+
+	omap5xxx_dt_clk_abe_dpll_init();
+	omap5xxx_dt_clk_usb_dpll_init("dpll_usb_ck", OMAP5_DPLL_USB_DEFFREQ);
+	omap5xxx_dt_clk_usb_dpll_init("dpll_usb_m2_ck", OMAP5_DPLL_USB_DEFFREQ/2);
 
 	return 0;
 }
-- 
1.9.1
