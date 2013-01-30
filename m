From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ARM: omap2: register cpufreq-cpu0 device for am33xx
Date: Wed, 30 Jan 2013 22:32:22 +0800
Message-ID: <1359556342-17020-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:32533
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082Ab3A3Ocj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 09:32:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, AnilKumar Ch <anilkumar@ti.com>, Shawn Guo <shawn.guo@linaro.org>

The cpufreq-cpu0 driver changes to instantiate use platform_driver
mechanism.  The patch is an am33xx platform level adaptation for it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-omap2/board-generic.c   |    1 +
 arch/arm/mach-omap2/cclock33xx_data.c |    2 +-
 arch/arm/mach-omap2/common.h          |    1 +
 arch/arm/mach-omap2/io.c              |    8 ++++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 53cb380b..b945480 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -139,6 +139,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= am33xx_init_late,
 	.timer		= &omap3_am33xx_timer,
 	.dt_compat	= am33xx_boards_compat,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ea64ad6..acb1620 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -850,7 +850,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
-	CLK("cpu0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
+	CLK("cpufreq-cpu0.0",	NULL,		&dpll_mpu_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 948bcaa..e3355df5 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -106,6 +106,7 @@ void omap2430_init_late(void);
 void omap3430_init_late(void);
 void omap35xx_init_late(void);
 void omap3630_init_late(void);
+void am33xx_init_late(void);
 void am35xx_init_late(void);
 void ti81xx_init_late(void);
 void omap4430_init_late(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2c3fdd6..0e67711 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -535,6 +535,14 @@ void __init omap3630_init_late(void)
 	omap2_clk_enable_autoidle_all();
 }
 
+void __init am33xx_init_late(void)
+{
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+
+	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0))
+		platform_device_register_full(&devinfo);
+}
+
 void __init am35xx_init_late(void)
 {
 	omap_mux_late_init();
-- 
1.7.9.5


