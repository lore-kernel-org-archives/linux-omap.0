From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/8] OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling
Date: Tue, 17 Nov 2009 17:05:08 -0800
Message-ID: <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61295 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbZKRBFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:21 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so614173yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:27 -0800 (PST)
In-Reply-To: <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

This patch fills in the OCP_SYSCONFIG.AUTOIDLE handling in the OMAP
hwmod code.

After this patch, the hwmod code will set the module AUTOIDLE bit (generally
<module>.OCP_SYSCONFIG.AUTOIDLE) to 1 by default upon enable, and 1 upon
disable.  If the hwmod flag HWMOD_NO_AUTOIDLE is set, AUTOIDLE will be
set to 0 upon enable.

Enabling module autoidle should save some power.  The only reason to
not set the OCP_SYSCONFIG.AUTOIDLE bit is if there is a bug in the
module RTL, e.g., the MPUINTC block on OMAP3.

Comments from Kevin Hilman <khilman@deeprootsystems.com> inspired this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   50 +++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 ++++-
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7d7b3b8..25d9484 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -210,6 +210,29 @@ static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 }
 
 /**
+ * _set_module_autoidle: set the OCP_SYSCONFIG AUTOIDLE field in @v
+ * @oh: struct omap_hwmod *
+ * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
+ * @v: pointer to register contents to modify
+ *
+ * Update the module autoidle mode bit in @v to be @autoidle for the
+ * @oh hwmod.  Does not write to the hardware.  Returns -EINVAL upon
+ * error or 0 upon success.
+ */
+static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
+				u32 *v)
+{
+	if (!oh->sysconfig ||
+	    !(oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE))
+		return -EINVAL;
+
+	*v &= ~SYSC_AUTOIDLE_MASK;
+	*v |= autoidle << SYSC_AUTOIDLE_SHIFT;
+
+	return 0;
+}
+
+/**
  * _enable_wakeup: set OCP_SYSCONFIG.ENAWAKEUP bit in the hardware
  * @oh: struct omap_hwmod *
  *
@@ -560,7 +583,13 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	/* XXX OCP AUTOIDLE bit? */
+	if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE) {
+		idlemode = (oh->flags & HWMOD_NO_AUTOIDLE) ?
+			0 : 1;
+		_set_module_autoidle(oh, idlemode, &v);
+	}
+
+	/* XXX OCP ENAWAKEUP bit? */
 
 	if (oh->flags & HWMOD_SET_DEFAULT_CLOCKACT &&
 	    oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY)
@@ -625,7 +654,8 @@ static void _sysc_shutdown(struct omap_hwmod *oh)
 	if (oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE)
 		_set_master_standbymode(oh, HWMOD_IDLEMODE_FORCE, &v);
 
-	/* XXX clear OCP AUTOIDLE bit? */
+	if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE)
+		_set_module_autoidle(oh, 1, &v);
 
 	_write_sysconfig(v, oh);
 }
@@ -951,11 +981,21 @@ static int _setup(struct omap_hwmod *oh)
 
 	_enable(oh);
 
-	if (!(oh->flags & HWMOD_INIT_NO_RESET))
+	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
 		_reset(oh);
 
-	/* XXX OCP AUTOIDLE bit? */
-	/* XXX OCP ENAWAKEUP bit? */
+		/*
+		 * XXX Do the OCP_SYSCONFIG bits need to be
+		 * reprogrammed after a reset?  If not, then this can
+		 * be removed.  If it does, then probably the
+		 * _enable() function should be split to avoid the
+		 * rewrite of the OCP_SYSCONFIG register.
+		 */
+		if (oh->sysconfig) {
+			_update_sysc_cache(oh);
+			_sysc_enable(oh);
+		}
+	}
 
 	if (!(oh->flags & HWMOD_INIT_NO_IDLE))
 		_idle(oh);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index dbdd123..ec140b0 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -50,6 +50,8 @@ struct omap_device;
 #define SYSC_ENAWAKEUP_MASK		(1 << SYSC_ENAWAKEUP_SHIFT)
 #define SYSC_SOFTRESET_SHIFT		1
 #define SYSC_SOFTRESET_MASK		(1 << SYSC_SOFTRESET_SHIFT)
+#define SYSC_AUTOIDLE_SHIFT		0
+#define SYSC_AUTOIDLE_MASK		(1 << SYSC_AUTOIDLE_SHIFT)
 
 /* OCP SYSSTATUS bit shifts/masks */
 #define SYSS_RESETDONE_SHIFT		0
@@ -294,13 +296,17 @@ struct omap_hwmod_omap4_prcm {
  *     SDRAM controller, etc.
  * HWMOD_INIT_NO_IDLE: don't idle this module at boot - important for SDRAM
  *     controller, etc.
+ * HWMOD_NO_AUTOIDLE: disable module autoidle (OCP_SYSCONFIG.AUTOIDLE)
+ *     when module is enabled, rather than the default, which is to
+ *     enable autoidle
  * HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startup
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
 #define HWMOD_INIT_NO_RESET			(1 << 2)
 #define HWMOD_INIT_NO_IDLE			(1 << 3)
-#define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 4)
+#define HWMOD_NO_AUTOIDLE			(1 << 4)
+#define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
1.6.5.1

