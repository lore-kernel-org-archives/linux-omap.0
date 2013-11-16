From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP2+: Add support for legacy auxdata for twl
Date: Fri, 15 Nov 2013 16:36:04 -0800
Message-ID: <1384562167-14725-3-git-send-email-tony@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384562167-14725-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

As we currently need to support a mix of legacy platform data and
device tree intialized data, let's make sure things keep working
for the TWL GPIOs.

Mostly the issue is caused by the fact that DSS does not yet have
device tree bindings, so we need to rely on the TWL GPIO callback
for setting up things like LCD backlight for some boards.

As of_platform_populate() for the TWL GPIO is called by twl-core
after the I2C bus has been initialized, we cannot pass the auxdata
table from the board init code to twl-core like we used to with
just legacy platform data.

So let's use the omap_device bus hook to patch in the platform
data for TWL GPIO until we have sorted out the issues with the
TWL GPIOs and device tree bindings.

The other option was be to initialize twl core using legacy
platform data, which seems like a step backwards as we're moving
to device tree only initialization.  And we really don't want to
add custom configuration functions to the TWL GPIO driver either
for this.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h       |  1 +
 arch/arm/mach-omap2/omap_device.c  |  2 ++
 arch/arm/mach-omap2/pdata-quirks.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index f7644fe..d0f3308 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -293,6 +293,7 @@ static inline void omap4_cpu_resume(void)
 #endif
 
 void pdata_quirks_init(struct of_device_id *);
+void omap_auxdata_legacy_init(struct device *dev);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
 
 struct omap_sdrc_params;
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 53f0735..828f538 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 
+#include "common.h"
 #include "soc.h"
 #include "omap_device.h"
 #include "omap_hwmod.h"
@@ -200,6 +201,7 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
+		omap_auxdata_legacy_init(dev);
 		/* fall through */
 	default:
 		od = to_omap_device(pdev);
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index e7e9984..f2fc072 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -27,6 +27,7 @@ struct pdata_init {
 };
 
 struct of_dev_auxdata omap_auxdata_lookup[];
+static struct twl4030_gpio_platform_data twl_gpio_auxdata;
 
 /*
  * Create alias for USB host PHY clock.
@@ -137,6 +138,21 @@ void omap_pcs_legacy_init(int irq, void (*rearm)(void))
 }
 
 /*
+ * GPIOs for TWL are initialized by the I2C bus and need custom
+ * handing until DSS has device tree bindings.
+ */
+void omap_auxdata_legacy_init(struct device *dev)
+{
+	if (dev->platform_data)
+		return;
+
+	if (strcmp("twl4030-gpio", dev_name(dev)))
+		return;
+
+	dev->platform_data = &twl_gpio_auxdata;
+}
+
+/*
  * Few boards still need auxdata populated before we populate
  * the dev entries in of_platform_populate().
  */
-- 
1.8.1.1
