From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP: PM noop: implement context loss count for
 non-omap_devices
Date: Tue, 21 Dec 2010 22:38:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012212235530.1446@utopia.booyaka.com>
References: <1292634855-14728-1-git-send-email-khilman@deeprootsystems.com> <1292634855-14728-3-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.1012212136210.1446@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32786 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0LVFiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 00:38:14 -0500
In-Reply-To: <alpine.DEB.2.00.1012212136210.1446@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 21 Dec 2010, Paul Walmsley wrote:

> On Fri, 17 Dec 2010, Kevin Hilman wrote:
> 
> > For devices which have not (yet) been converted to use omap_device,
> > implement the context loss counter using the "brutal method" as
> > originally proposed by Paul Walmsley[1].
> > 
> > The dummy context loss counter is incremented every time it is
> > checked, but only when off-mode is enabled.  When off-mode is
> > disabled, the dummy counter stops incrementing.
> > 
> > Tested on 36xx/Zoom3 using MMC driver, which is currently the
> > only in-tree user of this API.
> > 
> > This patch should be reverted after all devices are converted to using
> > omap_device.
> 
> just FYI this patch generated a compile warning:
> 
> arch/arm/plat-omap/omap-pm-noop.c: In function 'omap_pm_get_dev_context_loss_count':
> arch/arm/plat-omap/omap-pm-noop.c:322: warning: too many arguments for format
> 
> Updated to fix that; here's the version that I merged.

Also, the patch doesn't compile on OMAP1.  Here's the fixed version.

The integration tag that contains this patch is 
'integration-2.6.38-20101221-015'


- Paul

From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Tue, 21 Dec 2010 21:31:55 -0700
Subject: [PATCH] OMAP: PM noop: implement context loss count for non-omap_devices

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

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[paul@pwsan.com: fixed compile warning; fixed to compile on OMAP1]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm-debug.c            |    5 +++
 arch/arm/plat-omap/include/plat/omap-pm.h |    2 +
 arch/arm/plat-omap/omap-pm-noop.c         |   46 ++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletions(-)

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
index c07bb44..c0a7520 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -354,5 +354,7 @@ unsigned long omap_pm_cpu_get_freq(void);
  */
 u32 omap_pm_get_dev_context_loss_count(struct device *dev);
 
+void omap_pm_enable_off_mode(void);
+void omap_pm_disable_off_mode(void);
 
 #endif
diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
index af58dad..b0471bb2 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -26,6 +26,9 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
+static bool off_mode_enabled;
+static u32 dummy_context_loss_counter;
+
 /*
  * Device-driver-originated constraints (via board-*.c files)
  */
@@ -280,10 +283,34 @@ unsigned long omap_pm_cpu_get_freq(void)
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
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+
 u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -292,13 +319,30 @@ u32 omap_pm_get_dev_context_loss_count(struct device *dev)
 	if (WARN_ON(!dev))
 		return 0;
 
-	count = omap_device_get_context_loss_count(pdev);
+	if (dev->parent == &omap_device_parent) {
+		count = omap_device_get_context_loss_count(pdev);
+	} else {
+		WARN_ONCE(off_mode_enabled, "omap_pm: using dummy context loss counter; device %s should be converted to omap_device",
+			  dev_name(dev));
+		if (off_mode_enabled)
+			dummy_context_loss_counter++;
+		count = dummy_context_loss_counter;
+	}
+
 	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
 		 dev_name(dev), count);
 
 	return count;
 }
 
+#else
+
+u32 omap_pm_get_dev_context_loss_count(struct device *dev)
+{
+	return dummy_context_loss_counter;
+}
+
+#endif
 
 /* Should be called before clk framework init */
 int __init omap_pm_if_early_init(void)
-- 
1.7.2.3

