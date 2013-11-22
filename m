From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 4/8] ARM: OMAP4: timer: Remove non-DT code for TWD timer
Date: Thu, 21 Nov 2013 19:56:50 -0600
Message-ID: <1385085414-9034-5-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385085414-9034-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: benoit.cousson@linaro.org, santosh.shilimkar@ti.com, jgchunter@gmail.com, rnayak@ti.com, balbi@ti.com, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP4 is DT only boot and TWD local timer will be created from clocksource-of
layer. We remove OMAP4 code that creates it for non-DT.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index d42da7e..dd41f57 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -605,32 +605,17 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-#ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	/* Local timers are not supprted on OMAP4430 ES1.0 */
-	if (omap_rev() != OMAP4430_REV_ES1_0) {
-		int err;
-
-		if (of_have_populated_dt()) {
-			clocksource_of_init();
-			return;
-		}
 
-		err = twd_local_timer_register(&twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
-	}
-}
-#else
-void __init omap4_local_timer_init(void)
-{
-	omap4_sync32k_timer_init();
-}
-#endif /* CONFIG_HAVE_ARM_TWD */
+#ifdef CONFIG_HAVE_ARM_TWD
+	/* TWD Local timers are not supprted on OMAP4430 ES1.0 */
+	if (omap_rev() != OMAP4430_REV_ES1_0)
+		clocksource_of_init();
 #endif /* CONFIG_ARCH_OMAP4 */
+}
+#endif
 
 #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
 void __init omap5_realtime_timer_init(void)
-- 
1.8.1.2
