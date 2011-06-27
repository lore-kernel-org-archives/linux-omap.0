From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 13/13] OMAP4: hwmod: Introduce the module control in hwmod control
Date: Mon, 27 Jun 2011 17:47:21 +0200
Message-ID: <1309189641-25010-14-git-send-email-b-cousson@ti.com>
References: <1309189641-25010-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50072 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab1F0Prv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 11:47:51 -0400
In-Reply-To: <1309189641-25010-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Take advantage of the explicit modulemode control to fix
the way parents clocks are managed.
A module must be disabled before any parents are disabled.
That programming model was not possible with the previous
implementation that was considering a modulemode as a leaf
clock node managed by the clock fmwk.
This was leading to bad crash upon disable when the parent
clock was gated before the module completed its transition
to idle.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   63 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6788c75..3eef106 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -675,6 +675,56 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 }
 
 /**
+ * _enable_module - enable CLKCTRL modulemode on OMAP4
+ * @oh: struct omap_hwmod *
+ *
+ * Enables the PRCM module mode related to the hwmod @oh.
+ * No return value.
+ */
+static void _enable_module(struct omap_hwmod *oh)
+{
+	/* The module mode does not exist prior OMAP4 */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return;
+
+	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
+		return;
+
+	pr_debug("omap_hwmod: %s: _enable_module: %d\n",
+		 oh->name, oh->prcm.omap4.modulemode);
+
+	omap4_cm_module_enable(oh->prcm.omap4.modulemode,
+			       oh->clkdm->prcm_partition,
+			       oh->clkdm->cm_inst,
+			       oh->clkdm->clkdm_offs,
+			       oh->prcm.omap4.clkctrl_offs);
+}
+
+/**
+ * _disable_module - enable CLKCTRL modulemode on OMAP4
+ * @oh: struct omap_hwmod *
+ *
+ * Disable the PRCM module mode related to the hwmod @oh.
+ * No return value.
+ */
+static void _disable_module(struct omap_hwmod *oh)
+{
+	/* The module mode does not exist prior OMAP4 */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return;
+
+	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
+		return;
+
+	pr_debug("omap_hwmod: %s: _disable_module\n", oh->name);
+
+	omap4_cm_module_disable(oh->clkdm->prcm_partition,
+				oh->clkdm->cm_inst,
+				oh->clkdm->clkdm_offs,
+				oh->prcm.omap4.clkctrl_offs);
+}
+
+/**
  * _find_mpu_port_index - find hwmod OCP slave port ID intended for MPU use
  * @oh: struct omap_hwmod *
  *
@@ -1329,6 +1379,7 @@ static int _enable(struct omap_hwmod *oh)
 
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
+	_enable_module(oh);
 
 	/*
 	 * If an IP contains only one HW reset line, then de-assert it in order
@@ -1381,11 +1432,18 @@ static int _idle(struct omap_hwmod *oh)
 	if (oh->class->sysc)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
-	_disable_clocks(oh);
+	_disable_module(oh);
 	ret = _wait_target_disable(oh);
 	if (ret)
 		pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
 			   oh->name);
+	/*
+	 * The module must be in idle mode before disabling any parents
+	 * clocks. Otherwise, the parent clock might be disabled before
+	 * the module transition is done, and thus will prevent the
+	 * transition to complete properly.
+	 */
+	_disable_clocks(oh);
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic)
@@ -1477,11 +1535,12 @@ static int _shutdown(struct omap_hwmod *oh)
 	if (oh->_state == _HWMOD_STATE_ENABLED) {
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
-		_disable_clocks(oh);
+		_disable_module(oh);
 		ret = _wait_target_disable(oh);
 		if (ret)
 			pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
 				   oh->name);
+		_disable_clocks(oh);
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-- 
1.7.0.4

