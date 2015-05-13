From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 2/8] clk: ti: clk-2xxx: Prevent possible ERR_PTR dereference
Date: Wed, 13 May 2015 15:54:41 +0900
Message-ID: <1431500087-2275-3-git-send-email-k.kozlowski@samsung.com>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Provide a wrapper to prevent possible ERR_PTR dereference by
clk_get_rate().

The return value of clk_get_sys() was immediately used in
clk_get_rate(). The first one may return ERR_PTR and the latter only
checks if supplied argument is non-NULL.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/ti/clk-2xxx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk-2xxx.c b/drivers/clk/ti/clk-2xxx.c
index c808ab3d2bb2..d6996c3db843 100644
--- a/drivers/clk/ti/clk-2xxx.c
+++ b/drivers/clk/ti/clk-2xxx.c
@@ -220,6 +220,16 @@ enum {
 	OMAP2_SOC_OMAP2430,
 };
 
+static unsigned long __init omap2xxx_clk_get_rate(const char *clk_name)
+{
+	struct clk *clk = clk_get_sys(NULL, clk_name);
+
+	if (IS_ERR(clk))
+		return 0;
+
+	return clk_get_rate(clk);
+}
+
 static int __init omap2xxx_dt_clk_init(int soc_type)
 {
 	ti_dt_clocks_register(omap2xxx_clks);
@@ -237,10 +247,10 @@ static int __init omap2xxx_dt_clk_init(int soc_type)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(clk_get_sys(NULL, "sys_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "sys_ck")) / 100000) % 10,
-		(clk_get_rate(clk_get_sys(NULL, "dpll_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "mpu_ck")) / 1000000));
+		(omap2xxx_clk_get_rate("sys_ck") / 1000000),
+		(omap2xxx_clk_get_rate("sys_ck") / 100000) % 10,
+		(omap2xxx_clk_get_rate("dpll_ck") / 1000000),
+		(omap2xxx_clk_get_rate("mpu_ck") / 1000000));
 
 	return 0;
 }
-- 
1.9.1
