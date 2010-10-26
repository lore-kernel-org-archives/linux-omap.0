From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2] OMAP2+: PM: omap_device: API for set/get MSTANDBY mode
Date: Tue, 26 Oct 2010 17:41:41 +0530
Message-ID: <1288095101-1294-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932618Ab0JZMLM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 08:11:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Anand Gadiyar <gadiyar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Certain errata's in OMAP2+ processors will require disabling
master standby mode before completing on going operation. Without
this, the results will be unpredictable.

Since current implementation of PM run time framework does not support
changing sysconfig settings during middle of the on going operation,
these API's will support the same.

These API's should be used by device drivers only incase of
erratum applicable to their modules if there is no other methods
to resolve.

This API is required for multiple DMA errata's which require
putting DMA controller in no mstandby mode before stopping dma.

The applicable errata's:
1. Errata ID: i557(Applicable for omap36xx all ES versions)
The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared 
through config port while in Standby.

2. Errata ID: i541(all omap2plus except omap4)
sDMA FIFO draining does not finish

3. Errata ID: i88(only omap3430 ES1.0)
Special programming model needed to disable DMA before end
of block

4. OMAP3430 ES1.0(Errata ID:i88) will require DMA to be put in
no mstandby mode before disabling the channel after completing
the data transfer operation.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
Changes from v1 to v2:
 - updated patch description with relevant errata id's.
 - API name changed to master_standbymode from master_idlemode

 arch/arm/mach-omap2/omap_hwmod.c              |   83 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    3 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 +
 arch/arm/plat-omap/omap_device.c              |   36 +++++++++++
 4 files changed, 124 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a30658..e3f7490 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -250,6 +250,35 @@ static int _set_master_standbymode(struct omap_hwmod *oh, u8 standbymode,
 }
 
 /**
+ * _get_master_standbymode: get the OCP_SYSCONFIG MIDLEMODE field in @midlemode
+ * @oh: struct omap_hwmod *
+ * @standbymode: pointer to get mstandby mode bits(shifted to bit 0)
+ *
+ * Get the master standby mode bits in @midlemode for the @oh hwmod.
+ * Does not fetch the data from the hardware instead returns value
+ * from sysc_cache. Returns -EINVAL upon error or 0 upon success.
+ */
+static int _get_master_standbymode(struct omap_hwmod *oh, u32 *midlemode)
+{
+	u32 mstandby_mask;
+	u8 mstandby_shift;
+
+	if (!oh->class->sysc ||
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_MIDLEMODE))
+		return -EINVAL;
+
+	if (!oh->class->sysc->sysc_fields) {
+		WARN(1, "omap_hwmod: %s: offset struct for sysconfig not"
+					" provided in class\n", oh->name);
+		return -EINVAL;
+	}
+
+	*midlemode = ((oh->_sysc_cache) & mstandby_mask) >> mstandby_shift;
+
+	return 0;
+}
+
+/**
  * _set_slave_idlemode: set the OCP_SYSCONFIG SIDLEMODE field in @v
  * @oh: struct omap_hwmod *
  * @idlemode: SIDLEMODE field bits
@@ -1427,6 +1456,60 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
 }
 
 /**
+ * omap_hwmod_set_master_standbymode - set the hwmod's OCP master idlemode
+ * @oh: struct omap_hwmod *
+ * @midlemode: MIDLEMODE field bits (shifted to bit 0)
+ *
+ * Sets the IP block's OCP master idlemode in hardware, and updates our
+ * local copy.  Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the MIDLEMODE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_master_standbymode().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u32 midlemode)
+{
+	u32 v;
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	v = oh->_sysc_cache;
+
+	retval = _set_master_standbymode(oh, midlemode, &v);
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+}
+
+/**
+ * omap_hwmod_get_master_idlemode - set the hwmod's OCP master idlemode
+ * @oh: struct omap_hwmod *
+ * @midlemode: pointer to get MIDLEMODE field bits (shifted to bit 0)
+ *
+ * Gets the IP block's OCP master idlemode from our local copy. Intended
+ * to be used by drivers that have some erratum that requires direct
+ * manipulation of the MIDLEMODE bits. Returns -EINVAL if @oh is null,
+ * or passes along the return value from _get_master_standbymode().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_get_master_standbymode(struct omap_hwmod *oh, u32 *midlemode)
+{
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	retval = _get_master_standbymode(oh, midlemode);
+
+	return retval;
+}
+
+/**
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 28e2d1a..1a4e1ee 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -109,13 +109,14 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
 
 /* Other */
-
 int omap_device_idle_hwmods(struct omap_device *od);
 int omap_device_enable_hwmods(struct omap_device *od);
 
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+int omap_device_mstandby(struct platform_device *pdev, u32 *midlemode,
+						bool set_mstandby);
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7eaa8ed..ae0ca6b 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -526,6 +526,9 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
 
+int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u32 midlemode);
+int omap_hwmod_get_master_standbymode(struct omap_hwmod *oh, u32 *idlemode);
+
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index abe933c..cd1c92a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -584,6 +584,42 @@ int omap_device_idle(struct platform_device *pdev)
 }
 
 /**
+ * omap_device_mstandby - set/get mstandby mode an omap_device
+ * @od: struct omap_device * to idle
+ * @midlemode: MIDLEMODE field bits (shifted to bit 0)
+ * @set_mstandby: flag for mstandby get/set
+ *
+ * Sets/Gets the IP block's OCP master standby in hardware. Intended
+ * to be used by drivers that have some erratum that requires direct
+ * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
+ * omap_device is not currently enabled or passes along the return value
+ * of omap_hwmod_set_master_standbymode()/omap_hwmod_get_master_standbymode().
+ */
+int omap_device_mstandby(struct platform_device *pdev, u32 *midlemode,
+						bool set_mstandby)
+{
+	int ret  = 0, i;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+
+	od = _find_by_pdev(pdev);
+	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		return -EINVAL;
+	}
+
+	oh = *od->hwmods;
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		if (set_mstandby)
+			ret = omap_hwmod_set_master_standbymode(oh, *midlemode);
+		else
+			ret = omap_hwmod_get_master_standbymode(oh, midlemode);
+	}
+	return ret;
+}
+
+/**
  * omap_device_shutdown - shut down an omap_device
  * @od: struct omap_device * to shut down
  *
-- 
1.7.1

