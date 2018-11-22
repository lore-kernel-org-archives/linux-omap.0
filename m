From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 05/17] soc: ti: pruss: Configure SYSCFG properly during probe/remove
Date: Thu, 22 Nov 2018 13:39:01 +0200
Message-ID: <1542886753-17625-6-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRUSS CFG module's SYSCFG register is used for managing the
PRCM clock management settings at the PRU-ICSS subsystem level.

Add two helper functions pruss_{enable/disable}_module() that
programs this SYSCFG register during probe and remove. The
register is currently programmed for the default Smart-Idle
and Smart-Standby always during probe. The MStandby is enabled
during remove to undo the settings in probe to properly configure
the SYSCFG in the case that a firmware has disabled MStandby.
This is needed on SoCs like AM57xx that do not have a reset line
and so cannot reset the register properly.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/pruss_soc_bus.c | 60 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/pruss_soc_bus.c b/drivers/soc/ti/pruss_soc_bus.c
index d4da55d2..46dfb7a 100644
--- a/drivers/soc/ti/pruss_soc_bus.c
+++ b/drivers/soc/ti/pruss_soc_bus.c
@@ -20,6 +20,16 @@
 #define SYSCFG_STANDBY_INIT	BIT(4)
 #define SYSCFG_SUB_MWAIT_READY	BIT(5)
 
+#define SYSCFG_STANDBY_MODE_FORCE	(0 << 2)
+#define SYSCFG_STANDBY_MODE_NO		(1 << 2)
+#define SYSCFG_STANDBY_MODE_SMART	(2 << 2)
+#define SYSCFG_STANDBY_MODE_MASK	(3 << 2)
+
+#define SYSCFG_IDLE_MODE_FORCE		0
+#define SYSCFG_IDLE_MODE_NO		1
+#define SYSCFG_IDLE_MODE_SMART		2
+#define SYSCFG_IDLE_MODE_MASK		3
+
 /**
  * struct pruss_soc_bus - PRUSS SoC bus structure
  * @syscfg: kernel mapped address for SYSCFG register
@@ -115,6 +125,44 @@ static int __maybe_unused pruss_soc_bus_resume(struct device *dev)
 	return ret;
 }
 
+/* firmware must be idle when calling this function */
+static void pruss_disable_module(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+
+	/* configure Smart Standby */
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
+			  SYSCFG_STANDBY_MODE_SMART);
+
+	/* initiate MStandby */
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_INIT,
+			  SYSCFG_STANDBY_INIT);
+
+	/* tell PRCM to initiate IDLE request */
+	pm_runtime_put_sync(dev);
+}
+
+static int pruss_enable_module(struct device *dev)
+{
+	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
+	int ret;
+
+	/* tell PRCM to de-assert IDLE request */
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	/* configure for Smart Idle & Smart Standby */
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_IDLE_MODE_MASK,
+			  SYSCFG_IDLE_MODE_SMART);
+	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
+			  SYSCFG_STANDBY_MODE_SMART);
+
+	return ret;
+}
+
 static int pruss_soc_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -155,10 +203,10 @@ static int pruss_soc_bus_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pruss_enable_module(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
-		goto fail_clock;
+		dev_err(dev, "couldn't enable module\n");
+		goto fail_module;
 	}
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
@@ -168,8 +216,8 @@ static int pruss_soc_bus_probe(struct platform_device *pdev)
 	return 0;
 
 fail_of:
-	pm_runtime_put_sync(dev);
-fail_clock:
+	pruss_disable_module(dev);
+fail_module:
 	pm_runtime_disable(dev);
 	if (psoc_bus->has_reset)
 		pdata->assert_reset(pdev, pdata->reset_name);
@@ -186,7 +234,7 @@ static int pruss_soc_bus_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 
-	pm_runtime_put_sync(dev);
+	pruss_disable_module(dev);
 	pm_runtime_disable(dev);
 
 	if (psoc_bus->has_reset)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
