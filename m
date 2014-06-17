From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 1/2] arm: omap2+: hwmod: Add refcounting for modulemode shared by multiple hwmods
Date: Tue, 17 Jun 2014 15:24:33 +0530
Message-ID: <1402998874-1024-2-git-send-email-archit@ti.com>
References: <1401101095-27181-1-git-send-email-archit@ti.com>
 <1402998874-1024-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbaFQJ4I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 05:56:08 -0400
In-Reply-To: <1402998874-1024-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Generally, IP blocks/modules within a clock domain come with their own
CM_x_CLKCTRL registers, each having it's own MODULEMODE field to manage the
module.

DSS clockdomain, however, has multiple modules in it, but only one register
named CM_DSS_DSS_CLKCTRL, which contains one MODULEMODE register field.

Until now, we defined modulemode only for the top level DSS hwmod("dss_core")
and didn't define it for other DSS hwmods(like "dss_dispc", "dss_dsi1" and so
on). This made the omapdss driver work as the top level DSS platform device
and the rest had a parent-child relationship, and ensured that the parent
hwmod("dss_core") is enabled if any of the children hwmods are enabled.

This method, however, doesn't work when each hwmod is enabled individually. When
hwmods are set up in omap_hwmod_setup_all, each hwmod is individually enabled,
followed by a reset and idle. All the 'children' DSS hwmods fail to enable as
they don't enable modulemode.

The way to make such modules work both during initialization and when used by
pm runtime API in the driver is be to add refcounting for enabling/disabling
modulemode.

We create a struct called 'mmode_shared'. The hwmod data file should define
an instance of this struct. Each hwmod that uses this modulemode field should
hold a pointer to this instance.

omap_hwmod's soc enable_module and disable_module ops set the MODULEMODE
reigster bits only when the first module using it is enabled, or the last
module using it is disabled. We serialize accesses to the struct with a
spinlock.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 145 ++++++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.h |  35 +++++++---
 2 files changed, 153 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f7bb435..2b036e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1,3 +1,4 @@
+
 /*
  * omap_hwmod implementation for OMAP2/3/4
  *
@@ -973,17 +974,38 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
  */
 static void _omap4_enable_module(struct omap_hwmod *oh)
 {
+	struct mmode_shared *mmode;
+
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return;
 
 	pr_debug("omap_hwmod: %s: %s: %d\n",
 		 oh->name, __func__, oh->prcm.omap4.modulemode);
 
-	omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
-				   oh->clkdm->prcm_partition,
-				   oh->clkdm->cm_inst,
-				   oh->clkdm->clkdm_offs,
-				   oh->prcm.omap4.clkctrl_offs);
+	mmode = oh->prcm.omap4.mmode_ref;
+	if (mmode) {
+		bool enable;
+		unsigned long flags;
+
+		spin_lock_irqsave(&mmode->lock, flags);
+
+		enable = mmode->refcnt++ == 0;
+
+		if (enable)
+			omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
+						   oh->clkdm->prcm_partition,
+						   oh->clkdm->cm_inst,
+						   oh->clkdm->clkdm_offs,
+						   oh->prcm.omap4.clkctrl_offs);
+
+		spin_unlock_irqrestore(&mmode->lock, flags);
+	} else {
+		omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
+					   oh->clkdm->prcm_partition,
+					   oh->clkdm->cm_inst,
+					   oh->clkdm->clkdm_offs,
+					   oh->prcm.omap4.clkctrl_offs);
+	}
 }
 
 /**
@@ -995,15 +1017,36 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
  */
 static void _am33xx_enable_module(struct omap_hwmod *oh)
 {
+	struct mmode_shared *mmode;
+
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return;
 
 	pr_debug("omap_hwmod: %s: %s: %d\n",
 		 oh->name, __func__, oh->prcm.omap4.modulemode);
 
-	am33xx_cm_module_enable(oh->prcm.omap4.modulemode, oh->clkdm->cm_inst,
-				oh->clkdm->clkdm_offs,
-				oh->prcm.omap4.clkctrl_offs);
+	mmode = oh->prcm.omap4.mmode_ref;
+	if (mmode) {
+		bool enable;
+		unsigned long flags;
+
+		spin_lock_irqsave(&mmode->lock, flags);
+
+		enable = mmode->refcnt++ == 0;
+
+		if (enable)
+			am33xx_cm_module_enable(oh->prcm.omap4.modulemode,
+						oh->clkdm->cm_inst,
+						oh->clkdm->clkdm_offs,
+						oh->prcm.omap4.clkctrl_offs);
+
+		spin_unlock_irqrestore(&mmode->lock, flags);
+	} else {
+		am33xx_cm_module_enable(oh->prcm.omap4.modulemode,
+					oh->clkdm->cm_inst,
+					oh->clkdm->clkdm_offs,
+					oh->prcm.omap4.clkctrl_offs);
+	}
 }
 
 /**
@@ -1845,7 +1888,8 @@ static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
  */
 static int _omap4_disable_module(struct omap_hwmod *oh)
 {
-	int v;
+	int v = 0;
+	struct mmode_shared *mmode;
 
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return -EINVAL;
@@ -1859,12 +1903,36 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
 
-	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
-				    oh->clkdm->cm_inst,
-				    oh->clkdm->clkdm_offs,
-				    oh->prcm.omap4.clkctrl_offs);
+	mmode = oh->prcm.omap4.mmode_ref;
+	if (mmode) {
+		bool disable;
+		unsigned long flags;
+
+		spin_lock_irqsave(&mmode->lock, flags);
+
+		WARN_ON(mmode->refcnt == 0);
+
+		disable = --mmode->refcnt == 0;
+
+		if (disable) {
+			omap4_cminst_module_disable(oh->clkdm->prcm_partition,
+						    oh->clkdm->cm_inst,
+						    oh->clkdm->clkdm_offs,
+						    oh->prcm.omap4.clkctrl_offs);
+
+			v = _omap4_wait_target_disable(oh);
+		}
+
+		spin_unlock_irqrestore(&mmode->lock, flags);
+	} else {
+		omap4_cminst_module_disable(oh->clkdm->prcm_partition,
+					    oh->clkdm->cm_inst,
+					    oh->clkdm->clkdm_offs,
+					    oh->prcm.omap4.clkctrl_offs);
+
+		v = _omap4_wait_target_disable(oh);
+	}
 
-	v = _omap4_wait_target_disable(oh);
 	if (v)
 		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
 			oh->name);
@@ -1881,7 +1949,8 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
  */
 static int _am33xx_disable_module(struct omap_hwmod *oh)
 {
-	int v;
+	int v = 0;
+	struct mmode_shared *mmode;
 
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
 		return -EINVAL;
@@ -1891,10 +1960,34 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
 	if (_are_any_hardreset_lines_asserted(oh))
 		return 0;
 
-	am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
-				 oh->prcm.omap4.clkctrl_offs);
+	mmode = oh->prcm.omap4.mmode_ref;
+	if (mmode) {
+		bool disable;
+		unsigned long flags;
+
+		spin_lock_irqsave(&mmode->lock, flags);
+
+		WARN_ON(mmode->refcnt == 0);
+
+		disable = --mmode->refcnt == 0;
+
+		if (disable) {
+			am33xx_cm_module_disable(oh->clkdm->cm_inst,
+						 oh->clkdm->clkdm_offs,
+						 oh->prcm.omap4.clkctrl_offs);
+
+			v = _am33xx_wait_target_disable(oh);
+		}
+
+		spin_unlock_irqrestore(&mmode->lock, flags);
+	} else {
+		am33xx_cm_module_disable(oh->clkdm->cm_inst,
+					 oh->clkdm->clkdm_offs,
+					 oh->prcm.omap4.clkctrl_offs);
+
+		v = _am33xx_wait_target_disable(oh);
+	}
 
-	v = _am33xx_wait_target_disable(oh);
 	if (v)
 		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
 			oh->name);
@@ -2751,6 +2844,12 @@ static int __init _register(struct omap_hwmod *oh)
 	if (_lookup(oh->name))
 		return -EEXIST;
 
+	if (oh->prcm.omap4.mmode_ref && !oh->prcm.omap4.modulemode) {
+		pr_err("omap_hwmod: %s shares modulemode, but doesn't specify any modulemode control type\n",
+			oh->name);
+		return -EINVAL;
+	}
+
 	list_add_tail(&oh->node, &omap_hwmod_list);
 
 	INIT_LIST_HEAD(&oh->master_ports);
@@ -2759,6 +2858,16 @@ static int __init _register(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_REGISTERED;
 
+	if (oh->prcm.omap4.mmode_ref) {
+		struct mmode_shared *mmode = oh->prcm.omap4.mmode_ref;
+
+		if (!mmode->inited) {
+			spin_lock_init(&mmode->lock);
+			mmode->refcnt = 0;
+			mmode->inited = true;
+		}
+	}
+
 	/*
 	 * XXX Rather than doing a strcmp(), this should test a flag
 	 * set in the hwmod data, inserted by the autogenerator code.
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d63..ff6ec56 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -432,6 +432,21 @@ struct omap_hwmod_omap2_prcm {
 };
 
 /*
+ * struct for managing modulemode field shared accross IP blocks
+ * @lock: spinlock to searilze enables/disables performed by different
+ *     hwmods sharing the same modulemode field
+ * @refcnt: keep a refcount of the enabled hwmods using this modulemode
+ *     field
+ * @inited: a flag to track whether the struct has been initialized or
+ *     not
+ */
+struct mmode_shared {
+	spinlock_t	lock;
+	unsigned	refcnt;
+	bool		inited;
+};
+
+/*
  * Possible values for struct omap_hwmod_omap4_prcm.flags
  *
  * HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT: Some IP blocks don't have a PRCM
@@ -450,6 +465,7 @@ struct omap_hwmod_omap2_prcm {
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @flags: PRCM register capabilities for this IP block
  * @modulemode: allowable modulemodes
+ * @mmode_ref: pointer to modulemode struct shared by multiple hwmods
  * @context_lost_counter: Count of module level context lost
  *
  * If @lostcontext_mask is not defined, context loss check code uses
@@ -458,15 +474,16 @@ struct omap_hwmod_omap2_prcm {
  * more hwmods.
  */
 struct omap_hwmod_omap4_prcm {
-	u16		clkctrl_offs;
-	u16		rstctrl_offs;
-	u16		rstst_offs;
-	u16		context_offs;
-	u32		lostcontext_mask;
-	u8		submodule_wkdep_bit;
-	u8		modulemode;
-	u8		flags;
-	int		context_lost_counter;
+	u16			clkctrl_offs;
+	u16			rstctrl_offs;
+	u16			rstst_offs;
+	u16			context_offs;
+	u32			lostcontext_mask;
+	u8			submodule_wkdep_bit;
+	u8			modulemode;
+	struct mmode_shared	*mmode_ref;
+	u8			flags;
+	int			context_lost_counter;
 };
 
 
-- 
1.9.1

