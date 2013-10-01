From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 01/11] ARM: OMAP2+: CM: cm_inst offset s16->u16
Date: Tue, 1 Oct 2013 12:36:10 +0530
Message-ID: <5e9ef86c35c60862a1c2aa24172e41ee4c6f07de.1380608720.git.afzal@ti.com>
References: <cover.1380608719.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58387 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3JAHGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Oct 2013 03:06:41 -0400
In-Reply-To: <cover.1380608719.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ankur Kishore <a-kishore@ti.com>

From: Ankur Kishore <a-kishore@ti.com>

Most of the AM43x CM reg address offsets are with MSB bit '1' (on
16-bit value) leading to arithmetic miscalculations while calculating
CLOCK ENABLE register's address because cm_inst field was a type of
"const s16", so make it "const u16".

Also modify relevant functions so as to take care of the above.

[afzal@ti.com: fixup and cleanup]

Signed-off-by: Ankur Kishore <a-kishore@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/clockdomain.h |  2 +-
 arch/arm/mach-omap2/cm33xx.c      | 16 ++++++++--------
 arch/arm/mach-omap2/cm33xx.h      | 10 +++++-----
 arch/arm/mach-omap2/cminst44xx.c  | 20 ++++++++++----------
 arch/arm/mach-omap2/cminst44xx.h  | 26 +++++++++++++-------------
 5 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 4b03394..5431b0c 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -132,7 +132,7 @@ struct clockdomain {
 	u8 _flags;
 	const u8 dep_bit;
 	const u8 prcm_partition;
-	const s16 cm_inst;
+	const u16 cm_inst;
 	const u16 clkdm_offs;
 	struct clkdm_dep *wkdep_srcs;
 	struct clkdm_dep *sleepdep_srcs;
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 325a515..40a22e5 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -48,13 +48,13 @@
 /* Private functions */
 
 /* Read a register in a CM instance */
-static inline u32 am33xx_cm_read_reg(s16 inst, u16 idx)
+static inline u32 am33xx_cm_read_reg(u16 inst, u16 idx)
 {
 	return __raw_readl(cm_base + inst + idx);
 }
 
 /* Write into a register in a CM */
-static inline void am33xx_cm_write_reg(u32 val, s16 inst, u16 idx)
+static inline void am33xx_cm_write_reg(u32 val, u16 inst, u16 idx)
 {
 	__raw_writel(val, cm_base + inst + idx);
 }
@@ -138,7 +138,7 @@ static bool _is_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
  * @c must be the unshifted value for CLKTRCTRL - i.e., this function
  * will handle the shift itself.
  */
-static void _clktrctrl_write(u8 c, s16 inst, u16 cdoffs)
+static void _clktrctrl_write(u8 c, u16 inst, u16 cdoffs)
 {
 	u32 v;
 
@@ -158,7 +158,7 @@ static void _clktrctrl_write(u8 c, s16 inst, u16 cdoffs)
  * Returns true if the clockdomain referred to by (@inst, @cdoffs)
  * is in hardware-supervised idle mode, or 0 otherwise.
  */
-bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs)
+bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs)
 {
 	u32 v;
 
@@ -177,7 +177,7 @@ bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs)
  * Put a clockdomain referred to by (@inst, @cdoffs) into
  * hardware-supervised idle mode.  No return value.
  */
-void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs)
+void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, inst, cdoffs);
 }
@@ -191,7 +191,7 @@ void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs)
  * software-supervised idle mode, i.e., controlled manually by the
  * Linux OMAP clockdomain code.  No return value.
  */
-void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs)
+void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, inst, cdoffs);
 }
@@ -204,7 +204,7 @@ void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs)
  * Put a clockdomain referred to by (@inst, @cdoffs) into idle
  * No return value.
  */
-void am33xx_cm_clkdm_force_sleep(s16 inst, u16 cdoffs)
+void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, inst, cdoffs);
 }
@@ -217,7 +217,7 @@ void am33xx_cm_clkdm_force_sleep(s16 inst, u16 cdoffs)
  * Take a clockdomain referred to by (@inst, @cdoffs) out of idle,
  * waking it up.  No return value.
  */
-void am33xx_cm_clkdm_force_wakeup(s16 inst, u16 cdoffs)
+void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, inst, cdoffs);
 }
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 9d1f4fc..757320b 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -377,11 +377,11 @@
 
 
 #ifndef __ASSEMBLER__
-extern bool am33xx_cm_is_clkdm_in_hwsup(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_enable_hwsup(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_disable_hwsup(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_force_sleep(s16 inst, u16 cdoffs);
-extern void am33xx_cm_clkdm_force_wakeup(s16 inst, u16 cdoffs);
+bool am33xx_cm_is_clkdm_in_hwsup(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_enable_hwsup(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
+void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 
 #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
 extern int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index f0290f5..e957222 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -111,7 +111,7 @@ static bool _is_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 /* Public functions */
 
 /* Read a register in a CM instance */
-u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
+u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx)
 {
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
@@ -120,7 +120,7 @@ u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 }
 
 /* Write into a register in a CM instance */
-void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
+void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx)
 {
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
@@ -129,7 +129,7 @@ void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 }
 
 /* Read-modify-write a register in CM1. Caller must lock */
-u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
+u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, u16 inst,
 				   s16 idx)
 {
 	u32 v;
@@ -142,12 +142,12 @@ u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
 	return v;
 }
 
-u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, s16 inst, s16 idx)
+u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
 {
 	return omap4_cminst_rmw_inst_reg_bits(bits, bits, part, inst, idx);
 }
 
-u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, s16 inst, s16 idx)
+u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst, s16 idx)
 {
 	return omap4_cminst_rmw_inst_reg_bits(bits, 0x0, part, inst, idx);
 }
@@ -177,7 +177,7 @@ u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx, u32 mask)
  * @c must be the unshifted value for CLKTRCTRL - i.e., this function
  * will handle the shift itself.
  */
-static void _clktrctrl_write(u8 c, u8 part, s16 inst, u16 cdoffs)
+static void _clktrctrl_write(u8 c, u8 part, u16 inst, u16 cdoffs)
 {
 	u32 v;
 
@@ -196,7 +196,7 @@ static void _clktrctrl_write(u8 c, u8 part, s16 inst, u16 cdoffs)
  * Returns true if the clockdomain referred to by (@part, @inst, @cdoffs)
  * is in hardware-supervised idle mode, or 0 otherwise.
  */
-bool omap4_cminst_is_clkdm_in_hwsup(u8 part, s16 inst, u16 cdoffs)
+bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs)
 {
 	u32 v;
 
@@ -216,7 +216,7 @@ bool omap4_cminst_is_clkdm_in_hwsup(u8 part, s16 inst, u16 cdoffs)
  * Put a clockdomain referred to by (@part, @inst, @cdoffs) into
  * hardware-supervised idle mode.  No return value.
  */
-void omap4_cminst_clkdm_enable_hwsup(u8 part, s16 inst, u16 cdoffs)
+void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, part, inst, cdoffs);
 }
@@ -231,7 +231,7 @@ void omap4_cminst_clkdm_enable_hwsup(u8 part, s16 inst, u16 cdoffs)
  * software-supervised idle mode, i.e., controlled manually by the
  * Linux OMAP clockdomain code.  No return value.
  */
-void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
+void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, part, inst, cdoffs);
 }
@@ -245,7 +245,7 @@ void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
  * Take a clockdomain referred to by (@part, @inst, @cdoffs) out of idle,
  * waking it up.  No return value.
  */
-void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
+void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs)
 {
 	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, part, inst, cdoffs);
 }
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index bd7bab8..7f56ea4 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -11,11 +11,11 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
 #define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
 
-extern bool omap4_cminst_is_clkdm_in_hwsup(u8 part, s16 inst, u16 cdoffs);
-extern void omap4_cminst_clkdm_enable_hwsup(u8 part, s16 inst, u16 cdoffs);
-extern void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs);
-extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
-extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
+bool omap4_cminst_is_clkdm_in_hwsup(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
+void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
 extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
 					 u16 clkctrl_offs);
@@ -27,14 +27,14 @@ extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
  */
-extern u32 omap4_cminst_read_inst_reg(u8 part, s16 inst, u16 idx);
-extern void omap4_cminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx);
-extern u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
-					   s16 inst, s16 idx);
-extern u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, s16 inst,
-					   s16 idx);
-extern u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, s16 inst,
-					   s16 idx);
+u32 omap4_cminst_read_inst_reg(u8 part, u16 inst, u16 idx);
+void omap4_cminst_write_inst_reg(u32 val, u8 part, u16 inst, u16 idx);
+u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
+				   u16 inst, s16 idx);
+u32 omap4_cminst_set_inst_reg_bits(u32 bits, u8 part, u16 inst,
+				   s16 idx);
+u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst,
+				     s16 idx);
 extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
 					   u32 mask);
 
-- 
1.8.3.4

