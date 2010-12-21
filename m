From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 1/2] OMAP: hwmod: API to handle autoidle mode
Date: Tue, 21 Dec 2010 12:42:39 +0530
Message-ID: <1292915560-13601-2-git-send-email-kishon@ti.com>
References: <1292915560-13601-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42034 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab0LUHOP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:14:15 -0500
In-Reply-To: <1292915560-13601-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

Create a new API that forms a wrapper to _set_module_autoidle()
to modify the AUTOIDLE bit.

This API is intended to be used by drivers that requires direct
manipulation of the AUTOIDLE bits in SYSCONFIG register.
McBSP driver requires autoidle bit to be enabled/disabled while
using sidetone feature.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   35 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a30658..e016cd9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1251,6 +1251,41 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_set_slave_autoidle - set the hwmod's OCP slave autoidle
+ * @oh: struct omap_hwmod *
+ * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
+ *
+ * Sets the IP block's OCP slave autoidle in hardware, and updates our
+ * local copy. Intended to be used by drivers that requires
+ * direct manipulation of the AUTOIDLE bits.
+ * Returns -EINVAL if @oh is null, or passes along the return value
+ * from _set_module_autoidle().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_slave_autoidle(struct omap_hwmod *oh, u8 autoidle)
+{
+	u32 v;
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&omap_hwmod_mutex);
+
+	v = oh->_sysc_cache;
+
+	retval = _set_module_autoidle(oh, autoidle, &v);
+
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	mutex_unlock(&omap_hwmod_mutex);
+
+	return retval;
+}
+
+/**
  * _shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7eaa8ed..1871b5a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -525,6 +525,7 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
+int omap_hwmod_set_slave_autoidle(struct omap_hwmod *oh, u8 autoidle);
 
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
-- 
1.7.0.4

