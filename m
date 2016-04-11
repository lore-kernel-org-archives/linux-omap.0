From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 14/30] clk: ti: dm816x: cleanup any unnecessary clock aliases
Date: Mon, 11 Apr 2016 11:19:05 +0300
Message-ID: <1460362761-4842-15-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Cleanup any unnecessary DT_CLK() alias entries from the DM816x clock file.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clk-816x.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 2a5d84f..e0a984e 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -17,25 +17,9 @@
 #include "clock.h"
 
 static struct ti_dt_clk dm816x_clks[] = {
-	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
 	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
-	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
-	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
-	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
-	DT_CLK(NULL, "timer3_fck", "timer3_fck"),
-	DT_CLK(NULL, "timer4_fck", "timer4_fck"),
-	DT_CLK(NULL, "timer5_fck", "timer5_fck"),
-	DT_CLK(NULL, "timer6_fck", "timer6_fck"),
-	DT_CLK(NULL, "timer7_fck", "timer7_fck"),
-	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
-	DT_CLK(NULL, "sysclk5_ck", "sysclk5_ck"),
-	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
-	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
-	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
-	DT_CLK(NULL, "sysclk24_ck", "sysclk24_ck"),
 	DT_CLK("4a100000.ethernet", "sysclk24_ck", "sysclk24_ck"),
 	{ .node_name = NULL },
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
