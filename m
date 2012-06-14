From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 02/10] ARM: OMAP2+: hwmod: manage the wake-up latency constraints
Date: Thu, 14 Jun 2012 17:05:53 +0200
Message-ID: <1339686361-11526-3-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60855 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab2FNPGQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:06:16 -0400
Received: by weyu7 with SMTP id u7so1326955wey.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 08:06:14 -0700 (PDT)
In-Reply-To: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

The OMAP PM code implements a handler for the per-device PM QoS framework.
The handler queries the omap_hwmod layer in order to manage the power domains
wake-up latency constraints. Hwmod retrieves the correct power domain
and if it exists it calls the corresponding power domain function.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: cleaned some documentation; split set/remove constraint
 functions; modified to return -EINVAL until underlying code is ready]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   54 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 ++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bf86f7e..cc173d9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -145,6 +145,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -3301,10 +3302,61 @@ ohsps_unlock:
 }
 
 /**
+ * omap_hwmod_set_wakeuplat_constraint - set/release a wake-up latency
+ * constraint
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ * @min_latency: the minimum allowed wake-up latency for @oh.
+ *
+ * Sets a wakeup latency contraint.  (To remove a wakeup latency
+ * constraint, call omap_hwmod_remove_wakeuplat_constraint()).
+ * Returns the return value from pwrdm_wakeuplat_remove_constraint(),
+ * or -EINVAL in case of invalid parameters.
+ */
+int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
+					long min_latency)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * XXX Update to use pwrdm_wakeuplat_update_constraint() when
+	 * that code is ready
+	 */
+	return -EINVAL;
+}
+
+/**
+ * omap_hwmod_remove_wakeuplat_constraint - release a wake-up latency
+ * constraint
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ *
+ * Removes a wakeup latency contraint.  Returns the return value from
+ * pwrdm_wakeuplat_update_constraint(), or -EINVAL in case of invalid
+ * parameters.
+ */
+int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	/*
+	 * XXX Update to use pwrdm_wakeuplat_remove_constraint() when
+	 * that code is ready
+	 */
+	return -EINVAL;
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
index c835b71..3aa10df 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -623,6 +623,11 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+
+int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
+					long min_latency);
+int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie);
+
 int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
-- 
1.7.7.6

