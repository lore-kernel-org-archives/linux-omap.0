From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v5] OMAP2+: PM: omap device: API's for handling mstandby mode
Date: Wed, 24 Nov 2010 16:24:11 +0530
Message-ID: <1290596051-12989-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49074 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab0KXKxj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 05:53:39 -0500
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
standby=CB=9D depending on HWMOD_SWSUP_MSTANDBY value.

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
Change summary:
v3: Review comments incorporated for:
https://patchwork.kernel.org/patch/282212/
v4: added mutex changes
v5: typo fixes for errata and erratum

 arch/arm/mach-omap2/omap_hwmod.c              |   43 ++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
 arch/arm/plat-omap/omap_device.c              |   64 +++++++++++++++++=
++++++++
 4 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 5a30658..de78441 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1427,6 +1427,48 @@ int omap_hwmod_set_slave_idlemode(struct omap_hw=
mod *oh, u8 idlemode)
 }
=20
 /**
+ * omap_hwmod_set_master_standbymode - set the hwmod's OCP mstandby mo=
de
+ * @oh: struct omap_hwmod *
+ * @midlemode: flag to set mstandby to either "no standby" or "smart s=
tandby"
+ *
+ * Sets the IP block's OCP mstandby mode in hardware, and updates our
+ * local copy.  Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the MIDLEMODE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_master_standbymode().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemo=
de)
+{
+	u32 v;
+	u8 sf;
+	int retval =3D 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	if (!oh->class->sysc)
+		return -EINVAL;
+
+	v =3D oh->_sysc_cache;
+	sf =3D oh->class->sysc->sysc_flags;
+
+	if (sf & SYSC_HAS_MIDLEMODE) {
+		if (idlemode)
+			idlemode =3D HWMOD_IDLEMODE_NO;
+		else
+			idlemode =3D (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
+				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+	}
+	retval =3D _set_master_standbymode(oh, idlemode, &v);
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+}
+
+/**
  * omap_hwmod_register - register a struct omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2116,4 +2158,3 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
=20
 	return ret;
 }
-
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/p=
lat-omap/include/plat/omap_device.h
index 28e2d1a..4fbf7c1 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,6 +116,8 @@ int omap_device_enable_hwmods(struct omap_device *o=
d);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
=20
+int omap_device_require_no_mstandby(struct platform_device *pdev);
+int omap_device_release_no_mstandby(struct platform_device *pdev);
=20
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 7eaa8ed..c7ff65a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -354,7 +354,7 @@ struct omap_hwmod_omap4_prcm {
  *
  * HWMOD_SWSUP_SIDLE: omap_hwmod code should manually bring module in =
and out
  *     of idle, rather than relying on module smart-idle
- * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module in=
 and out
+ * HWMOD_SWSUP_MSTANDBY: omap_hwmod code should manually bring module =
in and out
  *     of standby, rather than relying on module smart-standby
  * HWMOD_INIT_NO_RESET: don't reset this module at boot - important fo=
r
  *     SDRAM controller, etc.
@@ -526,6 +526,8 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *oh=
);
=20
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
=20
+int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemo=
de);
+
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
=20
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index abe933c..fa99551 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -584,6 +584,70 @@ int omap_device_idle(struct platform_device *pdev)
 }
=20
 /**
+ * omap_device_require_no_mstandby - set no mstandby mode of an omap_d=
evice
+ * @od: struct omap_device * to idle
+ *
+ * Sets the IP block's OCP master standby to no mstandby mode in hardw=
are.
+ *
+ * Intended to be used by drivers that have some erratum that requires=
 direct
+ * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
+ * omap_device is not currently enabled or passes along the return val=
ue
+ * of omap_hwmod_set_master_standbymode().
+ */
+int omap_device_require_no_mstandby(struct platform_device *pdev)
+{
+	int ret  =3D 0, i;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+
+	od =3D _find_by_pdev(pdev);
+	if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		return -EINVAL;
+	}
+
+	oh =3D *od->hwmods;
+	for (i =3D 0; i < od->hwmods_cnt; i++)
+		ret =3D omap_hwmod_set_master_standbymode(oh, true);
+
+	return ret;
+}
+
+/**
+ * omap_device_release_no_mstandby - releases no mstandby mode of an o=
map_device
+ * @od: struct omap_device * to idle
+ *
+ * Release no mstandby mode and sets the master standby to either no s=
tandby or
+ * smart standby in IP block's OCP in hardware depending on status of =
the flag
+ * HWMOD_SWSUP_MSTANDBY.
+ *
+ * Intended to be used by drivers that have some erratum that requires=
 direct
+ * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
+ * omap_device is not currently enabled or passes along the return val=
ue
+ * of omap_hwmod_set_master_standbymode().
+ */
+int omap_device_release_no_mstandby(struct platform_device *pdev)
+{
+	int ret  =3D 0, i;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+
+	od =3D _find_by_pdev(pdev);
+	if (od->_state !=3D OMAP_DEVICE_STATE_ENABLED) {
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		return -EINVAL;
+	}
+
+	oh =3D *od->hwmods;
+	for (i =3D 0; i < od->hwmods_cnt; i++)
+		ret =3D omap_hwmod_set_master_standbymode(oh, false);
+
+	return ret;
+}
+
+/**
  * omap_device_shutdown - shut down an omap_device
  * @od: struct omap_device * to shut down
  *
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
