From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 1/2] ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level wakeup events
Date: Tue, 24 Apr 2012 19:39:11 +0530
Message-ID: <1335276552-24340-2-git-send-email-govindraj.raja@ti.com>
References: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47108 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172Ab2DXOJc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:09:32 -0400
In-Reply-To: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
PM_WKEN1_CORE/PM_WKEN_PER regs.

Add api to control the module level wakeup mechanism from info provided from
hwmod data.

omap_hwmod_enable/disable_wakeup is used from serial.c which should
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
 arch/arm/mach-omap2/omap_hwmod.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   16 ++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    9 +++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2c27fdb..4f10619 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -382,6 +382,26 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
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
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
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
@@ -2471,6 +2491,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	_enable_module_level_wakeup(oh, true);
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -2504,6 +2525,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	_enable_module_level_wakeup(oh, false);
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
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

