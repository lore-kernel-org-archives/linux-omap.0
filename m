From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 08/26] ARM: OMAP2+: CM: make clkdm_hwsup operations static
Date: Mon, 1 Sep 2014 21:08:57 +0300
Message-ID: <1409594955-1476-9-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbaIASKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 14:10:00 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are not accessed outside the cm*.c files themselves, so make them
static.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c     |    6 +++---
 arch/arm/mach-omap2/cm2xxx.h     |    4 ----
 arch/arm/mach-omap2/cm33xx.c     |   10 +++++-----
 arch/arm/mach-omap2/cm33xx.h     |    5 -----
 arch/arm/mach-omap2/cm3xxx.c     |   10 +++++-----
 arch/arm/mach-omap2/cm3xxx.h     |    7 -------
 arch/arm/mach-omap2/cminst44xx.c |   10 +++++-----
 arch/arm/mach-omap2/cminst44xx.h |    5 -----
 8 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index f913efb..365df9e 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -53,7 +53,7 @@ static void _write_clktrctrl(u8 c, s16 module, u32 mask)
 	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
 }
 
-bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
+static bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
 {
 	u32 v;
 
@@ -64,12 +64,12 @@ bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
 	return (v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
 }
 
-void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
+static void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
 {
 	_write_clktrctrl(OMAP24XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
 }
 
-void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
+static void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
 {
 	_write_clktrctrl(OMAP24XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
 }
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 2526a8f..a14094b 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -46,9 +46,6 @@
 
 #ifndef __ASSEMBLER__
 
-extern void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
-
 extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
 extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
 
@@ -57,7 +54,6 @@ extern void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
 extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
 extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
 
-extern bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
 int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
 				  u8 idlest_shift);
 extern int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index d57fa5f..ffdcb7a 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -156,7 +156,7 @@ static void _clktrctrl_write(u8 c, u16 inst, u16 cdoffs)
  * Returns true if the clockdomain referred to by (@inst, @cdoffs)
  * is in hardware-supervised idle mode, or 0 otherwise.
  */
-bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs)
+static bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs)
 {
 	u32 v;
 
@@ -175,7 +175,7 @@ bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs)
  * Put a clockdomain referred to by (@inst, @cdoffs) into
  * hardware-supervised idle mode.  No return value.
  */
-void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs)
+static void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, inst, cdoffs);
 }
@@ -189,7 +189,7 @@ void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs)
  * software-supervised idle mode, i.e., controlled manually by the
  * Linux OMAP clockdomain code.  No return value.
  */
-void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs)
+static void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, inst, cdoffs);
 }
@@ -202,7 +202,7 @@ void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs)
  * Put a clockdomain referred to by (@inst, @cdoffs) into idle
  * No return value.
  */
-void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs)
+static void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, inst, cdoffs);
 }
@@ -215,7 +215,7 @@ void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs)
  * Take a clockdomain referred to by (@inst, @cdoffs) out of idle,
  * waking it up.  No return value.
  */
-void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs)
+static void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, inst, cdoffs);
 }
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index a0daea8..78a61e5 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -374,11 +374,6 @@
 
 
 #ifndef __ASSEMBLER__
-bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
-void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 int am33xx_cm_init(void);
 
 #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 4da3625..a29c2bf 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -42,7 +42,7 @@ static void _write_clktrctrl(u8 c, s16 module, u32 mask)
 	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
 }
 
-bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
+static bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
 {
 	u32 v;
 
@@ -53,22 +53,22 @@ bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
 	return (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
 }
 
-void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
+static void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
 {
 	_write_clktrctrl(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
 }
 
-void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
+static void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
 {
 	_write_clktrctrl(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
 }
 
-void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask)
+static void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask)
 {
 	_write_clktrctrl(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, module, mask);
 }
 
-void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask)
+static void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask)
 {
 	_write_clktrctrl(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, module, mask);
 }
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 55faf0e..33491c7 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -68,13 +68,6 @@
 
 #ifndef __ASSEMBLER__
 
-extern void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
-extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
-
-extern bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-
 extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 					s16 *prcm_inst, u8 *idlest_reg_id);
 
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 7ae1cc2..b189a2b 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -198,7 +198,7 @@ static void _clktrctrl_write(u8 c, u8 part, u16 inst, u16 cdoffs)
  * Returns true if the clockdomain referred to by (@part, @inst, @cdoffs)
  * is in hardware-supervised idle mode, or 0 otherwise.
  */
-bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs)
+static bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs)
 {
 	u32 v;
 
@@ -218,7 +218,7 @@ bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs)
  * Put a clockdomain referred to by (@part, @inst, @cdoffs) into
  * hardware-supervised idle mode.  No return value.
  */
-void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs)
+static void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, part, inst, cdoffs);
 }
@@ -233,7 +233,7 @@ void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs)
  * software-supervised idle mode, i.e., controlled manually by the
  * Linux OMAP clockdomain code.  No return value.
  */
-void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs)
+static void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, part, inst, cdoffs);
 }
@@ -247,7 +247,7 @@ void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs)
  * Take a clockdomain referred to by (@part, @inst, @cdoffs) out of idle,
  * waking it up.  No return value.
  */
-void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs)
+static void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, part, inst, cdoffs);
 }
@@ -256,7 +256,7 @@ void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs)
  *
  */
 
-void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs)
+static void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
 }
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 9a223dd..d6634fa 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -11,11 +11,6 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
 #define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
 
-bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
-void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
 extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
 				       u16 clkctrl_offs);
 extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
-- 
1.7.9.5

