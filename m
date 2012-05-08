From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 1/2] ARM: OMAP2/3: omap_hwmod: Add api to enable/disable module level wakeup events
Date: Tue, 8 May 2012 14:34:16 +0530
Message-ID: <1336467857-12521-2-git-send-email-govindraj.raja@ti.com>
References: <1336467857-12521-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46023 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2EHJEm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 05:04:42 -0400
In-Reply-To: <1336467857-12521-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
PM_WKEN1_CORE/PM_WKEN_PER regs.

Add soc specific api to control the module level wakeup mechanism in hwmod
layer. omap_hwmod_enable/disable_wakeup is used from serial.c which should
configure PM_WKEN register to enable or disable the module level wakeup.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   16 ++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    9 +++++++++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index acc616c..e82bf80 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -186,6 +186,7 @@ struct omap_hwmod_soc_ops {
 	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri);
 	int (*init_clkdm)(struct omap_hwmod *oh);
+	void (*module_wakeup)(struct omap_hwmod *oh, bool set_wake);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -453,6 +454,27 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 }
 
 /**
+ * _enable_module_level_wakeup - enable/disable module level wakeup on hwmod.
+ * @oh: struct omap_hwmod *
+ * @set_wake: bool value indicating to set (true) or clear (false) module level
+ *		wakeup enable
+ *
+ * Set or clear the  module level wakeup capability the
+ * hwmod @oh. This function configures th PM_WKEN reg bits if they
+ * are available from hwmod. No return value
+ */
+static void _enable_module_level_wakeup(struct omap_hwmod *oh, bool set_wake)
+{
+	if (oh->prcm.omap2.module_offs && oh->prcm.omap2.prcm_reg_id &&
+			oh->prcm.omap2.idlest_idle_bit)
+		omap2_prm_enable_prcm_module_wakeup(
+				oh->prcm.omap2.module_offs,
+				oh->prcm.omap2.prcm_reg_id,
+				oh->prcm.omap2.idlest_idle_bit,
+				set_wake);
+}
+
+/**
  * _set_idle_ioring_wakeup - enable/disable IO pad wakeup on hwmod idle for mux
  * @oh: struct omap_hwmod *
  * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
@@ -3242,6 +3264,9 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	if (soc_ops.module_wakeup)
+		soc_ops.module_wakeup(oh, true);
+
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3275,6 +3300,9 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	if (soc_ops.module_wakeup)
+		soc_ops.module_wakeup(oh, false);
+
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -3561,6 +3589,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
+		soc_ops.module_wakeup = _enable_module_level_wakeup;
 	} else if (cpu_is_omap44xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9ce7654..85a753e 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -28,6 +28,10 @@
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
 
+static const u8 pm_wken_offs[] = {
+	PM_WKEN1, OMAP24XX_PM_WKEN2
+};
+
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
 	OMAP_PRCM_IRQ("io",	9,	1),
@@ -91,6 +95,18 @@ u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
+void omap2_prm_enable_prcm_module_wakeup(s16 prcm_mod, u8 prm_reg_id,
+			u8 prm_reg_shift, bool set_wake)
+{
+	if (prm_reg_id && (prm_reg_id <= ARRAY_SIZE(pm_wken_offs))) {
+		if (set_wake)
+			omap2_prm_set_mod_reg_bits(1 << prm_reg_shift,
+				prcm_mod, pm_wken_offs[prm_reg_id - 1]);
+		else
+			omap2_prm_clear_mod_reg_bits(1 << prm_reg_shift,
+				prcm_mod, pm_wken_offs[prm_reg_id - 1]);
+	}
+}
 
 /**
  * omap2_prm_is_hardreset_asserted - read the HW reset line state of
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 70ac2a1..49a185a 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -289,6 +289,13 @@ static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
 		"not suppose to be used on omap4\n");
 	return 0;
 }
+static inline void omap2_prm_enable_prcm_module_wakeup(s16 prcm_mod,
+		u8 prm_reg_id, u8 prm_reg_shift, bool set_wake)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
 #else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
@@ -297,6 +304,8 @@ extern u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 extern u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
 extern u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
 extern u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+extern void omap2_prm_enable_prcm_module_wakeup(s16 prcm_mod, u8 prm_reg_id,
+			u8 prm_reg_shift, bool set_wake);
 
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
-- 
1.7.9

