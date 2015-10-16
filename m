From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 08/11] arm: omap2: timer: rename omap_sync32k_timer_init()
Date: Fri, 16 Oct 2015 11:22:07 -0500
Message-ID: <1445012530-14126-9-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

this function is not only about the 32k sync
timer, it's OMAP's generic init_time implementation.

Let's rename it to make that detail easier to
notice.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 10 +++++-----
 arch/arm/mach-omap2/board-ldp.c     |  2 +-
 arch/arm/mach-omap2/board-rx51.c    |  2 +-
 arch/arm/mach-omap2/common.h        |  2 +-
 arch/arm/mach-omap2/timer.c         |  2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index f00aa29099d4..a99db5b550b7 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -46,7 +46,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap242x_boards_compat,
 	.restart	= omap2xxx_restart,
 MACHINE_END
@@ -63,7 +63,7 @@ DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap243x_boards_compat,
 	.restart	= omap2xxx_restart,
 MACHINE_END
@@ -82,7 +82,7 @@ DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= n900_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -100,7 +100,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_early	= omap3430_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap3_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
@@ -116,7 +116,7 @@ DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
 	.init_early	= omap3630_init_early,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap3_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.dt_compat	= omap36xx_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 0d3a57c6931f..d9c3ffc39329 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -424,6 +424,6 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= omap_ldp_init,
 	.init_late	= omap3430_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 830256c434ec..41161ca97d74 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -136,6 +136,6 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_irq	= omap3_init_irq,
 	.init_machine	= rx51_init,
 	.init_late	= omap3430_init_late,
-	.init_time	= omap_sync32k_timer_init,
+	.init_time	= omap_init_time,
 	.restart	= omap3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 844ad031f7f0..0cba9575d2ca 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -88,7 +88,7 @@ static inline int omap_mux_late_init(void)
 
 extern void omap2_init_common_infrastructure(void);
 
-extern void omap_sync32k_timer_init(void);
+extern void omap_init_time(void);
 extern void omap3_secure_sync32k_timer_init(void);
 extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 851f3ad9e970..d024b2bb5c4c 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -492,7 +492,7 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
 		omap2_sync32k_clocksource_init();
 }
 
-void __init omap_sync32k_timer_init(void)
+void __init omap_init_time(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
-- 
2.5.3
