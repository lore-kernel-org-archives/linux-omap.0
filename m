From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 09/19] HSI: omap_ssi_port: prepare start_tx/stop_tx for blocking pm_runtime calls
Date: Sat, 18 Jun 2016 18:26:59 +0200
Message-ID: <1466267229-25012-10-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

ssi_start_tx and ssi_stop_tx may be called from atomic context. Once
pm_runtime_irq_safe() is removed for omap-ssi, this will fail, due
to blocking pm_runtime_*_sync() calls.

This fixes ssi_stop_tx by using non-sync API and ssi_start_tx by
using a worker thread.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.h      |  2 ++
 drivers/hsi/controllers/omap_ssi_port.c | 23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index 6cdaad8805f7..5467f61e5086 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -79,6 +79,7 @@ struct omap_ssm_ctx {
  * @pio_tasklet: Bottom half for PIO transfers and events
  * @flags: flags to keep track of states
  * @wk_refcount: Reference count for output wake line
+ * @work: worker for starting TX
  * @sys_mpu_enable: Context for the interrupt enable register for irq 0
  * @sst: Context for the synchronous serial transmitter
  * @ssr: Context for the synchronous serial receiver
@@ -103,6 +104,7 @@ struct omap_ssi_port {
 	bool			wktest:1; /* FIXME: HACK to be removed */
 	unsigned long		flags;
 	unsigned int		wk_refcount;
+	struct work_struct	work;
 	/* OMAP SSI port context */
 	u32			sys_mpu_enable; /* We use only one irq */
 	struct omap_ssm_ctx	sst;
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 0d3452393670..cc56d0ee82a2 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -567,12 +567,22 @@ static int ssi_flush(struct hsi_client *cl)
 	return 0;
 }
 
+static void start_tx_work(struct work_struct *work)
+{
+	struct omap_ssi_port *omap_port =
+				container_of(work, struct omap_ssi_port, work);
+	struct hsi_port *port = to_hsi_port(omap_port->dev);
+	struct hsi_controller *ssi = to_hsi_controller(port->device.parent);
+	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
+
+	pm_runtime_get_sync(omap_port->pdev); /* Grab clocks */
+	writel(SSI_WAKE(0), omap_ssi->sys + SSI_SET_WAKE_REG(port->num));
+}
+
 static int ssi_start_tx(struct hsi_client *cl)
 {
 	struct hsi_port *port = hsi_get_port(cl);
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
-	struct hsi_controller *ssi = to_hsi_controller(port->device.parent);
-	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
 
 	dev_dbg(&port->device, "Wake out high %d\n", omap_port->wk_refcount);
 
@@ -581,10 +591,10 @@ static int ssi_start_tx(struct hsi_client *cl)
 		spin_unlock_bh(&omap_port->wk_lock);
 		return 0;
 	}
-	pm_runtime_get_sync(omap_port->pdev); /* Grab clocks */
-	writel(SSI_WAKE(0), omap_ssi->sys + SSI_SET_WAKE_REG(port->num));
 	spin_unlock_bh(&omap_port->wk_lock);
 
+	schedule_work(&omap_port->work);
+
 	return 0;
 }
 
@@ -604,9 +614,10 @@ static int ssi_stop_tx(struct hsi_client *cl)
 		return 0;
 	}
 	writel(SSI_WAKE(0), omap_ssi->sys + SSI_CLEAR_WAKE_REG(port->num));
-	pm_runtime_put_sync(omap_port->pdev); /* Release clocks */
 	spin_unlock_bh(&omap_port->wk_lock);
 
+	pm_runtime_put(omap_port->pdev); /* Release clocks */
+
 	return 0;
 }
 
@@ -1149,6 +1160,8 @@ static int ssi_port_probe(struct platform_device *pd)
 	omap_port->pdev = &pd->dev;
 	omap_port->port_id = port_id;
 
+	INIT_WORK(&omap_port->work, start_tx_work);
+
 	/* initialize HSI port */
 	port->async	= ssi_async;
 	port->setup	= ssi_setup;
-- 
2.8.1
