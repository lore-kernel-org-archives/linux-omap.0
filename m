From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/2] OMAP: omap_device: API to modify AUTOIDLE and SMARTIDLE bits
Date: Mon, 31 Jan 2011 18:04:48 +0530
Message-ID: <1296477288-26253-3-git-send-email-kishon@ti.com>
References: <1296477288-26253-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52362 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391Ab1AaMjd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 07:39:33 -0500
In-Reply-To: <1296477288-26253-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

Provide APIs to be used by the driver in order to modify AUTOIDLE
and SIDLE bits. These APIs in turn call hwmod APIs to modify the
SYSCONFIG register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    6 +
 arch/arm/plat-omap/omap_device.c              |  176 +++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..47ad0ab 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -110,6 +110,12 @@ struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
 u32 omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
+int omap_device_noidle(struct omap_device *od);
+int omap_device_smartidle(struct omap_device *od);
+int omap_device_forceidle(struct omap_device *od);
+int omap_device_default_idle(struct omap_device *od);
+int omap_device_enable_autoidle(struct omap_device *od);
+int omap_device_disable_autoidle(struct omap_device *od);
 
 int omap_device_idle_hwmods(struct omap_device *od);
 int omap_device_enable_hwmods(struct omap_device *od);
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 57adb27..da8609a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -726,6 +726,182 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
 	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
 }
 
+/**
+ * omap_device_noidle - set the device's slave idlemode to no idle
+ * @od: struct omap_device *
+ *
+ * Sets the IP block's OCP slave idlemode in hardware to no idle.
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in invalid
+ * state, or passes along the return value from
+ * omap_hwmod_set_slave_idlemode().
+ */
+int omap_device_noidle(struct omap_device *od)
+{
+	int retval = 0, i;
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state "
+			"%d\n", od->pdev.name, od->pdev.id, __func__,
+			od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
+					HWMOD_IDLEMODE_NO);
+
+	return retval;
+}
+
+
+/**
+ * omap_device_smartidle - set the device's slave idlemode to smart idle
+ * @od: struct omap_device *
+ *
+ * Sets the IP block's OCP slave idlemode in hardware to smart idle.
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in invalid
+ * state, or passes along the return value from
+ * omap_hwmod_set_slave_idlemode().
+ */
+int omap_device_smartidle(struct omap_device *od)
+{
+	int retval = 0, i;
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state "
+			"%d\n", od->pdev.name, od->pdev.id, __func__,
+			od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
+					HWMOD_IDLEMODE_SMART);
+
+	return retval;
+}
+
+
+/**
+ * omap_device_forceidle - set the device's slave idlemode to force idle
+ * @od: struct omap_device *
+ *
+ * Sets the IP block's OCP slave idlemode in hardware to force idle.
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in invalid
+ * state, or passes along the return value from
+ * omap_hwmod_set_slave_idlemode().
+ */
+int omap_device_forceidle(struct omap_device *od)
+{
+	int retval = 0, i;
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state "
+			"%d\n", od->pdev.name, od->pdev.id, __func__,
+			od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
+					HWMOD_IDLEMODE_FORCE);
+
+	return retval;
+}
+
+/**
+ * omap_device_default_idle - set the device's slave idlemode to no idle or
+ * smart idle based on the hwmod flag
+ * @od: struct omap_device *
+ *
+ * Sets the IP block's OCP slave idlemode in hardware to no idle or smart idle
+ * depending on status of the flag HWMOD_SWSUP_SIDLE.
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the SIDLEMODE bits.  Returns -EINVAL if @od is in invalid
+ * state, or passes along the return value from
+ * omap_hwmod_set_slave_idlemode().
+ */
+int omap_device_default_idle(struct omap_device *od)
+{
+	int retval = 0, i;
+	u8 idlemode;
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state "
+			"%d\n", od->pdev.name, od->pdev.id, __func__,
+		od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		idlemode = (od->hwmods[i]->flags & HWMOD_SWSUP_SIDLE) ?
+				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+		retval |= omap_hwmod_set_slave_idlemode(od->hwmods[i],
+				idlemode);
+	}
+
+	return retval;
+}
+
+/*
+ * omap_device_enable_autoidle - enable the device's OCP slave autoidle
+ * @od: struct omap_device *
+ *
+ * Sets the IP block's OCP slave autoidle in hardware.
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the AUTOIDLE bits.  Returns -EINVAL if @od is in invalid
+ * state, or passes along the return value from
+ * omap_hwmod_set_slave_autoidle().
+ */
+int omap_device_enable_autoidle(struct omap_device *od)
+{
+	int retval = 0, i;
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state "
+			"%d\n", od->pdev.name, od->pdev.id, __func__,
+			od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		retval |= omap_hwmod_set_slave_autoidle(od->hwmods[i],
+					true);
+
+	return retval;
+}
+
+/*
+ * omap_device_disable_autoidle - disable the device's OCP slave autoidle
+ * @od: struct omap_device *
+ *
+ * Disables the IP block's OCP slave autoidle in hardware.
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the AUTOIDLE bits.  Returns -EINVAL if @od is in invalid
+ * state, or passes along the return value from
+ * omap_hwmod_set_slave_autoidle().
+ */
+int omap_device_disable_autoidle(struct omap_device *od)
+{
+	int retval = 0, i;
+
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state "
+			"%d\n", od->pdev.name, od->pdev.id, __func__,
+			od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		retval |= omap_hwmod_set_slave_autoidle(od->hwmods[i],
+					false);
+
+	return retval;
+}
+
 /*
  * Public functions intended for use in omap_device_pm_latency
  * .activate_func and .deactivate_func function pointers
-- 
1.7.0.4

