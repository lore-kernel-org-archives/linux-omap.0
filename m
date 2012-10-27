From: Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH] Add FDT support to Pandaboard initialization
Date: Sat, 27 Oct 2012 20:50:00 +0200
Message-ID: <1351363800-28744-1-git-send-email-const@MakeLinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tim.bird@am.sony.com, pandaboard@googlegroups.com, Tony Lindgren OMAP <tony@atomide.com>, Santosh Shilimkar OMAP <santosh.shilimkar@ti.com>, nsekhar@ti.com, balbi@ti.com, Constantine Shulyupin <const@MakeLinux.com>
List-Id: linux-omap@vger.kernel.org

From: Constantine Shulyupin <const@MakeLinux.com>

Problem:
- FDT is supported only by generic OMAP board initialization in arch/arm/mach-omap2/board-generic.c and lacks some configurations, which are not yet configured in FDT (USB for example).
Solution:
- arch/arm/mach-omap2/board-omap4panda.c supports initialization with FDT and without it.

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..fea7a83 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -31,6 +31,7 @@
 #include <linux/ti_wilink_st.h>
 #include <linux/wl12xx.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
+#include <linux/of_platform.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
@@ -526,3 +527,35 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.timer		= &omap4_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
+
+static struct of_device_id omap_dt_match_table[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,omap-infra", },
+	{ }
+};
+
+static void __init panda_dt_init(void)
+{
+	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+	omap4_panda_init();
+}
+
+static const char *omap4_panda_compat[] __initdata = {
+	"ti,omap4-panda",
+	"ti,omap4",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP4_PANDA_DT, "OMAP4 Pandaboard with FDT support")
+	.dt_compat	= omap4_panda_compat,
+	.reserve	= omap_reserve,
+	.smp		= smp_ops(omap4_smp_ops),
+	.map_io		= omap4_map_io,
+	.init_early	= omap4430_init_early,
+	.init_irq	= omap_gic_of_init,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= panda_dt_init,
+	.init_late	= omap4430_init_late,
+	.timer		= &omap4_timer,
+	.restart	= omap_prcm_restart,
+MACHINE_END
-- 
1.7.9.5
