From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] thermal: ti-soc-thermal:  Enable addition power management
Date: Fri,  8 Nov 2019 14:05:01 -0600
Message-ID: <20191108200501.29864-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hns@goldelico.com, adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The bandgap sensor can be idled when the processor is too, but it
isn't currently being done, so the power consumption of OMAP3
boards can elevated if the bangap sensor is enabled.

This patch attempts to use some additional power management
to idle the clock to the bandgap when not needed.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..7a221f71bc9f 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -26,10 +26,18 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/io.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "ti-bandgap.h"
 
 static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v);
 
 /***   Helper functions to access registers and their bitfields   ***/
 
@@ -1025,6 +1033,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
 		}
 	}
 
+	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
+	cpu_pm_register_notifier(&bgp->nb);
+
 	return 0;
 
 remove_last_cooling:
@@ -1174,6 +1185,38 @@ static int ti_bandgap_suspend(struct device *dev)
 	return err;
 }
 
+static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v)
+{
+	struct ti_bandgap *bgp;
+
+	bgp = container_of(nb, struct ti_bandgap, nb);
+
+	spin_lock(&bgp->lock);
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (bgp->is_suspended)
+			break;
+		ti_bandgap_save_ctxt(bgp);
+		ti_bandgap_power(bgp, false);
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_disable_unprepare(bgp->fclock);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if (bgp->is_suspended)
+			break;
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
+			clk_prepare_enable(bgp->fclock);
+		ti_bandgap_power(bgp, true);
+		ti_bandgap_restore_ctxt(bgp);
+		break;
+	}
+	spin_unlock(&bgp->lock);
+
+	return NOTIFY_OK;
+}
+
 static int ti_bandgap_resume(struct device *dev)
 {
 	struct ti_bandgap *bgp = dev_get_drvdata(dev);
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index bb9b0f7faf99..a21d07a1a23a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -12,6 +12,10 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/err.h>
+#include <linux/cpu_pm.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 
 /**
  * DOC: bandgap driver data structure
@@ -201,6 +205,8 @@ struct ti_bandgap {
 	int				irq;
 	int				tshut_gpio;
 	u32				clk_rate;
+	struct notifier_block		nb;
+	unsigned int is_suspended:1;
 };
 
 /**
-- 
2.20.1
