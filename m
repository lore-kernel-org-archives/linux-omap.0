From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 2/3] ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level wakeup events
Date: Fri, 20 Apr 2012 16:40:06 +0530
Message-ID: <1334920207-19160-3-git-send-email-govindraj.raja@ti.com>
References: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165Ab2DTLKb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 07:10:31 -0400
In-Reply-To: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

From: "Govindraj.R" <govindraj.raja@ti.com>

On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
PM_WKEN1_CORE/PM_WKEN_PER regs.

Add api to control the module level wakeup mechanism from info provided from
hwmod data. If module level wakeups are available from hwmod data then they
have to be enabled/disabled as per driver request.

omap_hwmod_enable/disable_wakeup is used from serial.c which should
configure those registers to enable or disable the module level wakeup.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    8 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    9 +++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2c27fdb..0200daa 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -382,6 +382,28 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
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
+	if (oh->prcm.omap2.module_wakeup_offs &&
+				oh->prcm.omap2.module_wakeup_bit &&
+				oh->prcm.omap2.module_offs)
+		omap2_prm_enable_prcm_module_wakeup(
+					oh->prcm.omap2.module_wakeup_bit,
+					oh->prcm.omap2.module_offs,
+					oh->prcm.omap2.module_wakeup_offs,
+					set_wake);
+}
+
+/**
  * _set_idle_ioring_wakeup - enable/disable IO pad wakeup on hwmod idle for mux
  * @oh: struct omap_hwmod *
  * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
@@ -2471,6 +2493,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	_enable_module_level_wakeup(oh, true);
 	_set_idle_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
@@ -2504,6 +2527,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 		_write_sysconfig(v, oh);
 	}
 
+	_enable_module_level_wakeup(oh, false);
 	_set_idle_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9ce7654..2b38e34 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -91,6 +91,14 @@ u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
+void omap2_prm_enable_prcm_module_wakeup(u32 bits, s16 module, s16 idx,
+			bool set_wake)
+{
+	if (set_wake)
+		omap2_prm_set_mod_reg_bits(bits, module, idx);
+	else
+		omap2_prm_clear_mod_reg_bits(bits, module, idx);
+}
 
 /**
  * omap2_prm_is_hardreset_asserted - read the HW reset line state of
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 70ac2a1..1b4194d 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -289,6 +289,13 @@ static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
 		"not suppose to be used on omap4\n");
 	return 0;
 }
+static inline void omap2_prm_enable_prcm_module_wakeup(u32 bits, s16 module,
+				s16 idx, bool set_wake)
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
+extern void omap2_prm_enable_prcm_module_wakeup(u32 bits, s16 module,
+				s16 idx, bool set_wake);
 
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
-- 
1.7.9

