From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] clk: ti: clk-54xx: Set the rate for dpll_abe_m2x2_ck
Date: Wed, 30 Apr 2014 14:39:37 +0300
Message-ID: <1398857977-30114-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@linaro.org, t-kristo@ti.com, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In order to get correct clock dividers for AESS/ABE we need to set the
dpll_abe_m2x2_ck rate to be double of dpll_abe_ck.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/ti/clk-54xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 08f3d1b915b3..5e183993e3ec 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -240,6 +240,12 @@ int __init omap5xxx_dt_clk_init(void)
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
+	abe_dpll = clk_get_sys(NULL, "dpll_abe_m2x2_ck");
+	if (!rc)
+		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ * 2);
+	if (rc)
+		pr_err("%s: failed to configure ABE m2x2 DPLL!\n", __func__);
+
 	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
 	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ);
 	if (rc)
-- 
1.9.2
