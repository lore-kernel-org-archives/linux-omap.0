From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: hwmod: use init-time function pointer
 for hardreset
Date: Mon, 30 Apr 2012 08:34:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204300833510.10308@utopia.booyaka.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com> <1335557140-10854-6-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40845 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab2D3Oeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 10:34:50 -0400
In-Reply-To: <1335557140-10854-6-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Fri, 27 Apr 2012, Kevin Hilman wrote:

> Rather than using cpu_is* checking at runtime, initialize SoC specific
> function pointers for the various hard reset functions at init time.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Lots of kerneldoc has been added, and the function pointers have been 
moved to the soc_ops structure; please let me know if you have any 
comments.


- Paul

From: Kevin Hilman <khilman@ti.com>
Date: Fri, 27 Apr 2012 13:05:39 -0700
Subject: [PATCH 5/6] ARM: OMAP2+: hwmod: use init-time function pointer for
 hardreset

Rather than using cpu_is* checking at runtime, initialize SoC specific
function pointers for the various hard reset functions at init time.

Signed-off-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: convert to use soc_ops function pointers; add kerneldoc]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  216 +++++++++++++++++++++++++++++---------
 1 file changed, 169 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d1f784c..93cb96d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -179,6 +179,12 @@ struct omap_hwmod_soc_ops {
 	void (*enable_module)(struct omap_hwmod *oh);
 	int (*disable_module)(struct omap_hwmod *oh);
 	int (*wait_target_ready)(struct omap_hwmod *oh);
+	int (*assert_hardreset)(struct omap_hwmod *oh,
+				struct omap_hwmod_rst_info *ohri);
+	int (*deassert_hardreset)(struct omap_hwmod *oh,
+				  struct omap_hwmod_rst_info *ohri);
+	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
+				     struct omap_hwmod_rst_info *ohri);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -1398,32 +1404,31 @@ static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name,
  * @oh: struct omap_hwmod *
  * @name: name of the reset line to lookup and assert
  *
- * Some IP like dsp, ipu or iva contain processor that require
- * an HW reset line to be assert / deassert in order to enable fully
- * the IP.
+ * Some IP like dsp, ipu or iva contain processor that require an HW
+ * reset line to be assert / deassert in order to enable fully the IP.
+ * Returns -EINVAL if @oh is null, -ENOSYS if we have no way of
+ * asserting the hardreset line on the currently-booted SoC, or passes
+ * along the return value from _lookup_hardreset() or the SoC's
+ * assert_hardreset code.
  */
 static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	u8 ret;
+	u8 ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
 
+	if (!soc_ops.assert_hardreset)
+		return -ENOSYS;
+
 	ret = _lookup_hardreset(oh, name, &ohri);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
-						  ohri.rst_shift);
-	else if (cpu_is_omap44xx())
-		return omap4_prminst_assert_hardreset(ohri.rst_shift,
-				  oh->clkdm->pwrdm.ptr->prcm_partition,
-				  oh->clkdm->pwrdm.ptr->prcm_offs,
-				  oh->prcm.omap4.rstctrl_offs);
-	else
-		return -EINVAL;
+	ret = soc_ops.assert_hardreset(oh, &ohri);
+
+	return ret;
 }
 
 /**
@@ -1432,38 +1437,29 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
  * @oh: struct omap_hwmod *
  * @name: name of the reset line to look up and deassert
  *
- * Some IP like dsp, ipu or iva contain processor that require
- * an HW reset line to be assert / deassert in order to enable fully
- * the IP.
+ * Some IP like dsp, ipu or iva contain processor that require an HW
+ * reset line to be assert / deassert in order to enable fully the IP.
+ * Returns -EINVAL if @oh is null, -ENOSYS if we have no way of
+ * deasserting the hardreset line on the currently-booted SoC, or passes
+ * along the return value from _lookup_hardreset() or the SoC's
+ * deassert_hardreset code.
  */
 static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
 
+	if (!soc_ops.deassert_hardreset)
+		return -ENOSYS;
+
 	ret = _lookup_hardreset(oh, name, &ohri);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
-						   ohri.rst_shift,
-						   ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
-		if (ohri.st_shift)
-			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
-			       oh->name, name);
-		ret = omap4_prminst_deassert_hardreset(ohri.rst_shift,
-				  oh->clkdm->pwrdm.ptr->prcm_partition,
-				  oh->clkdm->pwrdm.ptr->prcm_offs,
-				  oh->prcm.omap4.rstctrl_offs);
-	} else {
-		return -EINVAL;
-	}
-
+	ret = soc_ops.deassert_hardreset(oh, &ohri);
 	if (ret == -EBUSY)
 		pr_warning("omap_hwmod: %s: failed to hardreset\n", oh->name);
 
@@ -1476,31 +1472,28 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
  * @oh: struct omap_hwmod *
  * @name: name of the reset line to look up and read
  *
- * Return the state of the reset line.
+ * Return the state of the reset line.  Returns -EINVAL if @oh is
+ * null, -ENOSYS if we have no way of reading the hardreset line
+ * status on the currently-booted SoC, or passes along the return
+ * value from _lookup_hardreset() or the SoC's is_hardreset_asserted
+ * code.
  */
 static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	u8 ret;
+	u8 ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
 
+	if (!soc_ops.is_hardreset_asserted)
+		return -ENOSYS;
+
 	ret = _lookup_hardreset(oh, name, &ohri);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
-						       ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
-		return omap4_prminst_is_hardreset_asserted(ohri.rst_shift,
-				  oh->clkdm->pwrdm.ptr->prcm_partition,
-				  oh->clkdm->pwrdm.ptr->prcm_offs,
-				  oh->prcm.omap4.rstctrl_offs);
-	} else {
-		return -EINVAL;
-	}
+	return soc_ops.is_hardreset_asserted(oh, &ohri);
 }
 
 /**
@@ -2455,6 +2448,129 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 					      oh->prcm.omap4.clkctrl_offs);
 }
 
+/**
+ * _omap2_assert_hardreset - call OMAP2 PRM hardreset fn with hwmod args
+ * @oh: struct omap_hwmod * to assert hardreset
+ * @ohri: hardreset line data
+ *
+ * Call omap2_prm_assert_hardreset() with parameters extracted from
+ * the hwmod @oh and the hardreset line data @ohri.  Only intended for
+ * use as an soc_ops function pointer.  Passes along the return value
+ * from omap2_prm_assert_hardreset().  XXX This function is scheduled
+ * for removal when the PRM code is moved into drivers/.
+ */
+static int _omap2_assert_hardreset(struct omap_hwmod *oh,
+				   struct omap_hwmod_rst_info *ohri)
+{
+	return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
+					  ohri->rst_shift);
+}
+
+/**
+ * _omap2_deassert_hardreset - call OMAP2 PRM hardreset fn with hwmod args
+ * @oh: struct omap_hwmod * to deassert hardreset
+ * @ohri: hardreset line data
+ *
+ * Call omap2_prm_deassert_hardreset() with parameters extracted from
+ * the hwmod @oh and the hardreset line data @ohri.  Only intended for
+ * use as an soc_ops function pointer.  Passes along the return value
+ * from omap2_prm_deassert_hardreset().  XXX This function is
+ * scheduled for removal when the PRM code is moved into drivers/.
+ */
+static int _omap2_deassert_hardreset(struct omap_hwmod *oh,
+				     struct omap_hwmod_rst_info *ohri)
+{
+	return omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
+					    ohri->rst_shift,
+					    ohri->st_shift);
+}
+
+/**
+ * _omap2_is_hardreset_asserted - call OMAP2 PRM hardreset fn with hwmod args
+ * @oh: struct omap_hwmod * to test hardreset
+ * @ohri: hardreset line data
+ *
+ * Call omap2_prm_is_hardreset_asserted() with parameters extracted
+ * from the hwmod @oh and the hardreset line data @ohri.  Only
+ * intended for use as an soc_ops function pointer.  Passes along the
+ * return value from omap2_prm_is_hardreset_asserted().  XXX This
+ * function is scheduled for removal when the PRM code is moved into
+ * drivers/.
+ */
+static int _omap2_is_hardreset_asserted(struct omap_hwmod *oh,
+					struct omap_hwmod_rst_info *ohri)
+{
+	return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
+					       ohri->st_shift);
+}
+
+/**
+ * _omap4_assert_hardreset - call OMAP4 PRM hardreset fn with hwmod args
+ * @oh: struct omap_hwmod * to assert hardreset
+ * @ohri: hardreset line data
+ *
+ * Call omap4_prminst_assert_hardreset() with parameters extracted
+ * from the hwmod @oh and the hardreset line data @ohri.  Only
+ * intended for use as an soc_ops function pointer.  Passes along the
+ * return value from omap4_prminst_assert_hardreset().  XXX This
+ * function is scheduled for removal when the PRM code is moved into
+ * drivers/.
+ */
+static int _omap4_assert_hardreset(struct omap_hwmod *oh,
+				   struct omap_hwmod_rst_info *ohri)
+
+{
+	return omap4_prminst_assert_hardreset(ohri->rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+}
+
+/**
+ * _omap4_deassert_hardreset - call OMAP4 PRM hardreset fn with hwmod args
+ * @oh: struct omap_hwmod * to deassert hardreset
+ * @ohri: hardreset line data
+ *
+ * Call omap4_prminst_deassert_hardreset() with parameters extracted
+ * from the hwmod @oh and the hardreset line data @ohri.  Only
+ * intended for use as an soc_ops function pointer.  Passes along the
+ * return value from omap4_prminst_deassert_hardreset().  XXX This
+ * function is scheduled for removal when the PRM code is moved into
+ * drivers/.
+ */
+static int _omap4_deassert_hardreset(struct omap_hwmod *oh,
+				     struct omap_hwmod_rst_info *ohri)
+{
+	if (ohri->st_shift)
+		pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
+		       oh->name, ohri->name);
+	return omap4_prminst_deassert_hardreset(ohri->rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+}
+
+/**
+ * _omap4_is_hardreset_asserted - call OMAP4 PRM hardreset fn with hwmod args
+ * @oh: struct omap_hwmod * to test hardreset
+ * @ohri: hardreset line data
+ *
+ * Call omap4_prminst_is_hardreset_asserted() with parameters
+ * extracted from the hwmod @oh and the hardreset line data @ohri.
+ * Only intended for use as an soc_ops function pointer.  Passes along
+ * the return value from omap4_prminst_is_hardreset_asserted().  XXX
+ * This function is scheduled for removal when the PRM code is moved
+ * into drivers/.
+ */
+static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
+					struct omap_hwmod_rst_info *ohri)
+{
+	return omap4_prminst_is_hardreset_asserted(ohri->rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+}
+
 /* Public functions */
 
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
@@ -3443,10 +3559,16 @@ void __init omap_hwmod_init(void)
 {
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		soc_ops.wait_target_ready = _omap2_wait_target_ready;
+		soc_ops.assert_hardreset = _omap2_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
 	} else if (cpu_is_omap44xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
+		soc_ops.assert_hardreset = _omap4_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
-- 
1.7.10


