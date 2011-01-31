From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/2] OMAP: hwmod: API to handle autoidle mode
Date: Mon, 31 Jan 2011 18:04:47 +0530
Message-ID: <1296477288-26253-2-git-send-email-kishon@ti.com>
References: <1296477288-26253-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57449 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab1AaMjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 07:39:13 -0500
In-Reply-To: <1296477288-26253-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, p-basak2@ti.com, Kishon Vijay Abraham I <kishon@ti.com>

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
 arch/arm/mach-omap2/omap_hwmod.c             |   36 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..709543a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1288,6 +1288,42 @@ static int _idle(struct omap_hwmod *oh)
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
+	unsigned int long flags;
+
+	if (!oh)
+		return -EINVAL;
+
+	spin_lock_irqsave(&oh->_lock, flags);
+
+	v = oh->_sysc_cache;
+
+	retval = _set_module_autoidle(oh, autoidle, &v);
+
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	spin_unlock_irqrestore(&oh->_lock, flags);
+
+	return retval;
+}
+
+/**
  * _shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1eee85a..76f0274 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -555,6 +555,7 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
+int omap_hwmod_set_slave_autoidle(struct omap_hwmod *oh, u8 autoidle);
 
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
-- 
1.7.0.4

