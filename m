From: jean.pihet@newoldbits.com
Subject: [PATCH 2/6] OMAP2+: omap_hwmod: manage the wake-up latency constraints
Date: Wed, 19 Oct 2011 15:50:59 +0200
Message-ID: <1319032263-22699-3-git-send-email-j-pihet@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33300 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab1JSNv1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 09:51:27 -0400
Received: by mail-wy0-f174.google.com with SMTP id 36so1742510wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Oct 2011 06:51:26 -0700 (PDT)
In-Reply-To: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Hwmod is queried from the OMAP_PM layer to manage the power domains
wake-up latency constraints. Hwmod retrieves the correct power domain
and if it exists it calls the corresponding power domain function.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   27 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..023f3e7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -143,6 +143,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2619,10 +2620,34 @@ ohsps_unlock:
 }
 
 /**
+ * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
+ *
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ * @min_latency: the minimum allowed wake-up latency for @oh.
+ *
+ * Returns 0 upon success, -EINVAL in case of invalid parameters, or
+ * the return value from pwrdm_set_wkup_lat_constraint.
+ */
+int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
+				       void *cookie, long min_latency)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm) {
+		pr_err("%s: Error: could not find powerdomain "
+		       "for %s\n", __func__, oh->name);
+		return -EINVAL;
+	}
+
+	return pwrdm_set_wkup_lat_constraint(pwrdm, cookie, min_latency);
+}
+
+/**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
+ * Query the powerdomain of @oh to get the context loss
  * count for this device.
  *
  * Returns the context loss count of the powerdomain assocated with @oh
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0e329ca..75e0e7a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -603,6 +603,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh, void *cookie,
+				       long min_latency);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
-- 
1.7.4.1

