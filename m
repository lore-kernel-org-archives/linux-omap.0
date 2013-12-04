From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP2+: omap_device: add fail hook for runtime_pm when
 bad data is detected
Date: Tue, 3 Dec 2013 19:39:13 -0600
Message-ID: <1386121153-32351-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Joel F <joelf@ti.com>, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Due to the cross dependencies between hwmod for automanaged device
information for OMAP and dts node definitions, we can run into scenarios
where the dts node is defined, however it's hwmod entry is yet to be
added. In these cases:
a) omap_device does not register a pm_domain (since it cannot find
   hwmod entry).
b) driver does not know about (a), does a pm_runtime_get_sync which
   never fails
c) It then tries to do some operation on the device (such as read the
  revision register (as part of probe) without clock or adequate OMAP
  generic PM operation performed for enabling the module.

This causes a crash such as that reported in:
https://bugzilla.kernel.org/show_bug.cgi?id=66441

When 'ti,hwmod' is provided in dt node, it is expected that the device
will not function without the OMAP's power automanagement. Hence, when
we hit a fail condition (due to hwmod entries not present or other
similar scenario), fail at pm_domain level due to lack of data, provide
enough information for it to be fixed, however, it allows for the driver
to take appropriate measures to prevent crash.

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_device.h |    1 +
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 53f0735..e0a398c 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -183,6 +183,10 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 odbfd_exit1:
 	kfree(hwmods);
 odbfd_exit:
+	/* if data/we are at fault.. load up a fail handler */
+	if (ret)
+		pdev->dev.pm_domain = &omap_device_fail_pm_domain;
+
 	return ret;
 }
 
@@ -604,6 +608,19 @@ static int _od_runtime_resume(struct device *dev)
 
 	return pm_generic_runtime_resume(dev);
 }
+
+static int _od_fail_runtime_suspend(struct device *dev)
+{
+	dev_warn(dev, "%s: FIXME: missing hwmod/omap_dev info\n", __func__);
+	return -ENODEV;
+}
+
+static int _od_fail_runtime_resume(struct device *dev)
+{
+	dev_warn(dev, "%s: FIXME: missing hwmod/omap_dev info\n", __func__);
+	return -ENODEV;
+}
+
 #endif
 
 #ifdef CONFIG_SUSPEND
@@ -657,6 +674,13 @@ static int _od_resume_noirq(struct device *dev)
 #define _od_resume_noirq NULL
 #endif
 
+struct dev_pm_domain omap_device_fail_pm_domain = {
+	.ops = {
+		SET_RUNTIME_PM_OPS(_od_fail_runtime_suspend,
+				   _od_fail_runtime_resume, NULL)
+	}
+};
+
 struct dev_pm_domain omap_device_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index 17ca1ae..78c02b3 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -29,6 +29,7 @@
 #include "omap_hwmod.h"
 
 extern struct dev_pm_domain omap_device_pm_domain;
+extern struct dev_pm_domain omap_device_fail_pm_domain;
 
 /* omap_device._state values */
 #define OMAP_DEVICE_STATE_UNKNOWN	0
-- 
1.7.9.5
