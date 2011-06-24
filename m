From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 12/14] OMAP4: cm: Add two new APIs for modulemode control
Date: Fri, 24 Jun 2011 13:05:58 +0200
Message-ID: <1308913560-333-13-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35175 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755219Ab1FXLGe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 07:06:34 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

In OMAP4, a new programming model based on module control instead
of clock control was introduced.
Expose two APIs to allow the upper layer (omap_hwmod) to control
the module mode independently of the parent clocks management.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    3 +++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 83498c1..3176ea6 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -263,3 +263,41 @@ int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
+
+/**
+ * omap4_cm_module_enable - Enable the modulemode inside CLKCTRL
+ * @mode: Module mode (SW or HW)
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ * No return value.
+ */
+void omap4_cm_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
+			    u16 clkctrl_offs)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, cdoffs + clkctrl_offs);
+	v &= ~OMAP4430_MODULEMODE_MASK;
+	v |= mode << OMAP4430_MODULEMODE_SHIFT;
+	omap4_cminst_write_inst_reg(v, part, inst, cdoffs + clkctrl_offs);
+}
+
+/**
+ * omap4_cm_module_disable - Disable the module inside CLKCTRL
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ * No return value.
+ */
+void omap4_cm_module_disable(u8 part, u16 inst, s16 cdoffs,
+			     u16 clkctrl_offs)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, cdoffs + clkctrl_offs);
+	v &= ~OMAP4430_MODULEMODE_MASK;
+	omap4_cminst_write_inst_reg(v, part, inst, cdoffs + clkctrl_offs);
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 4c5da7d..8034e5c 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -20,6 +20,9 @@ extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 extern int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 extern int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 
+extern void omap4_cm_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
+extern void omap4_cm_module_disable(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
+
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
-- 
1.7.0.4

