From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] fix:memory:omap-gpmc:mark symbols static where possible
Date: Sun, 28 Aug 2016 13:28:15 +0800
Message-ID: <1472362095-15715-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@linaro.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn
List-Id: linux-omap@vger.kernel.org

We get 1 warning when build kernel with W=1:
drivers/memory/omap-gpmc.c:354:14: warning: no previous prototype for 'gpmc_clk_ticks_to_ns' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is declared
and don't need a declaration, but can be made static.
so this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 869c83f..f71cbf7 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -350,7 +350,7 @@ static unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
 	return (time_ps + tick_ps - 1) / tick_ps;
 }
 
-unsigned int gpmc_clk_ticks_to_ns(unsigned ticks, int cs,
+static unsigned int gpmc_clk_ticks_to_ns(unsigned int ticks, int cs,
 				  enum gpmc_clk_domain cd)
 {
 	return ticks * gpmc_get_clk_period(cs, cd) / 1000;
-- 
2.7.4
