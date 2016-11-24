From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] ARM: omap2: am437x: rollback to use omap3_gptimer_timer_init()
Date: Thu, 24 Nov 2016 11:49:14 +0530
Message-ID: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The commit 55ee7017ee31 ("arm: omap2: board-generic: use
omap4_local_timer_init for AM437x") unintentionally changes the
clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.

Unfortunately, the SyncTimer32K is starving from frequency deviation
as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
as clocksource") and, as reported by Franklin [1], even its monotonic
nature is under question (most probably there is a HW issue, but it's
still under investigation).

Taking into account above facts It's reasonable to rollback to the use
of omap3_gptimer_timer_init().

[1] http://www.spinics.net/lists/linux-omap/msg127425.html
Reported-by: Cooper Jr., Franklin <fcooper@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 arch/arm/mach-omap2/timer.c         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 36d9943..dc9e34e 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -304,7 +304,7 @@ static void __init rx51_reserve(void)
 	.init_late	= am43xx_init_late,
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap4_local_timer_init,
+	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= am43_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5e2e221..b2f2448 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -510,18 +510,19 @@ void __init omap3_secure_sync32k_timer_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || \
+	defined(CONFIG_SOC_AM43XX)
 void __init omap3_gptimer_timer_init(void)
 {
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
 			1, "timer_sys_ck", "ti,timer-alwon", true);
-
-	clocksource_probe();
+	if (of_have_populated_dt())
+		clocksource_probe();
 }
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) ||		\
-	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
+	defined(CONFIG_SOC_DRA7XX)
 static void __init omap4_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
-- 
1.9.1
