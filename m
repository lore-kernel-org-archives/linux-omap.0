From: jean.pihet@newoldbits.com
Subject: [PATCH 2/6] ARM: OMAP2+: PM QoS: manage the per-device latency constraints in hwmod
Date: Wed, 18 Apr 2012 15:45:16 +0200
Message-ID: <1334756720-29166-3-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59177 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2DRNps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:48 -0400
Received: by wejx9 with SMTP id x9so4728703wej.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:47 -0700 (PDT)
In-Reply-To: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Call the per-device PM QoS functions of the power domain code from the
hwmod layer, in order to apply the constraints requested to a device.

While at it, correct the functions kerneldoc.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index aefd2ee..9485eb1 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3020,15 +3020,13 @@ ohsps_unlock:
 }
 
 /**
- * omap_hwmod_set_wakeuplat_constraint - set/release a wake-up latency
+ * omap_hwmod_set_wakeuplat_constraint - Set or update a wake-up latency
  * constraint
  * @oh: struct omap_hwmod* to which the target device belongs to.
  * @cookie: identifier of the constraints list for @oh.
  * @min_latency: the minimum allowed wake-up latency for @oh.
  *
- * Sets a wakeup latency contraint.  (To remove a wakeup latency
- * constraint, call omap_hwmod_remove_wakeuplat_constraint()).
- * Returns the return value from pwrdm_wakeuplat_remove_constraint(),
+ * Returns the return value from pwrdm_wakeuplat_update_constraint(),
  * or -EINVAL in case of invalid parameters.
  */
 int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
@@ -3039,21 +3037,17 @@ int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * XXX Update to use pwrdm_wakeuplat_update_constraint() when
-	 * that code is ready
-	 */
-	return -EINVAL;
+	return pwrdm_wakeuplat_update_constraint(pwrdm, cookie, min_latency);
 }
 
 /**
- * omap_hwmod_remove_wakeuplat_constraint - release a wake-up latency
+ * omap_hwmod_remove_wakeuplat_constraint - Release a wake-up latency
  * constraint
  * @oh: struct omap_hwmod* to which the target device belongs to.
  * @cookie: identifier of the constraints list for @oh.
  *
  * Removes a wakeup latency contraint.  Returns the return value from
- * pwrdm_wakeuplat_update_constraint(), or -EINVAL in case of invalid
+ * pwrdm_wakeuplat_remove_constraint(), or -EINVAL in case of invalid
  * parameters.
  */
 int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
@@ -3063,11 +3057,7 @@ int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * XXX Update to use pwrdm_wakeuplat_remove_constraint() when
-	 * that code is ready
-	 */
-	return -EINVAL;
+	return pwrdm_wakeuplat_remove_constraint(pwrdm, cookie);
 }
 
 /**
-- 
1.7.7.6

