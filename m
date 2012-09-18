From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/8] ARM: OMAP2+: hwmod: manage the wake-up latency constraints
Date: Tue, 18 Sep 2012 10:52:06 +0200
Message-ID: <1347958332-2205-3-git-send-email-j-pihet@ti.com>
References: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47924 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab2IRIw2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 04:52:28 -0400
Received: by wibhr14 with SMTP id hr14so3637799wib.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 01:52:27 -0700 (PDT)
In-Reply-To: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
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
---
 arch/arm/mach-omap2/omap_hwmod.c             |   44 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +++
 2 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..5990835 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -145,6 +145,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -3554,10 +3555,51 @@ ohsps_unlock:
 }
 
 /**
+ * omap_hwmod_set_wakeuplat_constraint - Set or update a wake-up latency
+ * constraint
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ * @min_latency: the minimum allowed wake-up latency for @oh.
+ *
+ * Returns the return value from pwrdm_wakeuplat_update_constraint(),
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
+	return pwrdm_wakeuplat_update_constraint(pwrdm, cookie, min_latency);
+}
+
+/**
+ * omap_hwmod_remove_wakeuplat_constraint - Release a wake-up latency
+ * constraint
+ * @oh: struct omap_hwmod* to which the target device belongs to.
+ * @cookie: identifier of the constraints list for @oh.
+ *
+ * Removes a wakeup latency contraint.  Returns the return value from
+ * pwrdm_wakeuplat_remove_constraint(), or -EINVAL in case of invalid
+ * parameters.
+ */
+int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
+{
+	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	return pwrdm_wakeuplat_remove_constraint(pwrdm, cookie);
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
index 6132972..fa0b350 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -640,6 +640,11 @@ int omap_hwmod_for_each_by_class(const char *classname,
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

