From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 07/28] ARM: OMAP2+: timer: change order of hwmod data handling
Date: Thu, 14 Apr 2016 14:07:56 +0300
Message-ID: <1460632097-25727-8-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the introduction of hwmod module clocks, the name of the hwmod
main clk may not be available before hwmod setup, as hwmod setup
may lookup the main clock dynamically based on the hwmod name.
Thus, change the order of hwmod setup and main clock handling for
the timer code, to make sure the main clock is going to be
available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/timer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 08e08db..77fb4e1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -290,6 +290,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!timer->io_base)
 		return -ENXIO;
 
+	omap_hwmod_setup_one(oh_name);
+
 	/* After the dmtimer is using hwmod these clocks won't be needed */
 	timer->fclk = ti_clk_get(omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
@@ -304,7 +306,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	clk_put(src);
 
-	omap_hwmod_setup_one(oh_name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
 
-- 
1.7.9.5

