From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 12/19] HSI: omap_ssi_port: switch to threaded pio irq
Date: Sat, 18 Jun 2016 18:27:02 +0200
Message-ID: <1466267229-25012-13-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Move pio interrupt handler from tasklet into thread to
allow runtime_pm_get_sync calls without irq_safe being
set.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.h      |  2 --
 drivers/hsi/controllers/omap_ssi_port.c | 60 +++++++++++++--------------------
 2 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index 5467f61e5086..99143f4f8837 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -76,7 +76,6 @@ struct omap_ssm_ctx {
  * @irq: IRQ number
  * @wake_irq: IRQ number for incoming wake line (-1 if none)
  * @wake_gpio: GPIO number for incoming wake line (-1 if none)
- * @pio_tasklet: Bottom half for PIO transfers and events
  * @flags: flags to keep track of states
  * @wk_refcount: Reference count for output wake line
  * @work: worker for starting TX
@@ -100,7 +99,6 @@ struct omap_ssi_port {
 	unsigned int		irq;
 	int			wake_irq;
 	struct gpio_desc	*wake_gpio;
-	struct tasklet_struct	pio_tasklet;
 	bool			wktest:1; /* FIXME: HACK to be removed */
 	unsigned long		flags;
 	unsigned int		wk_refcount;
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index cc56d0ee82a2..f62f0c482cea 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -877,7 +877,7 @@ static void ssi_pio_complete(struct hsi_port *port, struct list_head *queue)
 	u32 reg;
 	u32 val;
 
-	spin_lock(&omap_port->lock);
+	spin_lock_bh(&omap_port->lock);
 	msg = list_first_entry(queue, struct hsi_msg, link);
 	if ((!msg->sgt.nents) || (!msg->sgt.sgl->length)) {
 		msg->actual_len = 0;
@@ -909,7 +909,7 @@ static void ssi_pio_complete(struct hsi_port *port, struct list_head *queue)
 					(msg->ttype == HSI_MSG_WRITE))) {
 			writel(val, omap_ssi->sys +
 					SSI_MPU_STATUS_REG(port->num, 0));
-			spin_unlock(&omap_port->lock);
+			spin_unlock_bh(&omap_port->lock);
 
 			return;
 		}
@@ -925,12 +925,12 @@ static void ssi_pio_complete(struct hsi_port *port, struct list_head *queue)
 	writel_relaxed(reg, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
 	writel_relaxed(val, omap_ssi->sys + SSI_MPU_STATUS_REG(port->num, 0));
 	list_del(&msg->link);
-	spin_unlock(&omap_port->lock);
+	spin_unlock_bh(&omap_port->lock);
 	msg->complete(msg);
 	ssi_transfer(omap_port, queue);
 }
 
-static void ssi_pio_tasklet(unsigned long ssi_port)
+static irqreturn_t ssi_pio_thread(int irq, void *ssi_port)
 {
 	struct hsi_port *port = (struct hsi_port *)ssi_port;
 	struct hsi_controller *ssi = to_hsi_controller(port->device.parent);
@@ -941,37 +941,29 @@ static void ssi_pio_tasklet(unsigned long ssi_port)
 	u32 status_reg;
 
 	pm_runtime_get_sync(omap_port->pdev);
-	status_reg = readl(sys + SSI_MPU_STATUS_REG(port->num, 0));
-	status_reg &= readl(sys + SSI_MPU_ENABLE_REG(port->num, 0));
 
-	for (ch = 0; ch < omap_port->channels; ch++) {
-		if (status_reg & SSI_DATAACCEPT(ch))
-			ssi_pio_complete(port, &omap_port->txqueue[ch]);
-		if (status_reg & SSI_DATAAVAILABLE(ch))
-			ssi_pio_complete(port, &omap_port->rxqueue[ch]);
-	}
-	if (status_reg & SSI_BREAKDETECTED)
-		ssi_break_complete(port);
-	if (status_reg & SSI_ERROROCCURED)
-		ssi_error(port);
+	do {
+		status_reg = readl(sys + SSI_MPU_STATUS_REG(port->num, 0));
+		status_reg &= readl(sys + SSI_MPU_ENABLE_REG(port->num, 0));
 
-	status_reg = readl(sys + SSI_MPU_STATUS_REG(port->num, 0));
-	status_reg &= readl(sys + SSI_MPU_ENABLE_REG(port->num, 0));
-	pm_runtime_put_sync(omap_port->pdev);
+		for (ch = 0; ch < omap_port->channels; ch++) {
+			if (status_reg & SSI_DATAACCEPT(ch))
+				ssi_pio_complete(port, &omap_port->txqueue[ch]);
+			if (status_reg & SSI_DATAAVAILABLE(ch))
+				ssi_pio_complete(port, &omap_port->rxqueue[ch]);
+		}
+		if (status_reg & SSI_BREAKDETECTED)
+			ssi_break_complete(port);
+		if (status_reg & SSI_ERROROCCURED)
+			ssi_error(port);
 
-	if (status_reg)
-		tasklet_hi_schedule(&omap_port->pio_tasklet);
-	else
-		enable_irq(omap_port->irq);
-}
+		status_reg = readl(sys + SSI_MPU_STATUS_REG(port->num, 0));
+		status_reg &= readl(sys + SSI_MPU_ENABLE_REG(port->num, 0));
 
-static irqreturn_t ssi_pio_isr(int irq, void *port)
-{
-	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
-
-	tasklet_hi_schedule(&omap_port->pio_tasklet);
-	disable_irq_nosync(irq);
+		/* TODO: sleep if we retry? */
+	} while (status_reg);
 
+	pm_runtime_put(omap_port->pdev);
 	return IRQ_HANDLED;
 }
 
@@ -1023,10 +1015,8 @@ static int ssi_port_irq(struct hsi_port *port, struct platform_device *pd)
 		return err;
 	}
 	omap_port->irq = err;
-	tasklet_init(&omap_port->pio_tasklet, ssi_pio_tasklet,
-							(unsigned long)port);
-	err = devm_request_irq(&port->device, omap_port->irq, ssi_pio_isr,
-						0, "mpu_irq0", port);
+	err = devm_request_threaded_irq(&port->device, omap_port->irq, NULL,
+				ssi_pio_thread, IRQF_ONESHOT, "SSI PORT", port);
 	if (err < 0)
 		dev_err(&port->device, "Request IRQ %d failed (%d)\n",
 							omap_port->irq, err);
@@ -1229,8 +1219,6 @@ static int ssi_port_remove(struct platform_device *pd)
 
 	hsi_port_unregister_clients(port);
 
-	tasklet_kill(&omap_port->pio_tasklet);
-
 	port->async	= hsi_dummy_msg;
 	port->setup	= hsi_dummy_cl;
 	port->flush	= hsi_dummy_cl;
-- 
2.8.1
