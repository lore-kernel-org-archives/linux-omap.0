From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/2] HSI: omap-ssi: add clk change support
Date: Sun, 31 Jan 2016 01:52:38 +0100
Message-ID: <1454201558-31285-3-git-send-email-sre@kernel.org>
References: <1454201558-31285-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454201558-31285-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds support for frequency changes of the SSI
functional clock, which may occur due to DVFS.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.c      | 63 +++++++++++++++++++++++++++++++++
 drivers/hsi/controllers/omap_ssi.h      |  6 ++++
 drivers/hsi/controllers/omap_ssi_port.c | 20 +++++++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/hsi/controllers/omap_ssi.c b/drivers/hsi/controllers/omap_ssi.c
index f6d3100b7a32..8bc5f2fed869 100644
--- a/drivers/hsi/controllers/omap_ssi.c
+++ b/drivers/hsi/controllers/omap_ssi.c
@@ -291,6 +291,64 @@ static unsigned long ssi_get_clk_rate(struct hsi_controller *ssi)
 	return rate;
 }
 
+static int ssi_clk_event(struct notifier_block *nb, unsigned long event,
+								void *data)
+{
+	struct omap_ssi_controller *omap_ssi = container_of(nb,
+					struct omap_ssi_controller, fck_nb);
+	struct hsi_controller *ssi = to_hsi_controller(omap_ssi->dev);
+	struct clk_notifier_data *clk_data = data;
+	struct omap_ssi_port *omap_port;
+	int i;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		dev_dbg(&ssi->device, "pre rate change\n");
+
+		for (i = 0; i < ssi->num_ports; i++) {
+			omap_port = omap_ssi->port[i];
+
+			if (!omap_port)
+				continue;
+
+			/* Workaround for SWBREAK + CAwake down race in CMT */
+			tasklet_disable(&omap_port->wake_tasklet);
+
+			/* stop all ssi communication */
+			pinctrl_pm_select_idle_state(omap_port->pdev);
+			udelay(1); /* wait for racing frames */
+		}
+
+		break;
+	case ABORT_RATE_CHANGE:
+		dev_dbg(&ssi->device, "abort rate change\n");
+		/* Fall through */
+	case POST_RATE_CHANGE:
+		dev_dbg(&ssi->device, "post rate change (%lu -> %lu)\n",
+			clk_data->old_rate, clk_data->new_rate);
+		omap_ssi->fck_rate = DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /* KHz */
+
+		for (i = 0; i < ssi->num_ports; i++) {
+			omap_port = omap_ssi->port[i];
+
+			if (!omap_port)
+				continue;
+
+			omap_ssi_port_update_fclk(ssi, omap_port);
+
+			/* resume ssi communication */
+			pinctrl_pm_select_default_state(omap_port->pdev);
+			tasklet_enable(&omap_port->wake_tasklet);
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int __init ssi_get_iomem(struct platform_device *pd,
 		const char *name, void __iomem **pbase, dma_addr_t *phy)
 {
@@ -371,6 +429,10 @@ static int __init ssi_add_controller(struct hsi_controller *ssi,
 		goto out_err;
 	}
 
+	omap_ssi->fck_nb.notifier_call = ssi_clk_event;
+	omap_ssi->fck_nb.priority = INT_MAX;
+	clk_notifier_register(omap_ssi->fck, &omap_ssi->fck_nb);
+
 	/* TODO: find register, which can be used to detect context loss */
 	omap_ssi->get_loss = NULL;
 
@@ -434,6 +496,7 @@ static void ssi_remove_controller(struct hsi_controller *ssi)
 	int id = ssi->id;
 	tasklet_kill(&omap_ssi->gdd_tasklet);
 	hsi_unregister_controller(ssi);
+	clk_notifier_unregister(omap_ssi->fck, &omap_ssi->fck_nb);
 	ida_simple_remove(&platform_omap_ssi_ida, id);
 }
 
diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index f9aaf37262be..2797ab284460 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -134,6 +134,8 @@ struct gdd_trn {
  * @gdd_tasklet: bottom half for DMA transfers
  * @gdd_trn: Array of GDD transaction data for ongoing GDD transfers
  * @lock: lock to serialize access to GDD
+ * @fck_nb: DVFS notfifier block
+ * @fck_rate: clock rate
  * @loss_count: To follow if we need to restore context or not
  * @max_speed: Maximum TX speed (Kb/s) set by the clients.
  * @sysconfig: SSI controller saved context
@@ -151,6 +153,7 @@ struct omap_ssi_controller {
 	struct tasklet_struct	gdd_tasklet;
 	struct gdd_trn		gdd_trn[SSI_MAX_GDD_LCH];
 	spinlock_t		lock;
+	struct notifier_block	fck_nb;
 	unsigned long		fck_rate;
 	u32			loss_count;
 	u32			max_speed;
@@ -164,4 +167,7 @@ struct omap_ssi_controller {
 #endif
 };
 
+void omap_ssi_port_update_fclk(struct hsi_controller *ssi,
+			       struct omap_ssi_port *omap_port);
+
 #endif /* __LINUX_HSI_OMAP_SSI_H__ */
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 02e66032ae73..6557aaa52a36 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
+#include <linux/delay.h>
 
 #include <linux/of_gpio.h>
 #include <linux/debugfs.h>
@@ -514,6 +515,11 @@ static int ssi_flush(struct hsi_client *cl)
 
 	pm_runtime_get_sync(omap_port->pdev);
 	spin_lock_bh(&omap_port->lock);
+
+	/* stop all ssi communication */
+	pinctrl_pm_select_idle_state(omap_port->pdev);
+	udelay(1); /* wait for racing frames */
+
 	/* Stop all DMA transfers */
 	for (i = 0; i < SSI_MAX_GDD_LCH; i++) {
 		msg = omap_ssi->gdd_trn[i].msg;
@@ -550,6 +556,10 @@ static int ssi_flush(struct hsi_client *cl)
 		ssi_flush_queue(&omap_port->rxqueue[i], NULL);
 	}
 	ssi_flush_queue(&omap_port->brkqueue, NULL);
+
+	/* Resume SSI communication */
+	pinctrl_pm_select_default_state(omap_port->pdev);
+
 	spin_unlock_bh(&omap_port->lock);
 	pm_runtime_put_sync(omap_port->pdev);
 
@@ -1319,6 +1329,16 @@ static int ssi_restore_divisor(struct omap_ssi_port *omap_port)
 	return 0;
 }
 
+void omap_ssi_port_update_fclk(struct hsi_controller *ssi,
+			       struct omap_ssi_port *omap_port)
+{
+	/* update divisor */
+	u32 div = ssi_calculate_div(ssi);
+	omap_port->sst.divisor = div;
+	ssi_restore_divisor(omap_port);
+}
+EXPORT_SYMBOL_GPL(omap_ssi_port_update_fclk);
+
 static int omap_ssi_port_runtime_suspend(struct device *dev)
 {
 	struct hsi_port *port = dev_get_drvdata(dev);
-- 
2.7.0.rc3
