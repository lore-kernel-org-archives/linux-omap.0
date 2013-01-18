From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/5] ARM: OMAP2+: timer: Update the OMAP5 clocksource name as per clock data
Date: Fri, 18 Jan 2013 21:02:18 +0530
Message-ID: <1358523141-12295-3-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40031 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab3ARPbf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 10:31:35 -0500
In-Reply-To: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP5 clockdata has different sys clock clock node name. Fix the timer code
to take care of it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 691aa67..a0a1b14 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -62,6 +62,7 @@
 #define OMAP2_MPU_SOURCE	"sys_ck"
 #define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
 #define OMAP4_MPU_SOURCE	"sys_clkin_ck"
+#define OMAP5_MPU_SOURCE	"sys_clkin"
 #define OMAP2_32K_SOURCE	"func_32k_ck"
 #define OMAP3_32K_SOURCE	"omap_32k_fck"
 #define OMAP4_32K_SOURCE	"sys_32k_ck"
@@ -498,7 +499,7 @@ static void __init realtime_counter_init(void)
 		pr_err("%s: ioremap failed\n", __func__);
 		return;
 	}
-	sys_clk = clk_get(NULL, "sys_clkin_ck");
+	sys_clk = clk_get(NULL, OMAP5_MPU_SOURCE);
 	if (IS_ERR(sys_clk)) {
 		pr_err("%s: failed to get system clock handle\n", __func__);
 		iounmap(base);
@@ -638,7 +639,7 @@ OMAP_SYS_TIMER(4, local);
 
 #ifdef CONFIG_SOC_OMAP5
 OMAP_SYS_32K_TIMER_INIT(5, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
-			2, OMAP4_MPU_SOURCE);
+			2, OMAP5_MPU_SOURCE);
 static void __init omap5_realtime_timer_init(void)
 {
 	int err;
-- 
1.7.9.5

