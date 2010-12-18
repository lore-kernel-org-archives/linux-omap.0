From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/3] OMAP: PM noop: implement context loss count for non-omap_devices
Date: Fri, 17 Dec 2010 17:14:15 -0800
Message-ID: <1292634855-14728-3-git-send-email-khilman@deeprootsystems.com>
References: <1292634855-14728-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62654 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381Ab0LRBOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:14:24 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so204020pva.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 17:14:24 -0800 (PST)
In-Reply-To: <1292634855-14728-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

For devices which have not (yet) been converted to use omap_device,
implement the context loss counter using the "brutal method" as
originally proposed by Paul Walmsley[1].

The dummy context loss counter is incremented every time it is
checked, but only when off-mode is enabled.  When off-mode is
disabled, the dummy counter stops incrementing.

Tested on 36xx/Zoom3 using MMC driver, which is currently the
only in-tree user of this API.

This patch should be reverted after all devices are converted to using
omap_device.

[1] http://marc.info/?l=linux-omap&m=129176260000626&w=2

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c            |    5 ++++
 arch/arm/plat-omap/include/plat/omap-pm.h |    2 +
 arch/arm/plat-omap/omap-pm-noop.c         |   38 +++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e535082..125f565 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -32,6 +32,7 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/dmtimer.h>
+#include <plat/omap-pm.h>
 
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
@@ -581,6 +582,10 @@ static int option_set(void *data, u64 val)
 	*option = val;
 
 	if (option == &enable_off_mode) {
+		if (val)
+			omap_pm_enable_off_mode();
+		else
+			omap_pm_disable_off_mode();
 		if (cpu_is_omap34xx())
 			omap3_pm_off_mode_enable(val);
 	}
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 2f0bee8..6242b25 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -372,5 +372,7 @@ unsigned long omap_pm_cpu_get_freq(void);
  */
 u32 omap_pm_get_dev_context_loss_count(struct device *dev);
 
+void omap_pm_enable_off_mode(void);
+void omap_pm_disable_off_mode(void);
 
 #endif
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index f7d1307..12b2bfe 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -30,6 +30,9 @@ struct omap_opp *dsp_opps;
 struct omap_opp *mpu_opps;
 struct omap_opp *l3_opps;
 
+static bool off_mode_enabled;
+static u32 dummy_context_loss_counter;
+
 /*
  * Device-driver-originated constraints (via board-*.c files)
  */
@@ -284,10 +287,31 @@ unsigned long omap_pm_cpu_get_freq(void)
 	return 0;
 }
 
+/**
+ * omap_pm_enable_off_mode - notify OMAP PM that off-mode is enabled
+ *
+ * Intended for use only by OMAP PM core code to notify this layer
+ * that off mode has been enabled.
+ */
+void omap_pm_enable_off_mode(void)
+{
+	off_mode_enabled = true;
+}
+
+/**
+ * omap_pm_disable_off_mode - notify OMAP PM that off-mode is disabled
+ *
+ * Intended for use only by OMAP PM core code to notify this layer
+ * that off mode has been disabled.
+ */
+void omap_pm_disable_off_mode(void)
+{
+	off_mode_enabled = false;
+}
+
 /*
  * Device context loss tracking
  */
-
 u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -296,7 +320,17 @@ u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 	if (WARN_ON(!dev))
 		return 0;
 
-	count = omap_device_get_context_loss_count(pdev);
+	if (dev->parent == &omap_device_parent) {
+		count = omap_device_get_context_loss_count(pdev);
+	} else {
+		WARN_ONCE(off_mode_enabled, "using dummy context loss counter, "
+			  "device %s should be converted to omap_device.",
+			  __func__, dev_name(dev));
+		if (off_mode_enabled)
+			dummy_context_loss_counter++;
+		count = dummy_context_loss_counter;
+	}
+
 	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
 		 dev_name(dev), count);
 
-- 
1.7.2.1

