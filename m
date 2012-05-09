From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] omap: hwmod: add support to set dmadisable in hwmod framework
Date: Wed, 9 May 2012 11:56:34 +0530
Message-ID: <1336544794-25644-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52370 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758377Ab2EIG0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 02:26:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com
Cc: Kishon Vijay Abraham I <kishon@ti.com>

The DMADISABLE bit is a semi-automatic bit present in sysconfig register
of some modules. When the DMA must perform read/write accesses, the
DMADISABLE bit is cleared by the hardware. But when the DMA must stop for power
management, software must set the DMADISABLE bit back to 1.

In cases where the ROMCODE/BOOTLOADER uses dma, the hardware clears the
DMADISABLE bit (but the romcode/bootloader might not set it back to 1).
In order for the kernel to start in a clean state, it is
necessary for the kernel to set DMADISABLE bit back to 1 (irrespective
of whether it's been set to 1 in romcode or bootloader).

During _reset of the (hwmod)device, the DMADISABLE bit is set so that it
does not prevent idling of the system. (NOTE: having DMADISABLE to 0,
prevents the system to idle)

DMADISABLE bit is present in usbotgss module of omap5.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
checkpath warnings of "line over 80 characters" is ignored to aid easier
grepping of strings while debugging.

 arch/arm/mach-omap2/omap_hwmod.c             |   50 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +++
 3 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7144ae6..009062f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -345,6 +345,49 @@ static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 }
 
 /**
+ * _set_dmadisable: set OCP_SYSCONFIG.DMADISABLE bit in @v
+ * @oh: struct omap_hwmod *
+ *
+ * The DMADISABLE bit is a semi-automatic bit present in sysconfig register
+ * of some modules. When the DMA must perform read/write accesses, the
+ * DMADISABLE bit is cleared by the hardware. But when the DMA must stop
+ * for power management, software must set the DMADISABLE bit back to 1.
+ *
+ * Set the DMADISABLE bit in @v for hwmod @oh.  Returns -EINVAL upon
+ * error or 0 upon success.
+ */
+static int _set_dmadisable(struct omap_hwmod *oh)
+{
+	u32 v;
+	u32 dmadisable_mask;
+
+	if (!oh->class->sysc ||
+	   !(oh->class->sysc->sysc_flags & SYSC_HAS_DMADISABLE))
+		return -EINVAL;
+
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not provided in class\n", oh->name);
+		return -EINVAL;
+	}
+
+	/* clocks must be on for this operation */
+	if (oh->_state != _HWMOD_STATE_ENABLED) {
+		pr_warning("omap_hwmod: %s: dma can be disabled only from enabled state\n", oh->name);
+		return -EINVAL;
+	}
+
+	pr_debug("omap_hwmod: %s: setting DMADISABLE\n", oh->name);
+
+	v = oh->_sysc_cache;
+	dmadisable_mask =
+		(0x1 << oh->class->sysc->sysc_fields->dmadisable_shift);
+	v |= dmadisable_mask;
+	_write_sysconfig(v, oh);
+
+	return 0;
+}
+
+/**
  * _set_module_autoidle: set the OCP_SYSCONFIG AUTOIDLE field in @v
  * @oh: struct omap_hwmod *
  * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
@@ -1469,6 +1512,12 @@ dis_opt_clks:
  * access; others (like the IVA) have idiosyncratic reset sequences.
  * So for these relatively rare cases, custom reset code can be
  * supplied in the struct omap_hwmod_class .reset function pointer.
+ *
+ * The _set_dmadisable is called to set the DMADISABLE bit so that it
+ * does not prevent idling of the system. This is necessary for cases where
+ * ROMCODE/BOOTLOADER uses dma and transfers control to the kernel without
+ * disabling dma.
+ *
  * Passes along the return value from either _reset() or the custom
  * reset function - these must return -EINVAL if the hwmod cannot be
  * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
@@ -1481,6 +1530,7 @@ static int _reset(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: resetting\n", oh->name);
 
 	ret = (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
+	_set_dmadisable(oh);
 
 	if (oh->class->sysc) {
 		_update_sysc_cache(oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 51e5418..aff6138 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -47,6 +47,7 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
 	.midle_shift	= SYSC_TYPE2_MIDLEMODE_SHIFT,
 	.sidle_shift	= SYSC_TYPE2_SIDLEMODE_SHIFT,
 	.srst_shift	= SYSC_TYPE2_SOFTRESET_SHIFT,
+	.dmadisable_shift = SYSC_TYPE2_DMADISABLE_SHIFT,
 };
 
 struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 3f26db4..63aee22 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -69,6 +69,8 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 #define SYSC_TYPE2_SIDLEMODE_MASK	(0x3 << SYSC_TYPE2_SIDLEMODE_SHIFT)
 #define SYSC_TYPE2_MIDLEMODE_SHIFT	4
 #define SYSC_TYPE2_MIDLEMODE_MASK	(0x3 << SYSC_TYPE2_MIDLEMODE_SHIFT)
+#define SYSC_TYPE2_DMADISABLE_SHIFT	16
+#define SYSC_TYPE2_DMADISABLE_MASK	(0x1 << SYSC_TYPE2_DMADISABLE_SHIFT)
 
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
@@ -275,6 +277,7 @@ struct omap_hwmod_ocp_if {
 #define SYSS_HAS_RESET_STATUS	(1 << 7)
 #define SYSC_NO_CACHE		(1 << 8)  /* XXX SW flag, belongs elsewhere */
 #define SYSC_HAS_RESET_STATUS	(1 << 9)
+#define SYSC_HAS_DMADISABLE	(1 << 10)
 
 /* omap_hwmod_sysconfig.clockact flags */
 #define CLOCKACT_TEST_BOTH	0x0
@@ -290,6 +293,7 @@ struct omap_hwmod_ocp_if {
  * @enwkup_shift: Offset of the enawakeup bit
  * @srst_shift: Offset of the softreset bit
  * @autoidle_shift: Offset of the autoidle bit
+ * @dmadisable_shift: Offset of the dmadisable bit
  */
 struct omap_hwmod_sysc_fields {
 	u8 midle_shift;
@@ -298,6 +302,7 @@ struct omap_hwmod_sysc_fields {
 	u8 enwkup_shift;
 	u8 srst_shift;
 	u8 autoidle_shift;
+	u8 dmadisable_shift;
 };
 
 /**
-- 
1.7.5.4

