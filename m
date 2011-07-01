From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 04/13] OMAP: hwmod: Wait the idle status to be disabled
Date: Fri, 1 Jul 2011 23:09:09 +0200
Message-ID: <1309554558-19819-5-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1GAVJh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:09:37 -0400
In-Reply-To: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

It is mandatory to wait for a module to be in disabled state before
potentially disabling source clock or re-asserting a reset.

omap_hwmod_idle and omap_hwmod_shutdown does not wait for
the module to be fully idle.

Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
Fix hwmod_[idle|shutdown] to use this API.

Based on Rajendra's initial patch.

Please note that most interconnects hwmod will return one timeout because
it is impossible for them to be in idle since the processor is accessing
the registers though the interconnect.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   25 +++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    1 +
 arch/arm/mach-omap2/omap_hwmod.c |   40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 1df740e..fa44ff5 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -244,3 +244,28 @@ int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
 
+/**
+ * omap4_cm_wait_module_idle - wait for a module to be in 'disabled'
+ * state
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ *
+ * Wait for the module IDLEST to be disabled. Some PRCM transition,
+ * like reset assertion or parent clock de-activation must wait the
+ * module to be fully disabled.
+ */
+int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+{
+	int i = 0;
+
+	if (!clkctrl_offs)
+		return 0;
+
+	omap_test_timeout(
+		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x3,
+		MAX_MODULE_READY_TIME, i);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 9d39c70..4c5da7d 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -18,6 +18,7 @@ extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 
 extern int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
+extern int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 
 /*
  * In an ideal world, we would not export these low-level functions,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 83eb528..b54e1e6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1031,6 +1031,36 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 }
 
 /**
+ * _wait_target_disable - wait for a module to be disabled
+ * @oh: struct omap_hwmod *
+ *
+ * Wait for a module @oh to leave slave idle.  Returns 0 if the module
+ * does not have an IDLEST bit or if the module successfully leaves
+ * slave idle; otherwise, pass along the return value of the
+ * appropriate *_cm_wait_module_ready() function.
+ */
+static int _wait_target_disable(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return -EINVAL;
+
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return 0;
+
+	if (oh->flags & HWMOD_NO_IDLEST)
+		return 0;
+
+	/* TODO: For now just handle OMAP4+ */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return 0;
+
+	return omap4_cm_wait_module_idle(oh->clkdm->prcm_partition,
+					 oh->clkdm->cm_inst,
+					 oh->clkdm->clkdm_offs,
+					 oh->prcm.omap4.clkctrl_offs);
+}
+
+/**
  * _lookup_hardreset - fill register bit info for this hwmod/reset line
  * @oh: struct omap_hwmod *
  * @name: name of the reset line in the context of this hwmod
@@ -1339,6 +1369,8 @@ static int _enable(struct omap_hwmod *oh)
  */
 static int _idle(struct omap_hwmod *oh)
 {
+	int ret;
+
 	pr_debug("omap_hwmod: %s: idling\n", oh->name);
 
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
@@ -1351,6 +1383,10 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
+	ret = _wait_target_disable(oh);
+	if (ret)
+		pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
+			   oh->name);
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic)
@@ -1443,6 +1479,10 @@ static int _shutdown(struct omap_hwmod *oh)
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
 		_disable_clocks(oh);
+		ret = _wait_target_disable(oh);
+		if (ret)
+			pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
+				   oh->name);
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-- 
1.7.0.4

