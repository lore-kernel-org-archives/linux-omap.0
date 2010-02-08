From: Thara Gopinath <thara@ti.com>
Subject: [PATCH V4] OMAP3: hwmod: support to specify the offset position of various SYSCONFIG register bits.
Date: Mon,  8 Feb 2010 21:33:10 +0530
Message-ID: <1265644990-14589-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54390 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab0BHQDT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 11:03:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

In OMAP3 Some modules like Smartreflex do not have the regular sysconfig
register.Instead clockactivity bits are part of another register at a
different bit position than the usual bit positions 8 and 9.

In OMAP4, a new scheme is available  due to the new protocol
between the PRCM and the IPs. Depending of the scheme, the SYSCONFIG
bitfields position will be different.
The IP_REVISION register should be at offset 0x00.
It should contain a SCHEME field. From this we can determine whether
the IP follows legacy scheme or the new scheme.

31:30 SCHEME  Used to distinguish between old scheme and current.
 Read 0x0:  Legacy protocol.
 Read 0x1:  New PRCM protocol defined for new OMAP4 IPs

For legacy IP
 13:12 MIDLEMODE
 11:8  CLOCKACTIVITY
 6     EMUSOFT
 5     EMUFREE
 4:3   SIDLEMODE
 2     ENAWAKEUP
 1     SOFTRESET
 0     AUTOIDLE

For new OMAP4 IP's, the bit position in SYSCONFIG is (for simple target):
 5:4   STANDBYMODE (Ex MIDLEMODE)
 3:2   IDLEMODE (Ex SIDLEMODE)
 1     FREEEMU (Ex EMUFREE)
 0     SOFTRESET

Unfortunately In OMAP4 also some IPs will not follow any of these
two schemes. This is the case at least for McASP, SmartReflex
and some security IPs.

This patch introduces a new field sysc_fields in omap_hwmod_sysconfig which
can be used by the hwmod structures to specify the offsets for the
sysconfig register of the IP.Also two static structures
omap_hwmod_sysc_type1 and omap_hwmod_sysc_type2 are defined
which can be used directly to populate the sysc_fields if the IP follows
legacy or new OMAP4 scheme. If the IP follows none of these two schemes
a new omap_hwmod_sysc_fields structure has to be defined and
passed as part of omap_hwmod_sysconfig.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                 |    3 +-
 arch/arm/mach-omap2/omap_hwmod.c             |  100 ++++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   46 ++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   74 +++++++++++++++----
 4 files changed, 195 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d0a19ec..e31122f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -5,7 +5,8 @@
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
 
-omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
+omap-2-3-common				= irq.o sdrc.o omap_hwmod.o \
+					  omap_hwmod_common_data.o
 omap-3-4-common				= dpll3xxx.o
 prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o \
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 70912d1..904dce5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -137,12 +137,24 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 static int _set_master_standbymode(struct omap_hwmod *oh, u8 standbymode,
 				   u32 *v)
 {
+	u32 mstandby_mask;
+	u8 mstandby_shift;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE))
 		return -EINVAL;
 
-	*v &= ~SYSC_MIDLEMODE_MASK;
-	*v |= __ffs(standbymode) << SYSC_MIDLEMODE_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	mstandby_shift = oh->sysconfig->sysc_fields->midle_shift;
+	mstandby_mask = (0x3 << mstandby_shift);
+
+	*v &= ~mstandby_mask;
+	*v |= __ffs(standbymode) << mstandby_shift;
 
 	return 0;
 }
@@ -159,12 +171,24 @@ static int _set_master_standbymode(struct omap_hwmod *oh, u8 standbymode,
  */
 static int _set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode, u32 *v)
 {
+	u32 sidle_mask;
+	u8 sidle_shift;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SIDLEMODE))
 		return -EINVAL;
 
-	*v &= ~SYSC_SIDLEMODE_MASK;
-	*v |= __ffs(idlemode) << SYSC_SIDLEMODE_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	sidle_shift = oh->sysconfig->sysc_fields->sidle_shift;
+	sidle_mask = (0x3 << sidle_shift);
+
+	*v &= ~sidle_mask;
+	*v |= __ffs(idlemode) << sidle_shift;
 
 	return 0;
 }
@@ -182,12 +206,24 @@ static int _set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode, u32 *v)
  */
 static int _set_clockactivity(struct omap_hwmod *oh, u8 clockact, u32 *v)
 {
+	u32 clkact_mask;
+	u8  clkact_shift;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY))
 		return -EINVAL;
 
-	*v &= ~SYSC_CLOCKACTIVITY_MASK;
-	*v |= clockact << SYSC_CLOCKACTIVITY_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	clkact_shift = oh->sysconfig->sysc_fields->clkact_shift;
+	clkact_mask = (0x3 << clkact_shift);
+
+	*v &= ~clkact_mask;
+	*v |= clockact << clkact_shift;
 
 	return 0;
 }
@@ -202,11 +238,21 @@ static int _set_clockactivity(struct omap_hwmod *oh, u8 clockact, u32 *v)
  */
 static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 {
+	u32 softrst_mask;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -EINVAL;
 
-	*v |= SYSC_SOFTRESET_MASK;
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	softrst_mask = (0x1 << oh->sysconfig->sysc_fields->srst_shift);
+
+	*v |= softrst_mask;
 
 	return 0;
 }
@@ -227,12 +273,24 @@ static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 				u32 *v)
 {
+	u32 autoidle_mask;
+	u8 autoidle_shift;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE))
 		return -EINVAL;
 
-	*v &= ~SYSC_AUTOIDLE_MASK;
-	*v |= autoidle << SYSC_AUTOIDLE_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	autoidle_shift = oh->sysconfig->sysc_fields->autoidle_shift;
+	autoidle_mask = (0x3 << autoidle_shift);
+
+	*v &= ~autoidle_mask;
+	*v |= autoidle << autoidle_shift;
 
 	return 0;
 }
@@ -246,14 +304,22 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
  */
 static int _enable_wakeup(struct omap_hwmod *oh)
 {
-	u32 v;
+	u32 v, wakeup_mask;
 
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	wakeup_mask = (0x1 << oh->sysconfig->sysc_fields->enwkup_shift);
+
 	v = oh->_sysc_cache;
-	v |= SYSC_ENAWAKEUP_MASK;
+	v |= wakeup_mask;
 	_write_sysconfig(v, oh);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
@@ -272,14 +338,22 @@ static int _enable_wakeup(struct omap_hwmod *oh)
  */
 static int _disable_wakeup(struct omap_hwmod *oh)
 {
-	u32 v;
+	u32 v, wakeup_mask;
 
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
+	if (!oh->sysconfig->sysc_fields) {
+		WARN(!oh->sysconfig->sysc_fields, "offset struct for "
+			"sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+
+	wakeup_mask = (0x1 << oh->sysconfig->sysc_fields->enwkup_shift);
+
 	v = oh->_sysc_cache;
-	v &= ~SYSC_ENAWAKEUP_MASK;
+	v &= ~wakeup_mask;
 	_write_sysconfig(v, oh);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
new file mode 100644
index 0000000..e6ca6f0
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -0,0 +1,46 @@
+/*
+ * omap_hwmod common data structures
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This data/structures are to be used while defining OMAP on-chip module
+ * data and their integration with other OMAP modules and Linux.
+ */
+
+#include <linux/list.h>
+
+#include <plat/omap_hwmod.h>
+
+/**
+ * struct omap_hwmod_sysc_type1 - TYPE1 sysconfig scheme.
+ *
+ * To be used by hwmod structure to specify the sysconfig offsets
+ * if the device ip is compliant with the original PRCM protocol
+ * defined for OMAP2420.
+ */
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1 = {
+	.midle_shift	= SYSC_TYPE1_MIDLEMODE_SHIFT,
+	.clkact_shift	= SYSC_TYPE1_CLOCKACTIVITY_SHIFT,
+	.sidle_shift	= SYSC_TYPE1_SIDLEMODE_SHIFT,
+	.enwkup_shift	= SYSC_TYPE1_ENAWAKEUP_SHIFT,
+	.srst_shift	= SYSC_TYPE1_SOFTRESET_SHIFT,
+	.autoidle_shift	= SYSC_TYPE1_AUTOIDLE_SHIFT,
+};
+
+/**
+ * struct omap_hwmod_sysc_type2 - TYPE2 sysconfig scheme.
+ *
+ * To be used by hwmod structure to specify the sysconfig offsets if the
+ * device ip is compliant with the new PRCM protocol defined for new
+ * OMAP4 IPs.
+ */
+struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
+	.midle_shift	= SYSC_TYPE2_MIDLEMODE_SHIFT,
+	.sidle_shift	= SYSC_TYPE2_SIDLEMODE_SHIFT,
+	.srst_shift	= SYSC_TYPE2_SOFTRESET_SHIFT,
+};
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 921990e..7714caf 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -39,19 +39,39 @@
 
 struct omap_device;
 
-/* OCP SYSCONFIG bit shifts/masks */
-#define SYSC_MIDLEMODE_SHIFT		12
-#define SYSC_MIDLEMODE_MASK		(0x3 << SYSC_MIDLEMODE_SHIFT)
-#define SYSC_CLOCKACTIVITY_SHIFT	8
-#define SYSC_CLOCKACTIVITY_MASK		(0x3 << SYSC_CLOCKACTIVITY_SHIFT)
-#define SYSC_SIDLEMODE_SHIFT		3
-#define SYSC_SIDLEMODE_MASK		(0x3 << SYSC_SIDLEMODE_SHIFT)
-#define SYSC_ENAWAKEUP_SHIFT		2
-#define SYSC_ENAWAKEUP_MASK		(1 << SYSC_ENAWAKEUP_SHIFT)
-#define SYSC_SOFTRESET_SHIFT		1
-#define SYSC_SOFTRESET_MASK		(1 << SYSC_SOFTRESET_SHIFT)
-#define SYSC_AUTOIDLE_SHIFT		0
-#define SYSC_AUTOIDLE_MASK		(1 << SYSC_AUTOIDLE_SHIFT)
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
+extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
+
+/*
+ * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
+ * with the original PRCM protocol defined for OMAP2420
+ */
+#define SYSC_TYPE1_MIDLEMODE_SHIFT		12
+#define SYSC_TYPE1_MIDLEMODE_MASK		(0x3 << SYSC_MIDLEMODE_SHIFT)
+#define SYSC_TYPE1_CLOCKACTIVITY_SHIFT		8
+#define SYSC_TYPE1_CLOCKACTIVITY_MASK 		\
+					(0x3 << SYSC_CLOCKACTIVITY_SHIFT)
+#define SYSC_TYPE1_SIDLEMODE_SHIFT		3
+#define SYSC_TYPE1_SIDLEMODE_MASK		(0x3 << SYSC_SIDLEMODE_SHIFT)
+#define SYSC_TYPE1_ENAWAKEUP_SHIFT		2
+#define SYSC_TYPE1_ENAWAKEUP_MASK		(1 << SYSC_ENAWAKEUP_SHIFT)
+#define SYSC_TYPE1_SOFTRESET_SHIFT		1
+#define SYSC_TYPE1_SOFTRESET_MASK		(1 << SYSC_SOFTRESET_SHIFT)
+#define SYSC_TYPE1_AUTOIDLE_SHIFT		0
+#define SYSC_TYPE1_AUTOIDLE_MASK		(1 << SYSC_AUTOIDLE_SHIFT)
+
+/* OCP SYSCONFIG bit shifts/masks TYPE2. These are for IPs compliant
+ * with the new PRCM protocol defined for new OMAP4 IPs.
+ */
+#define SYSC_TYPE2_SOFTRESET_SHIFT		0
+#define SYSC_TYPE2_SOFTRESET_MASK		\
+					(1 << SYSC_TYPE2_SOFTRESET_SHIFT)
+#define SYSC_TYPE2_SIDLEMODE_SHIFT		2
+#define SYSC_TYPE2_SIDLEMODE_MASK		\
+					(0x3 << SYSC_TYPE2_SIDLEMODE_SHIFT)
+#define SYSC_TYPE2_MIDLEMODE_SHIFT		4
+#define SYSC_TYPE2_MIDLEMODE_MASK		\
+					(0x3 << SYSC_TYPE2_MIDLEMODE_SHIFT)
 
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
@@ -62,7 +82,6 @@ struct omap_device;
 #define HWMOD_IDLEMODE_NO		(1 << 1)
 #define HWMOD_IDLEMODE_SMART		(1 << 2)
 
-
 /**
  * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
  * @name: name of the IRQ channel (module local name)
@@ -236,6 +255,24 @@ struct omap_hwmod_ocp_if {
 #define CLOCKACT_TEST_NONE	0x3
 
 /**
+ * struct omap_hwmod_sysc_fields - hwmod OCP_SYSCONFIG register field offsets.
+ * @midle_shift: Offset of the midle bit
+ * @clkact_shift: Offset of the clockactivity bit
+ * @sidle_shift: Offset of the sidle bit
+ * @enawkup_shift: Offset of the enawakeup bit
+ * @sreset_shift: Offset of the softreset bit
+ * @autoidle_shift: Offset of the autoidle bit.
+ */
+struct omap_hwmod_sysc_fields {
+	u8 midle_shift;
+	u8 clkact_shift;
+	u8 sidle_shift;
+	u8 enwkup_shift;
+	u8 srst_shift;
+	u8 autoidle_shift;
+};
+
+/**
  * struct omap_hwmod_sysconfig - hwmod OCP_SYSCONFIG/OCP_SYSSTATUS data
  * @rev_offs: IP block revision register offset (from module base addr)
  * @sysc_offs: OCP_SYSCONFIG register offset (from module base addr)
@@ -252,6 +289,14 @@ struct omap_hwmod_ocp_if {
  * been associated with the clocks marked in @clockact.  This field is
  * only used if HWMOD_SET_DEFAULT_CLOCKACT is set (see below)
  *
+ *
+ * @sysc_fields: structure containing the offset positions of various bits in
+ * SYSCONFIG register. This can be populated using omap_hwmod_sysc_type1 or
+ * omap_hwmod_sysc_type2 defined in omap_hwmod_common_data.c depending on
+ * whether the device ip is compliant with the original PRCM protocol
+ * defined for OMAP2420 or the new  PRCM protocol for new OMAP4 IPs.
+ * If the device follows a differnt scheme for the sysconfig register ,
+ * then this field has to be populated with the correct offset structure.
  */
 struct omap_hwmod_sysconfig {
 	u16 rev_offs;
@@ -260,6 +305,7 @@ struct omap_hwmod_sysconfig {
 	u8 idlemodes;
 	u8 sysc_flags;
 	u8 clockact;
+	struct omap_hwmod_sysc_fields *sysc_fields;
 };
 
 /**
-- 
1.7.0.rc1.33.g07cf0f

