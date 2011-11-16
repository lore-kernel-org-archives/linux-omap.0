From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] ARM: omap_device: handle first time activation of console device
Date: Wed, 16 Nov 2011 16:32:24 +0530
Message-ID: <1321441346-19591-2-git-send-email-rnayak@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321441346-19591-1-git-send-email-rnayak@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

console device on OMAP is never reset or idled by hwmod post
initial setup, early during boot, for obvious reasons not to
break early debug prints thrown on console.
This leaves the console device enabled at boot and the first activation
of it using hwmod needs to be handled in such a way that a disable is
called followed by an enable of the hwmod, the subsequent activations
can then use the default activation technique.

To handle this add a new binding to identify a hwmod which is used as
the console device.

This patch is based on the what is done in serial.c for non-DT builds.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    1 +
 arch/arm/plat-omap/omap_device.c                   |   33 +++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index dbdab40..46ffd41 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -21,6 +21,7 @@ Required properties:
 Optional properties:
 - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
   during suspend.
+- ti,console_hwmod: boolean, identifies the hwmod used as console device
 
 
 Example:
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index e8d9869..2b2d068 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -88,6 +88,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/console.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -114,6 +115,32 @@ static struct omap_device_pm_latency omap_default_latency[] = {
 	}
 };
 
+static int omap_console_hwmod_enable(struct omap_device *od)
+{
+	console_lock();
+	/*
+	 * For early console we prevented hwmod reset and idle
+	 * So before we enable the uart clocks idle the console
+	 * uart clocks, then enable back the console uart hwmod.
+	 */
+	omap_hwmod_idle(od->hwmods[0]);
+	omap_hwmod_enable(od->hwmods[0]);
+	console_unlock();
+	/*
+	 * Restore the default activate/deactivate funcs,
+	 * since now we have set the hwmod state machine right
+	 * with the idle/enable for console uart
+	 */
+	od->pm_lats = omap_default_latency;
+	return 0;
+}
+
+static struct omap_device_pm_latency omap_console_latency[] = {
+	{
+		.activate_func	 = omap_console_hwmod_enable,
+	},
+};
+
 /* Private functions */
 
 /**
@@ -342,6 +369,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	struct omap_hwmod **hwmods;
 	struct omap_device *od;
 	struct omap_hwmod *oh;
+	struct omap_device_pm_latency *pm_lat = NULL;
 	struct device_node *node = pdev->dev.of_node;
 	const char *oh_name;
 	int oh_cnt, i, ret = 0;
@@ -370,7 +398,10 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 		hwmods[i] = oh;
 	}
 
-	od = omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);
+	if (of_find_property(node, "ti,console_hwmod", NULL))
+		pm_lat = omap_console_latency;
+
+	od = omap_device_alloc(pdev, hwmods, oh_cnt, pm_lat, 0);
 	if (!od) {
 		dev_err(&pdev->dev, "Cannot allocate omap_device for :%s\n",
 			oh_name);
-- 
1.7.1

