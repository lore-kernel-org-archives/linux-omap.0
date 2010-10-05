From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/7] [RFC] OMAP: hwmod: New API to modify the autoidle bit of sysconfig register
Date: Tue,  5 Oct 2010 22:07:40 +0530
Message-ID: <1286296662-7639-5-git-send-email-kishon@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45677 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab0JEQkG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 12:40:06 -0400
In-Reply-To: <1286296662-7639-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nskamat@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Partha Basak <p-basak2@ti.com>

This patch was already posted in lo as RFC. But since no conclusion was
drawn, I'm again posting this patch.

The previous patch and discussion can be found at
https://patchwork.kernel.org/patch/134371/

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Partha Basak <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   29 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 955861a..631286b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1250,6 +1250,35 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
 	return 0;
 }
 
+/*
+ * omap_hwmod_set_module_autoidle - set the hwmod's OCP slave autoidle
+ * @oh: struct omap_hwmod *
+ * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
+ *
+ * Sets the IP block's OCP slave autoidle in hardware, and updates our
+ * local copy. Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the AUTOIDLE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_module_autoidle().
+ */
+int omap_hwmod_set_module_autoidle(struct omap_hwmod *oh, u8 autoidle)
+{
+	u32 v;
+	int retval = 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	v = oh->_sysc_cache;
+
+	retval = _set_module_autoidle(oh, autoidle, &v);
+
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	return retval;
+}
+
 /**
  * _shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index c1835af..0d31317 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -523,6 +523,7 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
+int omap_hwmod_set_module_autoidle(struct omap_hwmod *oh, u8 autoidle);
 
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
-- 
1.7.0.4

