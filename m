From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 17/19] HSI: omap_ssi: call msg->complete() from process context
Date: Sat, 18 Jun 2016 18:27:07 +0200
Message-ID: <1466267229-25012-18-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

msg->complete() should always be called from process context once
irq_safe runtime pm flag is no longer set for omap-ssi.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.h      |  4 ++++
 drivers/hsi/controllers/omap_ssi_core.c |  4 +++-
 drivers/hsi/controllers/omap_ssi_port.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index 99143f4f8837..32ced0c8f789 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -73,6 +73,8 @@ struct omap_ssm_ctx {
  * @txqueue: TX message queues
  * @rxqueue: RX message queues
  * @brkqueue: Queue of incoming HWBREAK requests (FRAME mode)
+ * @errqueue: Queue for failed messages
+ * @errqueue_work: Delayed Work for failed messages
  * @irq: IRQ number
  * @wake_irq: IRQ number for incoming wake line (-1 if none)
  * @wake_gpio: GPIO number for incoming wake line (-1 if none)
@@ -96,6 +98,8 @@ struct omap_ssi_port {
 	struct list_head	txqueue[SSI_MAX_CHANNELS];
 	struct list_head	rxqueue[SSI_MAX_CHANNELS];
 	struct list_head	brkqueue;
+	struct list_head	errqueue;
+	struct delayed_work	errqueue_work;
 	unsigned int		irq;
 	int			wake_irq;
 	struct gpio_desc	*wake_gpio;
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 79562ce65579..506a9f1ef7ad 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -235,7 +235,9 @@ static void ssi_gdd_complete(struct hsi_controller *ssi, unsigned int lch)
 		spin_lock(&omap_port->lock);
 		list_del(&msg->link); /* Dequeue msg */
 		spin_unlock(&omap_port->lock);
-		msg->complete(msg);
+
+		list_add_tail(&msg->link, &omap_port->errqueue);
+		schedule_delayed_work(&omap_port->errqueue_work, 0);
 		return;
 	}
 	spin_lock(&omap_port->lock);
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index f91c6a4bb1a5..7717c769c4dd 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -193,6 +193,21 @@ static int ssi_debug_add_port(struct omap_ssi_port *omap_port,
 }
 #endif
 
+static void ssi_process_errqueue(struct work_struct *work)
+{
+	struct omap_ssi_port *omap_port;
+	struct list_head *head, *tmp;
+	struct hsi_msg *msg;
+
+	omap_port = container_of(work, struct omap_ssi_port, errqueue_work.work);
+
+	list_for_each_safe(head, tmp, &omap_port->errqueue) {
+		msg = list_entry(head, struct hsi_msg, link);
+		msg->complete(msg);
+		list_del(head);
+	}
+}
+
 static int ssi_claim_lch(struct hsi_msg *msg)
 {
 
@@ -1170,6 +1185,7 @@ static int ssi_port_probe(struct platform_device *pd)
 	omap_port->pdev = &pd->dev;
 	omap_port->port_id = port_id;
 
+	INIT_DEFERRABLE_WORK(&omap_port->errqueue_work, ssi_process_errqueue);
 	INIT_WORK(&omap_port->work, start_tx_work);
 
 	/* initialize HSI port */
@@ -1237,6 +1253,8 @@ static int ssi_port_remove(struct platform_device *pd)
 	ssi_debug_remove_port(port);
 #endif
 
+	cancel_delayed_work_sync(&omap_port->errqueue_work);
+
 	hsi_port_unregister_clients(port);
 
 	port->async	= hsi_dummy_msg;
-- 
2.8.1
