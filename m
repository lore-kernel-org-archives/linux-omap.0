From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 5/6] ARM: OMAP2+: hwmod: use init-time function pointer for hardreset
Date: Fri, 27 Apr 2012 13:05:39 -0700
Message-ID: <1335557140-10854-6-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43955 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab2D0UE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 16:04:58 -0400
Received: by dajr28 with SMTP id r28so1494588daj.40
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 13:04:57 -0700 (PDT)
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Rather than using cpu_is* checking at runtime, initialize SoC specific
function pointers for the various hard reset functions at init time.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  111 +++++++++++++++++---------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++
 2 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6dd454d..6b08f19 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1424,6 +1424,59 @@ static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name,
 	return -ENOENT;
 }
 
+static int omap2_assert_hardreset(struct omap_hwmod *oh,
+				  struct omap_hwmod_rst_info *ohri)
+{
+	return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
+					  ohri->rst_shift);
+}
+
+static int omap2_deassert_hardreset(struct omap_hwmod *oh,
+				    struct omap_hwmod_rst_info *ohri)
+{
+	return omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
+					    ohri->rst_shift,
+					    ohri->st_shift);
+}
+
+static int omap2_is_hardreset_asserted(struct omap_hwmod *oh,
+				       struct omap_hwmod_rst_info *ohri)
+{
+	return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
+					       ohri->st_shift);
+}
+
+static int omap4_assert_hardreset(struct omap_hwmod *oh,
+				  struct omap_hwmod_rst_info *ohri)
+
+{
+	return omap4_prminst_assert_hardreset(ohri->rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+}
+
+static int omap4_deassert_hardreset(struct omap_hwmod *oh,
+				    struct omap_hwmod_rst_info *ohri)
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
+static int omap4_is_hardreset_asserted(struct omap_hwmod *oh,
+				       struct omap_hwmod_rst_info *ohri)
+{
+	return omap4_prminst_is_hardreset_asserted(ohri->rst_shift,
+				oh->clkdm->pwrdm.ptr->prcm_partition,
+				oh->clkdm->pwrdm.ptr->prcm_offs,
+				oh->prcm.omap4.rstctrl_offs);
+}
+
 /**
  * _assert_hardreset - assert the HW reset line of submodules
  * contained in the hwmod module.
@@ -1437,7 +1490,7 @@ static u8 _lookup_hardreset(struct omap_hwmod *oh, const char *name,
 static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	u8 ret;
+	u8 ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
@@ -1446,16 +1499,10 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
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
+	if (oh->assert_hardreset)
+		ret = oh->assert_hardreset(oh, &ohri);
+
+	return ret;
 }
 
 /**
@@ -1471,7 +1518,7 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
@@ -1480,21 +1527,8 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
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
+	if (oh->deassert_hardreset)
+		ret = oh->deassert_hardreset(oh, &ohri);
 
 	if (ret == -EBUSY)
 		pr_warning("omap_hwmod: %s: failed to hardreset\n", oh->name);
@@ -1513,7 +1547,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	u8 ret;
+	u8 ret = -EINVAL;
 
 	if (!oh)
 		return -EINVAL;
@@ -1522,17 +1556,10 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
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
+	if (oh->is_hardreset_asserted)
+		ret = oh->is_hardreset_asserted(oh, &ohri);
+
+	return ret;
 }
 
 /**
@@ -2063,10 +2090,16 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		oh->wait_module_ready = omap2_wait_module_ready;
+		oh->assert_hardreset = omap2_assert_hardreset;
+		oh->deassert_hardreset = omap2_deassert_hardreset;
+		oh->is_hardreset_asserted = omap2_is_hardreset_asserted;
 	} else if (cpu_is_omap44xx()) {
 		oh->enable_module = _omap4_enable_module;
 		oh->disable_module = _omap4_disable_module;
 		oh->wait_module_ready = omap4_wait_module_ready;
+		oh->assert_hardreset = omap4_assert_hardreset;
+		oh->deassert_hardreset = omap4_deassert_hardreset;
+		oh->is_hardreset_asserted = omap4_is_hardreset_asserted;
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 329ede5..4f512b6 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -568,6 +568,12 @@ struct omap_hwmod {
 	void (*enable_module)(struct omap_hwmod *oh);
 	int (*disable_module)(struct omap_hwmod *oh);
 	int (*wait_module_ready)(struct omap_hwmod *oh);
+	int (*assert_hardreset)(struct omap_hwmod *oh,
+				struct omap_hwmod_rst_info *ohri);
+	int (*deassert_hardreset)(struct omap_hwmod *oh,
+				  struct omap_hwmod_rst_info *ohri);
+	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
+				     struct omap_hwmod_rst_info *ohri);
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-- 
1.7.9.2

