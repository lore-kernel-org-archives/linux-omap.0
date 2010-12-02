From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v7] OMAP2+: PM: omap device: API's for handling mstandby mode
Date: Thu,  2 Dec 2010 19:29:52 +0530
Message-ID: <1291298392-28729-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42953 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757470Ab0LBN7R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 08:59:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

Certain errata in OMAP2+ processors will require forcing
master standby to "no standby" mode before completing on going
operation. Without this, the results will be unpredictable.

Since current implementation of PM run time framework does not support
changing sysconfig settings during middle of the on going operation,
these API's will support the same. One API will force the device's
sysconfig mstandby mode settings to "no standby" and other API will
release "no standby" mode and sets it to "smart standby" or "no
standby? depending on HWMOD_SWSUP_MSTANDBY value.

The hwmod API "omap_hwmod_set_master_standbymode" will use
no_stdby_cnt(introduced in omap_hwmod structure) for controlling
access to sysconfig register settings in case of overlapping
request/release API's are called. It also disables interrupts during
syconfig register access.

These API's should be used by device drivers only incase of
erratum applicable to their modules if there is no other methods
to resolve.

These API's are required for multiple DMA errata which require
putting DMA controller in no mstandby mode before stopping dma.

The applicable errata:
1. Erratum ID: i557(Applicable for omap36xx all ES versions)
The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
through config port while in Standby.

2. Erratum ID: i541
sDMA FIFO draining does not finish. Applicable to all omap2+ except
omap4.

3. Erratum ID:i88
The sDMA to be put in no mstandby mode before disabling the channel
after completing the data transfer operation.
Applicable only for OMAP3430 ES1.0

Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
omap_hwmod.h

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org
---
v3: Review comments incorporated for:
https://patchwork.kernel.org/patch/282212/

v4: added mutex changes
https://patchwork.kernel.org/patch/338611/

v5: typo fixes for errata and erratum
https://patchwork.kernel.org/patch/352481/

v6: fixed oh increment bug and also mutex(missing in v5)
https://patchwork.kernel.org/patch/372231/

v7: replaced mutex lock with spin lock. Added use count for controlling
access to sysconfig registers in case if overlapping request/release API's
are used.

This patch has dependency on the patch series:
http://www.spinics.net/lists/linux-omap/msg40188.html
(OMAP2+: hwmod core upgrades for 2.6.38: first set)
Apply the above set of patches before using this patch.

 arch/arm/mach-omap2/omap_hwmod.c              |   70 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 +
 arch/arm/plat-omap/omap_device.c              |   60 +++++++++++++++++++++
 4 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8a9847e..287818b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1474,6 +1474,76 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
 }
 
 /**
+ * omap_hwmod_set_master_standbymode - set the hwmod's OCP mstandby mode
+ * @oh: struct omap_hwmod *
+ * @midlemode: flag to set mstandby to either "no standby" or "smart standby"
+ *
+ * Sets the IP block's OCP mstandby mode in hardware, and updates our
+ * local copy.  Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the MIDLEMODE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_master_standbymode().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode)
+{
+	u32 v;
+	u8 sf;
+	int retval = -1;
+	unsigned int long flags;
+
+	if (!oh)
+		return -EINVAL;
+
+	if (!oh->class->sysc)
+		return -EINVAL;
+
+	spin_lock_irqsave(&oh->_lock, flags);
+
+	v = oh->_sysc_cache;
+	sf = oh->class->sysc->sysc_flags;
+
+	if (!(sf & SYSC_HAS_MIDLEMODE)) {
+		spin_unlock_irqrestore(&oh->_lock, flags);
+		return -EINVAL;
+	}
+
+	if (idlemode) {
+		if (oh->no_stdby_cnt) {
+			atomic_inc(oh->no_stdby_cnt);
+			goto in_nostandby_mode;
+		}
+		atomic_inc(oh->no_stdby_cnt);
+		idlemode = HWMOD_IDLEMODE_NO;
+	} else {
+		if (oh->no_stdby_cnt == 1) {
+			atomic_dec(oh->no_stdby_cnt);
+			idlemode = (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
+				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+		} else if (oh->no_stdby_cnt > 1) {
+			goto out_nostandby_mode;
+		} else {
+			goto in_nostandby_mode;
+		}
+	}
+	retval = _set_master_standbymode(oh, idlemode, &v);
+
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+
+out_nostandby_mode:
+	atomic_dec(oh->no_stdby_cnt);
+
+in_nostandby_mode:
+	spin_unlock_irqrestore(&oh->_lock, flags);
+
+	return retval;
+}
+
+/**
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 28e2d1a..4fbf7c1 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,6 +116,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+int omap_device_require_no_mstandby(struct platform_device *pdev);
+int omap_device_release_no_mstandby(struct platform_device *pdev);
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 62bdb23..9d591fb 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -508,6 +508,7 @@ struct omap_hwmod {
 	u8				masters_cnt;
 	u8				slaves_cnt;
 	u8				hwmods_cnt;
+	u8				no_stdby_cnt;
 	u8				_int_flags;
 	u8				_state;
 	u8				_postsetup_state;
@@ -537,6 +538,8 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
 
+int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode);
+
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index abe933c..2d42ab2 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -584,6 +584,66 @@ int omap_device_idle(struct platform_device *pdev)
 }
 
 /**
+ * omap_device_require_no_mstandby - set no mstandby mode of an omap_device
+ * @od: struct omap_device * to idle
+ *
+ * Sets the IP block's OCP master standby to no mstandby mode in hardware.
+ *
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
+ * omap_device is not currently enabled or passes along the return value
+ * of omap_hwmod_set_master_standbymode().
+ */
+int omap_device_require_no_mstandby(struct platform_device *pdev)
+{
+	int ret  = 0, i;
+	struct omap_device *od;
+
+	od = _find_by_pdev(pdev);
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		ret = omap_hwmod_set_master_standbymode(od->hwmods[i], true);
+
+	return ret;
+}
+
+/**
+ * omap_device_release_no_mstandby - releases no mstandby mode of an omap_device
+ * @od: struct omap_device * to idle
+ *
+ * Release no mstandby mode and sets the master standby to either no standby or
+ * smart standby in IP block's OCP in hardware depending on status of the flag
+ * HWMOD_SWSUP_MSTANDBY.
+ *
+ * Intended to be used by drivers that have some erratum that requires direct
+ * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
+ * omap_device is not currently enabled or passes along the return value
+ * of omap_hwmod_set_master_standbymode().
+ */
+int omap_device_release_no_mstandby(struct platform_device *pdev)
+{
+	int ret  = 0, i;
+	struct omap_device *od;
+
+	od = _find_by_pdev(pdev);
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		ret = omap_hwmod_set_master_standbymode(od->hwmods[i], false);
+
+	return ret;
+}
+
+/**
  * omap_device_shutdown - shut down an omap_device
  * @od: struct omap_device * to shut down
  *
-- 
1.7.1

