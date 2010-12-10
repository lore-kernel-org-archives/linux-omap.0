From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 3/2] OMAP: PM noop: implement context loss count for non-omap_devices
Date: Thu,  9 Dec 2010 17:32:49 -0800
Message-ID: <1291944769-457-1-git-send-email-khilman@deeprootsystems.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42331 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab0LJBdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 20:33:11 -0500
Received: by gwb20 with SMTP id 20so2617159gwb.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 17:33:10 -0800 (PST)
In-Reply-To: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

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
 arch/arm/mach-omap2/pm-debug.c            |    2 ++
 arch/arm/plat-omap/include/plat/omap-pm.h |    1 +
 arch/arm/plat-omap/omap-pm-noop.c         |   19 ++++++++++++++++++-
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index e535082..af66acb 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -32,6 +32,7 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include <plat/dmtimer.h>
+#include <plat/omap-pm.h>
 
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
@@ -581,6 +582,7 @@ static int option_set(void *data, u64 val)
 	*option = val;
 
 	if (option == &enable_off_mode) {
+		omap_pm_enable_off_mode(val ? true : false);
 		if (cpu_is_omap34xx())
 			omap3_pm_off_mode_enable(val);
 	}
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 9870b4f..cfa5e44 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -372,5 +372,6 @@ unsigned long omap_pm_cpu_get_freq(void);
  */
 int omap_pm_get_dev_context_loss_count(struct device *dev);
 
+void omap_pm_enable_off_mode(bool enable);
 
 #endif
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index 5a58f97..32f2818 100644
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
@@ -287,6 +290,10 @@ unsigned long omap_pm_cpu_get_freq(void)
 /*
  * Device context loss tracking
  */
+void omap_pm_enable_off_mode(bool enable)
+{
+	off_mode_enabled = enable;
+}
 
 int omap_pm_get_dev_context_loss_count(struct device *dev)
 {
@@ -298,7 +305,17 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
 		return -EINVAL;
 	};
 
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

