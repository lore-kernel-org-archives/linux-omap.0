From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 6/9] ARM: OMAP2+: timer: add support for fetching fck handle from DT
Date: Fri, 17 Mar 2017 11:09:38 +0200
Message-ID: <1489741781-12816-7-git-send-email-t-kristo@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The mux clock handle shall be provided via "fck" DT handle. This avoids
the need to lookup the main clock via hwmod core, which will not work
with the clkctrl clock support anymore; the main clock is not going to
be a mux.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 07dd692..af90f95 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -255,6 +255,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 		timer->io_base = of_iomap(np, 0);
 
+		timer->fclk = of_clk_get_by_name(np, "fck");
+
 		of_node_put(np);
 	} else {
 		if (omap_dm_timer_reserve_systimer(timer->id))
@@ -292,7 +294,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	omap_hwmod_setup_one(oh_name);
 
 	/* After the dmtimer is using hwmod these clocks won't be needed */
-	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
+	if (IS_ERR_OR_NULL(timer->fclk))
+		timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
 		return PTR_ERR(timer->fclk);
 
-- 
1.9.1

