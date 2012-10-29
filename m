From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] ARM: OMAP2+: am33xx: Add PRM warm reset/reboot support
Date: Mon, 29 Oct 2012 15:29:07 +0530
Message-ID: <1351504747-10554-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625Ab2J2J7Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 05:59:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Afzal Mohammed <afzal@ti.com>

This patch adds reboot capability to all AM33XX based boards/EVM's,
by asserting PRM warm reset bit on 'reboot' command.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Daniel Mack <zonque@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Afzal Mohammed <afzal@ti.com>
---
Tested on AM335xEVM and BeagleBone platform.

 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/prcm.c          |    3 +++
 arch/arm/mach-omap2/prm33xx.c       |   15 +++++++++++++++
 arch/arm/mach-omap2/prm33xx.h       |    1 +
 4 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 601ecdf..6a69ceb 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -114,6 +114,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap3_am33xx_timer,
 	.dt_compat	= am33xx_boards_compat,
+	.restart	= omap_prcm_restart,
 MACHINE_END
 #endif

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index cff270a..07f163c 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -34,6 +34,7 @@
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prminst44xx.h"
 #include "cminst44xx.h"
 #include "prm-regbits-24xx.h"
@@ -73,6 +74,8 @@ void omap_prcm_restart(char mode, const char *cmd)
 		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
 	} else if (cpu_is_omap44xx()) {
 		omap4_prminst_global_warm_sw_reset(); /* never returns */
+	} else if (soc_is_am33xx()) {
+		am33xx_prm_global_warm_sw_reset();	/* never returns */
 	} else {
 		WARN_ON(1);
 	}
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 53ec9cb..657c3d0 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -135,6 +135,21 @@ int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }

+void am33xx_prm_global_warm_sw_reset(void)
+{
+	u32 v;
+
+	v = am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
+				    AM33XX_PRM_RSTCTRL_OFFSET);
+	v |= AM33XX_GLOBAL_WARM_SW_RST_MASK;
+	am33xx_prm_write_reg(v, AM33XX_PRM_DEVICE_MOD,
+				 AM33XX_PRM_RSTCTRL_OFFSET);
+
+	/* OCP barrier */
+	v = am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
+				    AM33XX_PRM_RSTCTRL_OFFSET);
+}
+
 static int am33xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	am33xx_prm_rmw_reg_bits(OMAP_POWERSTATE_MASK,
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 3f25c56..cdfc694 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -126,4 +126,5 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
 extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs);
+extern void am33xx_prm_global_warm_sw_reset(void);
 #endif
--
1.7.0.4

