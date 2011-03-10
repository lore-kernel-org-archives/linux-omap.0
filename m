From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 5/7] OMAP: PM CONSTRAINTS: add a power domains state update function in hwmod
Date: Thu, 10 Mar 2011 18:47:25 +0100
Message-ID: <1299779247-20511-6-git-send-email-j-pihet@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55430 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1CJRru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:50 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so1681959wya.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:49 -0800 (PST)
In-Reply-To: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

Hwmod is queried from the omap device layer to change the power domains
next power state. Hwmod retrieves the correct power domain and if it
exists it calls the corresponding power domain function.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   29 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cf8cc9b..8caf2c5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -142,6 +142,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2277,11 +2278,37 @@ ohsps_unlock:
 	return ret;
 }
 
+/*
+ * omap_hwmod_update_power_state - Update the power domain power state of
+ * @oh
+ *
+ * @oh: struct omap_hwmod* to which the requesting device belongs to.
+ * @min_latency: the allowed wake-up latency for the power domain of @oh.
+ *
+ * Finds the power domain next power state that fulfills the constraint.
+ * Applies the constraint to the power domain by calling
+ * pwrdm_wakeuplat_update_pwrst.
+ *
+ * Returns 0 upon success.
+ */
+int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_latency)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!PTR_ERR(pwrdm)) {
+		pr_err("omap_hwmod: Error: could not find parent "
+			"powerdomain for %s\n", oh->name);
+		return -EINVAL;
+	}
+
+	return pwrdm_wakeuplat_update_pwrst(pwrdm, min_latency);
+}
+
 /**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
+ * Query the powerdomain of @oh to get the context loss
  * count for this device.
  *
  * Returns the context loss count of the powerdomain assocated with @oh
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 65bcad4..f27110e 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -597,6 +597,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_latency);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 /*
-- 
1.7.2.3

