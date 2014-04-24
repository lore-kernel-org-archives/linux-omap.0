From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 15/26] ARM: OMAP2+: timer: Use of_clk_get for DT platforms
Date: Thu, 24 Apr 2014 16:43:58 -0500
Message-ID: <1398375849-6017-16-git-send-email-joelf@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398375849-6017-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

For DT-booting platforms, use of_clk_get to get the fclk for system timers.
Separate out the legacy code for non-DT platform use.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ea91ef9..4fcfd7a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -277,6 +277,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!timer->io_base)
 			return -ENXIO;
 
+		timer->fclk = of_clk_get(np, 0);
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
+
 		r = omap_dmtimer_powerup(np);
 		if (r)
 			return r;
@@ -308,14 +312,13 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!timer->io_base)
 			return -ENXIO;
 
+		timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
 
 		omap_hwmod_setup_one(oh_name);
 		omap_hwmod_enable(oh);
 	}
-	/* After the dmtimer is using hwmod these clocks won't be needed */
-	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
-	if (IS_ERR(timer->fclk))
-		return PTR_ERR(timer->fclk);
 
 	/*
 	 * Clock reparenting code, goes away for DT-boot atleast,
-- 
1.7.9.5
