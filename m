From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 6/8] clk: ti: clk-43xx: Prevent possible ERR_PTR dereference
Date: Wed, 13 May 2015 15:54:45 +0900
Message-ID: <1431500087-2275-7-git-send-email-k.kozlowski@samsung.com>
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
 drivers/clk/ti/clk-44xx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 581db7711f51..6b045ed31747 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -281,9 +281,11 @@ int __init omap4xxx_dt_clk_init(void)
 	 * domain can transition to retention state when not in use.
 	 */
 	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
-	rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
-	if (rc)
-		pr_err("%s: failed to configure USB DPLL!\n", __func__);
+	if (!IS_ERR(usb_dpll)) {
+		rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
+		if (rc)
+			pr_err("%s: failed to configure USB DPLL!\n", __func__);
+	}
 
 	/*
 	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
@@ -293,9 +295,15 @@ int __init omap4xxx_dt_clk_init(void)
 	 */
 	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_refclk_mux_ck");
 	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
+	if (IS_ERR(abe_dpll_ref) || IS_ERR(sys_32k_ck)) {
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+		return 0;
+	}
+
 	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
+
 	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
-	if (!rc)
+	if (!rc && !IS_ERR(abe_dpll))
 		rc = clk_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
-- 
1.9.1
