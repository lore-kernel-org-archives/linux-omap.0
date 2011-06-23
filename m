From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/6] OMAP2+: hwmod: Fix smart-standby + wakeup support
Date: Thu, 23 Jun 2011 23:00:37 +0200
Message-ID: <1308862842-3933-2-git-send-email-b-cousson@ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40562 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869Ab1FWVBF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:01:05 -0400
In-Reply-To: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Djamil Elaidi <d-elaidi@ti.com>

The commit 86009eb326afde34ffdc5648cd344aa86b8d58d4 was adding
the wakeup support for new OMAP4 IPs. This support is incomplete for
busmaster IPs that need as well to use smart-standby with wakeup.

This new standbymode is suported on HSI and USB_HOST_FS for the moment.

Add the new MSTANDBY_SMART_WKUP flag to mark the IPs that support this
capability.

Enable this new mode when applicable in _enable_wakeup, _disable_wakeup,
_enable_sysc and _idle_sysc.

The omap_hwmod_44xx_data.c will have to be updated to add this new flag.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Djamil Elaidi <d-elaidi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   34 +++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..384d3c3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -391,7 +391,8 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	if (!oh->class->sysc ||
 	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
-	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)))
+	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
+	      (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)))
 		return -EINVAL;
 
 	if (!oh->class->sysc->sysc_fields) {
@@ -405,6 +406,8 @@ static int _enable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
+	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
+		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
@@ -426,7 +429,8 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	if (!oh->class->sysc ||
 	    !((oh->class->sysc->sysc_flags & SYSC_HAS_ENAWAKEUP) ||
-	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)))
+	      (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP) ||
+	      (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)))
 		return -EINVAL;
 
 	if (!oh->class->sysc->sysc_fields) {
@@ -440,6 +444,8 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
+	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
+		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
@@ -781,8 +787,16 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	}
 
 	if (sf & SYSC_HAS_MIDLEMODE) {
-		idlemode = (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
-			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
+		if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
+			idlemode = HWMOD_IDLEMODE_NO;
+		} else {
+			if (sf & SYSC_HAS_ENAWAKEUP)
+				_enable_wakeup(oh, &v);
+			if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
+				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
+			else
+				idlemode = HWMOD_IDLEMODE_SMART;
+		}
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
@@ -840,8 +854,16 @@ static void _idle_sysc(struct omap_hwmod *oh)
 	}
 
 	if (sf & SYSC_HAS_MIDLEMODE) {
-		idlemode = (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
-			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
+		if (oh->flags & HWMOD_SWSUP_MSTANDBY) {
+			idlemode = HWMOD_IDLEMODE_FORCE;
+		} else {
+			if (sf & SYSC_HAS_ENAWAKEUP)
+				_enable_wakeup(oh, &v);
+			if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
+				idlemode = HWMOD_IDLEMODE_SMART_WKUP;
+			else
+				idlemode = HWMOD_IDLEMODE_SMART;
+		}
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..e93438c 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -77,7 +77,6 @@ extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
 #define HWMOD_IDLEMODE_FORCE		(1 << 0)
 #define HWMOD_IDLEMODE_NO		(1 << 1)
 #define HWMOD_IDLEMODE_SMART		(1 << 2)
-/* Slave idle mode flag only */
 #define HWMOD_IDLEMODE_SMART_WKUP	(1 << 3)
 
 /**
@@ -258,6 +257,7 @@ struct omap_hwmod_ocp_if {
 #define MSTANDBY_FORCE		(HWMOD_IDLEMODE_FORCE << MASTER_STANDBY_SHIFT)
 #define MSTANDBY_NO		(HWMOD_IDLEMODE_NO << MASTER_STANDBY_SHIFT)
 #define MSTANDBY_SMART		(HWMOD_IDLEMODE_SMART << MASTER_STANDBY_SHIFT)
+#define MSTANDBY_SMART_WKUP	(HWMOD_IDLEMODE_SMART_WKUP << MASTER_STANDBY_SHIFT)
 
 /* omap_hwmod_sysconfig.sysc_flags capability flags */
 #define SYSC_HAS_AUTOIDLE	(1 << 0)
-- 
1.7.0.4

