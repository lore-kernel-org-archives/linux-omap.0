From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 3/7] ARM: OMAP2+: Simplify system timer clock definitions
Date: Mon, 4 Feb 2013 13:46:32 -0600
Message-ID: <1360007196-21350-4-git-send-email-jon-hunter@ti.com>
References: <1360007196-21350-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56627 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405Ab3BDTrX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 14:47:23 -0500
In-Reply-To: <1360007196-21350-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Jon Hunter <jon-hunter@ti.com>

In commit c59b537 (ARM: OMAP2+: Simplify dmtimer clock aliases), new
clock aliases for dmtimers were added to simplify the code. These clock
aliases can also be used when configuring the system timers and allow us
to remove the current definitions, simplifying the code.

Please note that for OMAP4/5 devices (unlike OMAP2/3 devices), there is
no clock alias for "timer_sys_ck" with NULL as the device name. Therefore
we still need to use the alias "sys_clkin_ck" for these devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |   37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c6b3fdd..b4a06c1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -57,15 +57,6 @@
 #include "common.h"
 #include "powerdomain.h"
 
-/* Parent clocks, eventually these will come from the clock framework */
-
-#define OMAP2_MPU_SOURCE	"sys_ck"
-#define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
-#define OMAP4_MPU_SOURCE	"sys_clkin_ck"
-#define OMAP2_32K_SOURCE	"func_32k_ck"
-#define OMAP3_32K_SOURCE	"omap_32k_fck"
-#define OMAP4_32K_SOURCE	"sys_32k_ck"
-
 #define REALTIME_COUNTER_BASE				0x48243200
 #define INCREMENTER_NUMERATOR_OFFSET			0x10
 #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET		0x14
@@ -569,27 +560,27 @@ void __init omap##name##_sync32k_timer_init(void)		\
 }
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_32K_TIMER_INIT(2, 1, OMAP2_32K_SOURCE, "ti,timer-alwon",
-			2, OMAP2_MPU_SOURCE);
+OMAP_SYS_32K_TIMER_INIT(2, 1, "timer_32k_ck", "ti,timer-alwon",
+			2, "timer_sys_ck");
 #endif /* CONFIG_ARCH_OMAP2 */
 
 #ifdef CONFIG_ARCH_OMAP3
-OMAP_SYS_32K_TIMER_INIT(3, 1, OMAP3_32K_SOURCE, "ti,timer-alwon",
-			2, OMAP3_MPU_SOURCE);
-OMAP_SYS_32K_TIMER_INIT(3_secure, 12, OMAP3_32K_SOURCE, "ti,timer-secure",
-			2, OMAP3_MPU_SOURCE);
-OMAP_SYS_GP_TIMER_INIT(3_gp, 1, OMAP3_MPU_SOURCE, "ti,timer-alwon",
-		       2, OMAP3_MPU_SOURCE);
+OMAP_SYS_32K_TIMER_INIT(3, 1, "timer_32k_ck", "ti,timer-alwon",
+			2, "timer_sys_ck");
+OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
+			2, "timer_sys_ck");
+OMAP_SYS_GP_TIMER_INIT(3_gp, 1, "timer_sys_ck", "ti,timer-alwon",
+		       2, "timer_sys_ck");
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_GP_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, "ti,timer-alwon",
-		       2, OMAP4_MPU_SOURCE);
+OMAP_SYS_GP_TIMER_INIT(3_am33xx, 1, "timer_sys_ck", "ti,timer-alwon",
+		       2, "timer_sys_ck");
 #endif /* CONFIG_SOC_AM33XX */
 
 #ifdef CONFIG_ARCH_OMAP4
-OMAP_SYS_32K_TIMER_INIT(4, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
-			2, OMAP4_MPU_SOURCE);
+OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
+			2, "sys_clkin_ck");
 #ifdef CONFIG_LOCAL_TIMERS
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
@@ -618,8 +609,8 @@ void __init omap4_local_timer_init(void)
 #endif /* CONFIG_ARCH_OMAP4 */
 
 #ifdef CONFIG_SOC_OMAP5
-OMAP_SYS_32K_TIMER_INIT(5, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
-			2, OMAP4_MPU_SOURCE);
+OMAP_SYS_32K_TIMER_INIT(5, 1, "timer_32k_ck", "ti,timer-alwon",
+			2, "sys_clkin_ck");
 void __init omap5_realtime_timer_init(void)
 {
 	int err;
-- 
1.7.10.4

