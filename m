From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 26/26] ARM: OMAP2+: PRM: provide generic API for system reset
Date: Mon, 1 Sep 2014 21:09:15 +0300
Message-ID: <1409594955-1476-27-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35737 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbaIASKg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:36 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch combines the various prm_warm_reset calls under a common
API prm_reset_system, and adds the SoC specific implementation under
prm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/am33xx-restart.c |    5 ++---
 arch/arm/mach-omap2/omap2-restart.c  |    4 ++--
 arch/arm/mach-omap2/omap3-restart.c  |    6 ++----
 arch/arm/mach-omap2/omap4-restart.c  |    4 ++--
 arch/arm/mach-omap2/prm.h            |    2 ++
 arch/arm/mach-omap2/prm2xxx.c        |    3 ++-
 arch/arm/mach-omap2/prm2xxx.h        |    1 -
 arch/arm/mach-omap2/prm33xx.c        |    3 ++-
 arch/arm/mach-omap2/prm33xx.h        |    1 -
 arch/arm/mach-omap2/prm3xxx.c        |    3 ++-
 arch/arm/mach-omap2/prm3xxx.h        |    2 --
 arch/arm/mach-omap2/prm44xx.c        |    1 +
 arch/arm/mach-omap2/prm_common.c     |   16 ++++++++++++++++
 13 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
index 7286389..89f14af 100644
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -9,8 +9,7 @@
 #include <linux/reboot.h>
 
 #include "common.h"
-#include "prm-regbits-33xx.h"
-#include "prm33xx.h"
+#include "prm.h"
 
 /**
  * am3xx_restart - trigger a software restart of the SoC
@@ -24,5 +23,5 @@ void am33xx_restart(enum reboot_mode mode, const char *cmd)
 {
 	/* TODO: Handle mode and cmd if necessary */
 
-	am33xx_prm_global_warm_sw_reset();
+	prm_reset_system();
 }
diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
index 68423e2..4e4f48e 100644
--- a/arch/arm/mach-omap2/omap2-restart.c
+++ b/arch/arm/mach-omap2/omap2-restart.c
@@ -15,7 +15,7 @@
 
 #include "soc.h"
 #include "common.h"
-#include "prm2xxx.h"
+#include "prm.h"
 
 /*
  * reset_virt_prcm_set_ck, reset_sys_ck: pointers to the virt_prcm_set
@@ -40,7 +40,7 @@ void omap2xxx_restart(enum reboot_mode mode, const char *cmd)
 
 	/* XXX Should save the cmd argument for use after the reboot */
 
-	omap2xxx_prm_dpll_reset(); /* never returns */
+	prm_reset_system();
 	while (1);
 }
 
diff --git a/arch/arm/mach-omap2/omap3-restart.c b/arch/arm/mach-omap2/omap3-restart.c
index 5de2a0c..ce0afb6 100644
--- a/arch/arm/mach-omap2/omap3-restart.c
+++ b/arch/arm/mach-omap2/omap3-restart.c
@@ -14,10 +14,8 @@
 #include <linux/init.h>
 #include <linux/reboot.h>
 
-#include "iomap.h"
-#include "common.h"
 #include "control.h"
-#include "prm3xxx.h"
+#include "prm.h"
 
 /* Global address base setup code */
 
@@ -32,6 +30,6 @@
 void omap3xxx_restart(enum reboot_mode mode, const char *cmd)
 {
 	omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
-	omap3xxx_prm_dpll3_reset(); /* never returns */
+	prm_reset_system();
 	while (1);
 }
diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
index 41dfd7d..f19f9db 100644
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ b/arch/arm/mach-omap2/omap4-restart.c
@@ -9,7 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/reboot.h>
-#include "prminst44xx.h"
+#include "prm.h"
 
 /**
  * omap44xx_restart - trigger a software restart of the SoC
@@ -22,7 +22,7 @@
 void omap44xx_restart(enum reboot_mode mode, const char *cmd)
 {
 	/* XXX Should save 'cmd' into scratchpad for use after reboot */
-	omap4_prminst_global_warm_sw_reset(); /* never returns */
+	prm_reset_system();
 	while (1)
 		;
 }
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 7efe14c..a0d36fd 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -144,6 +144,7 @@ struct prm_ll_data {
 				  u16 offset, u16 st_offset);
 	int (*is_hardreset_asserted)(u8 shift, u8 part, s16 prm_mod,
 				     u16 offset);
+	void (*reset_system)(void);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
@@ -156,6 +157,7 @@ int prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset);
 extern u32 prm_read_reset_sources(void);
 extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
 extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
+void prm_reset_system(void);
 
 void prm_reconfigure_io_chain(void);
 
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 54ae555..af0f152 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -106,7 +106,7 @@ static int omap2xxx_pwrst_to_common_pwrst(u8 omap2xxx_pwrst)
  * Set the DPLL reset bit, which should reboot the SoC.  This is the
  * recommended way to restart the SoC.  No return value.
  */
-void omap2xxx_prm_dpll_reset(void)
+static void omap2xxx_prm_dpll_reset(void)
 {
 	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, WKUP_MOD,
 				   OMAP2_RM_RSTCTRL);
@@ -215,6 +215,7 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.assert_hardreset = &omap2_prm_assert_hardreset,
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
+	.reset_system = &omap2xxx_prm_dpll_reset,
 };
 
 int __init omap2xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index d734141..1d51643 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -124,7 +124,6 @@
 extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
 extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
 
-extern void omap2xxx_prm_dpll_reset(void);
 void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 
 extern int __init omap2xxx_prm_init(void);
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 4a843f7..02f6286 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -341,7 +341,7 @@ static int am33xx_check_vcvp(void)
  *
  * Immediately reboots the device through warm reset.
  */
-void am33xx_prm_global_warm_sw_reset(void)
+static void am33xx_prm_global_warm_sw_reset(void)
 {
 	am33xx_prm_rmw_reg_bits(AM33XX_RST_GLOBAL_WARM_SW_MASK,
 				AM33XX_RST_GLOBAL_WARM_SW_MASK,
@@ -375,6 +375,7 @@ static struct prm_ll_data am33xx_prm_ll_data = {
 	.assert_hardreset		= am33xx_prm_assert_hardreset,
 	.deassert_hardreset		= am33xx_prm_deassert_hardreset,
 	.is_hardreset_asserted		= am33xx_prm_is_hardreset_asserted,
+	.reset_system			= am33xx_prm_global_warm_sw_reset,
 };
 
 int __init am33xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 937d56e..98ac41f 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -118,7 +118,6 @@
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
 #ifndef __ASSEMBLER__
-extern void am33xx_prm_global_warm_sw_reset(void);
 int am33xx_prm_init(void);
 
 #endif /* ASSEMBLER */
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 1a739de..4de5de6 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -137,7 +137,7 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
  * recommended way to restart the SoC, considering Errata i520.  No
  * return value.
  */
-void omap3xxx_prm_dpll3_reset(void)
+static void omap3xxx_prm_dpll3_reset(void)
 {
 	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, OMAP3430_GR_MOD,
 				   OMAP2_RM_RSTCTRL);
@@ -649,6 +649,7 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.assert_hardreset = &omap2_prm_assert_hardreset,
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
+	.reset_system = &omap3xxx_prm_dpll3_reset,
 };
 
 int __init omap3xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 321568b..cfde3f4 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -144,8 +144,6 @@ extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-extern void omap3xxx_prm_dpll3_reset(void);
-
 extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
 int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index e7ac7e2..cc170fb 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -697,6 +697,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.assert_hardreset	= omap4_prminst_assert_hardreset,
 	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
 	.is_hardreset_asserted	= omap4_prminst_is_hardreset_asserted,
+	.reset_system		= omap4_prminst_global_warm_sw_reset,
 };
 
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 582ed6a..60bce8f 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -503,6 +503,22 @@ void prm_reconfigure_io_chain(void)
 }
 
 /**
+ * prm_reset_system - trigger global SW reset
+ *
+ * Triggers SoC specific global warm reset to reboot the device.
+ */
+void prm_reset_system(void)
+{
+	if (!prm_ll_data->reset_system) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return;
+	}
+
+	prm_ll_data->reset_system();
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
-- 
1.7.9.5

