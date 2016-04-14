From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 21/28] clk: ti: am33xx: fix timer3/6 init time setup for module clocks
Date: Thu, 14 Apr 2016 14:08:10 +0300
Message-ID: <1460632097-25727-22-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

timer*_fck are going to be renamed as timer*_mod_ck:s. Fix the init
time configuration of timer3/timer6 to take this into account, and
lookup for the module clock in case the lookup for fck fails.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clk-33xx.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 43847bc..2343a22 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -66,9 +66,15 @@ int __init am33xx_dt_clk_init(void)
 
 	clk1 = ti_clk_get("sys_clkin_ck");
 	clk2 = ti_clk_get("timer3_fck");
+	if (IS_ERR(clk2))
+		clk2 = ti_clk_get("timer3_mod_ck");
+
 	clk_set_parent(clk2, clk1);
 
 	clk2 = ti_clk_get("timer6_fck");
+	if (IS_ERR(clk2))
+		clk2 = ti_clk_get("timer6_mod_ck");
+
 	clk_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
