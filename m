From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP3: hwmod: support to specify the offset position of various SYSCONFIG register bits.
Date: Mon, 11 Jan 2010 11:24:08 +0530
Message-ID: <1263189248-11649-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0AKFyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 00:54:16 -0500
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
It should contain a SCHEME field From this we can determine legacy or HL.

31:30 SCHEME  Used to distinguish between old scheme and current.
 Read 0x0:  Legacy ASP or WTBU scheme
 Read 0x1:  Highlander 0.8 scheme

For legacy IP
 13:12 MIDLEMODE
 11:8  CLOCKACTIVITY
 6     EMUSOFT
 5     EMUFREE
 4:3   SIDLEMODE
 2     ENAWAKEUP
 1     SOFTRESET
 0     AUTOIDLE

For Highlander IP, the bit position in SYSCONFIG is (for simple target):
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
omap_hwmod_sysc_fields and omap_hwmod_sysc_highlander are defined 
which can be used directly to populate the sysc_fields if the IP follows
legacy or highlander scheme. If the IP follows none of these two schemes
a new omap_hwmod_sysc_fields structure has to be defined and
passed as part of omap_hwmod_sysconfig.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

This patch is based off Kevin's tree origin/pm-wip/omap_device branch

 arch/arm/mach-omap2/omap_hwmod.c             |   14 ++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   26 +++++++++++++++++---------
 2 files changed, 29 insertions(+), 11 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c
+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
@@ -135,12 +135,23 @@ static void _write_sysconfig(u32 v, stru
 static int _set_master_standbymode(struct omap_hwmod *oh, u8 standbymode,
 				   u32 *v)
 {
+	u32 mstandby_mask = 0;
+	u8 mstandby_shift = 0;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE))
 		return -EINVAL;
 
-	*v &= ~SYSC_MIDLEMODE_MASK;
-	*v |= __ffs(standbymode) << SYSC_MIDLEMODE_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
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
@@ -157,12 +168,22 @@ static int _set_master_standbymode(struc
  */
 static int _set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode, u32 *v)
 {
+	u32 sidle_mask = 0;
+	u8 sidle_shift = 0;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SIDLEMODE))
 		return -EINVAL;
 
-	*v &= ~SYSC_SIDLEMODE_MASK;
-	*v |= __ffs(idlemode) << SYSC_SIDLEMODE_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+	sidle_shift = oh->sysconfig->sysc_fields->sidle_shift;
+	sidle_mask = (0x3 << sidle_shift);
+
+	*v &= ~sidle_mask;
+	*v |= __ffs(idlemode) << sidle_shift;
 
 	return 0;
 }
@@ -180,12 +201,22 @@ static int _set_slave_idlemode(struct om
  */
 static int _set_clockactivity(struct omap_hwmod *oh, u8 clockact, u32 *v)
 {
+	u32 clkact_mask = 0;
+	u8  clkact_shift = 0;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY))
 		return -EINVAL;
 
-	*v &= ~SYSC_CLOCKACTIVITY_MASK;
-	*v |= clockact << SYSC_CLOCKACTIVITY_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+	clkact_shift = oh->sysconfig->sysc_fields->clkact_shift;
+	clkact_mask = (0x3 << clkact_shift);
+
+	*v &= ~clkact_mask;
+	*v |= clockact << clkact_shift;
 
 	return 0;
 }
@@ -200,11 +231,19 @@ static int _set_clockactivity(struct oma
  */
 static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 {
+	u32 softrst_mask = 0;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -EINVAL;
 
-	*v |= SYSC_SOFTRESET_MASK;
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+	softrst_mask = (0x1 << oh->sysconfig->sysc_fields->srst_shift);
+
+	*v |= softrst_mask;
 
 	return 0;
 }
@@ -225,12 +264,22 @@ static int _set_softreset(struct omap_hw
 static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 				u32 *v)
 {
+	u32 autoidle_mask = 0;
+	u8 autoidle_shift = 0;
+
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE))
 		return -EINVAL;
 
-	*v &= ~SYSC_AUTOIDLE_MASK;
-	*v |= autoidle << SYSC_AUTOIDLE_SHIFT;
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+	autoidle_shift = oh->sysconfig->sysc_fields->autoidle_shift;
+	autoidle_mask = (0x3 << autoidle_shift);
+
+	*v &= ~autoidle_mask;
+	*v |= autoidle << autoidle_shift;
 
 	return 0;
 }
@@ -244,14 +293,20 @@ static int _set_module_autoidle(struct o
  */
 static int _enable_wakeup(struct omap_hwmod *oh)
 {
-	u32 v;
+	u32 v, wakeup_mask = 0;
 
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+	wakeup_mask = (0x1 << oh->sysconfig->sysc_fields->enwkup_shift);
+
 	v = oh->_sysc_cache;
-	v |= SYSC_ENAWAKEUP_MASK;
+	v |= wakeup_mask;
 	_write_sysconfig(v, oh);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
@@ -270,14 +325,20 @@ static int _enable_wakeup(struct omap_hw
  */
 static int _disable_wakeup(struct omap_hwmod *oh)
 {
-	u32 v;
+	u32 v, wakeup_mask = 0;
 
 	if (!oh->sysconfig ||
 	    !(oh->sysconfig->sysc_flags & SYSC_HAS_ENAWAKEUP))
 		return -EINVAL;
 
+	if (!oh->sysconfig->sysc_fields) {
+		pr_warning("offset struct for sysconfig not provided!!!!\n");
+		return -EINVAL;
+	}
+	wakeup_mask = (0x1 << oh->sysconfig->sysc_fields->enwkup_shift);
+
 	v = oh->_sysc_cache;
-	v &= ~SYSC_ENAWAKEUP_MASK;
+	v &= ~wakeup_mask;
 	_write_sysconfig(v, oh);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
Index: linux-omap-pm/arch/arm/plat-omap/include/plat/omap_hwmod.h
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ linux-omap-pm/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -38,8 +38,9 @@
 #include <plat/cpu.h>
 
 struct omap_device;
+struct omap_hwmod_sysc_fields;
 
-/* OCP SYSCONFIG bit shifts/masks */
+/* OCP SYSCONFIG bit shifts/masks Legacy scheme */
 #define SYSC_MIDLEMODE_SHIFT		12
 #define SYSC_MIDLEMODE_MASK		(0x3 << SYSC_MIDLEMODE_SHIFT)
 #define SYSC_CLOCKACTIVITY_SHIFT	8
@@ -53,6 +54,14 @@ struct omap_device;
 #define SYSC_AUTOIDLE_SHIFT		0
 #define SYSC_AUTOIDLE_MASK		(1 << SYSC_AUTOIDLE_SHIFT)
 
+/* OCP SYSCONFIG bit shifts/masks Highlander scheme */
+#define SYSC_HIGH_SOFTRESET_SHIFT	0
+#define SYSC_HIGH_SOFTRESET_MASK	(1 << SYSC_HIGH_SOFTRESET_SHIFT)
+#define SYSC_HIGH_SIDLEMODE_SHIFT	2
+#define SYSC_HIGH_SIDLEMODE_MASK	(0x3 << SYSC_HIGH_SIDLEMODE_SHIFT)
+#define SYSC_HIGH_MIDLEMODE_SHIFT	4
+#define SYSC_HIGH_MIDLEMODE_MASK	(0x3 << SYSC_HIGH_MIDLEMODE_SHIFT)
+
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
 #define SYSS_RESETDONE_MASK		(1 << SYSS_RESETDONE_SHIFT)
@@ -62,7 +71,6 @@ struct omap_device;
 #define HWMOD_IDLEMODE_NO		(1 << 1)
 #define HWMOD_IDLEMODE_SMART		(1 << 2)
 
-
 /**
  * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
  * @name: name of the IRQ channel (module local name)
@@ -235,6 +243,53 @@ struct omap_hwmod_ocp_if {
 #define CLOCKACT_TEST_NONE	0x3
 
 /**
+ * struct omap_hwmod_sysc_fields - hwmod OCP_SYSCONFIG register field offsets.
+ * To be populated if the SYSCONFIG register offsets have deviated from the
+ * standard.
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
+ * struct omap_hwmod_sysc_legacy - OMAP3 legacy scheme for old IPs
+ *
+ * To be used by hwmod structure to specify the sysconfig offsets
+ * if the device ip follows the Legacy scheme.
+ */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_legacy = {
+    .midle_shift	= SYSC_MIDLEMODE_SHIFT,
+    .clkact_shift	= SYSC_CLOCKACTIVITY_SHIFT,
+    .sidle_shift	= SYSC_SIDLEMODE_SHIFT,
+    .enwkup_shift	= SYSC_ENAWAKEUP_SHIFT,
+    .srst_shift		= SYSC_SOFTRESET_SHIFT,
+    .autoidle_shift 	= SYSC_AUTOIDLE_SHIFT,
+};
+
+/**
+ * struct omap_hwmod_sysc_fields - OMAP4 new scheme for Highlander compliant IPs
+ *
+ * To be used by hwmod structure to specify the sysconfig offsets if the
+ * device ip follows the highlander scheme
+ */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_highlander = {
+    .midle_shift	= SYSC_HIGH_MIDLEMODE_SHIFT,
+    .sidle_shift	= SYSC_HIGH_SIDLEMODE_SHIFT,
+    .srst_shift		= SYSC_HIGH_SOFTRESET_SHIFT,
+};
+
+/**
  * struct omap_hwmod_sysconfig - hwmod OCP_SYSCONFIG/OCP_SYSSTATUS data
  * @rev_offs: IP block revision register offset (from module base addr)
  * @sysc_offs: OCP_SYSCONFIG register offset (from module base addr)
@@ -251,6 +306,13 @@ struct omap_hwmod_ocp_if {
  * been associated with the clocks marked in @clockact.  This field is
  * only used if HWMOD_SET_DEFAULT_CLOCKACT is set (see below)
  *
+ *
+ * @sysc_fields: structure containing the offset positions of various bits in
+ * SYSCONFIG register. This can be populated using omap_hwmod_sysc_legacy or
+ * omap_hwmod_highlander_legacy defined below if the device follows legacy
+ * or highlander scheme for the sysconfig register. If the device follows
+ * a differnet scheme for the sysconfig register , then this field has to
+ * be populated with the correct offset structure.
  */
 struct omap_hwmod_sysconfig {
 	u16 rev_offs;
@@ -259,6 +321,7 @@ struct omap_hwmod_sysconfig {
 	u8 idlemodes;
 	u8 sysc_flags;
 	u8 clockact;
+	struct omap_hwmod_sysc_fields *sysc_fields;
 };
 
 /**
