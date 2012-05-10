From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: am33xx: Add AM335XEVM machine support
Date: Fri, 11 May 2012 00:38:49 +0530
Message-ID: <1336676929-28621-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761505Ab2EJTKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 15:10:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

From: Afzal Mohammed <afzal@ti.com>

This patch adds minimal support for AM335X machine init.

During last merge window, two separate patches supporting am33xx
machine init had been submitted,

1. Link to earlier Baseport patch submission (Legacy):
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg59325.html
2. Link to earlier DT based machine init support patch submission:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg61398.html

And both had got accepted at that time, but got missed during
merge window.

But now, since we have taken decision to make am33xx as a separate
class and not to follow omap3 family, these patches needs to changes
accordingly (only changes),

 - Combine both the patches, since early init and timer init
   used in board-generic.c file requires them.
 - Remove dependency on AM3517EVM, and only use DT approach
   for machine init.
 - Change the config option (as changed recently)
   CONFIG_SOC_OMAPAM33XX --> CONFIG_SOC_AM33XX

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-generic.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/common.h        |    2 ++
 arch/arm/mach-omap2/io.c            |   10 ++++++++++
 arch/arm/mach-omap2/irq.c           |    2 +-
 arch/arm/mach-omap2/timer.c         |    5 +++++
 5 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 098d183..7dcd342 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -129,6 +129,24 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 MACHINE_END
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+static const char *am33xx_boards_compat[] __initdata = {
+	"ti,am33xx",
+	NULL,
+};
+
+DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= am33xx_map_io,
+	.init_early	= am33xx_init_early,
+	.init_irq	= omap_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= omap_generic_init,
+	.timer		= &omap3_am33xx_timer,
+	.dt_compat	= am33xx_boards_compat,
+MACHINE_END
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 static struct twl4030_platform_data sdp4430_twldata = {
 	.irq_base	= TWL6030_IRQ_BASE,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 267540b..aaab1d5 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -83,6 +83,7 @@ extern void omap2_init_common_infrastructure(void);
 extern struct sys_timer omap2_timer;
 extern struct sys_timer omap3_timer;
 extern struct sys_timer omap3_secure_timer;
+extern struct sys_timer omap3_am33xx_timer;
 extern struct sys_timer omap4_timer;
 
 void omap2420_init_early(void);
@@ -93,6 +94,7 @@ void omap3630_init_early(void);
 void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti81xx_init_early(void);
+void am33xx_init_early(void);
 void omap4430_init_early(void);
 void omap_prcm_restart(char, const char *);
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index bafa592..df4d119 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -438,6 +438,16 @@ void __init ti81xx_init_early(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+void __init am33xx_init_early(void)
+{
+	omap2_set_globals_am33xx();
+	omap3xxx_check_revision();
+	ti81xx_check_features();
+	omap_common_init_early();
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 void __init omap4430_init_early(void)
 {
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 34496fe..3ce9312 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -278,7 +278,7 @@ int __init omap_intc_of_init(struct device_node *node,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
 void omap_intc_save_context(void)
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ecec873..61dbe41 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -332,6 +332,11 @@ OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
 OMAP_SYS_TIMER(3_secure)
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER(3_am33xx)
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_LOCAL_TIMERS
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
-- 
1.7.0.4

