From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/10] OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE
	handling
Date: Thu, 03 Dec 2009 06:49:43 -0700
Message-ID: <20091203134941.17146.9931.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49043 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157AbZLCNyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:54:36 -0500
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

This patch fills in the OCP_SYSCONFIG.AUTOIDLE handling in the OMAP
hwmod code.

After this patch, the hwmod code will set the module AUTOIDLE bit
(generally <module>.OCP_SYSCONFIG.AUTOIDLE) to 1 by default upon
enable.  If the hwmod flag HWMOD_NO_OCP_AUTOIDLE is set, AUTOIDLE will
be set to 0 upon enable.  Upon module disable, AUTOIDLE will be set to
1.

Enabling module autoidle should save some power.  The only reason to
not set the OCP_SYSCONFIG.AUTOIDLE bit is if there is a bug in the
module RTL, e.g., the MPUINTC block on OMAP3.

Comments from Kevin Hilman <khilman@deeprootsystems.com> inspired this patch,
and Kevin tested an earlier version of this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   37 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4aab1b8..709ec5d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -210,6 +210,32 @@ static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 }
 
 /**
+ * _set_module_autoidle: set the OCP_SYSCONFIG AUTOIDLE field in @v
+ * @oh: struct omap_hwmod *
+ * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
+ * @v: pointer to register contents to modify
+ *
+ * Update the module autoidle bit in @v to be @autoidle for the @oh
+ * hwmod.  The autoidle bit controls whether the module can gate
+ * internal clocks automatically when it isn't doing anything; the
+ * exact function of this bit varies on a per-module basis.  This
+ * function does not write to the hardware.  Returns -EINVAL upon
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
@@ -557,7 +583,13 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	/* XXX OCP AUTOIDLE bit? */
+	if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE) {
+		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
+			0 : 1;
+		_set_module_autoidle(oh, idlemode, &v);
+	}
+
+	/* XXX OCP ENAWAKEUP bit? */
 
 	if (oh->flags & HWMOD_SET_DEFAULT_CLOCKACT &&
 	    oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY)
@@ -622,7 +654,8 @@ static void _sysc_shutdown(struct omap_hwmod *oh)
 	if (oh->sysconfig->sysc_flags & SYSC_HAS_MIDLEMODE)
 		_set_master_standbymode(oh, HWMOD_IDLEMODE_FORCE, &v);
 
-	/* XXX clear OCP AUTOIDLE bit? */
+	if (oh->sysconfig->sysc_flags & SYSC_HAS_AUTOIDLE)
+		_set_module_autoidle(oh, 1, &v);
 
 	_write_sysconfig(v, oh);
 }
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index dbdd123..643a972 100644
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
+#define HWMOD_NO_OCP_AUTOIDLE			(1 << 4)
+#define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
 
 /*
  * omap_hwmod._int_flags definitions


