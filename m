From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 03/19] HSI: ssi_protocol: avoid ssi_waketest call with held spinlock
Date: Sat, 18 Jun 2016 18:26:53 +0200
Message-ID: <1466267229-25012-4-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This avoids calling ssi_waketest(), while a spinlock is
being hold, since ssi_waketest may sleep once irq_safe
runtime pm is disabled.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 41 +++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 6595d2091268..8534efda8140 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -88,6 +88,8 @@ void ssi_waketest(struct hsi_client *cl, unsigned int enable);
 #define SSIP_READY_CMD		SSIP_CMD(SSIP_READY, 0)
 #define SSIP_SWBREAK_CMD	SSIP_CMD(SSIP_SW_BREAK, 0)
 
+#define SSIP_WAKETEST_FLAG 0
+
 /* Main state machine states */
 enum {
 	INIT,
@@ -116,7 +118,7 @@ enum {
  * @main_state: Main state machine
  * @send_state: TX state machine
  * @recv_state: RX state machine
- * @waketest: Flag to follow wake line test
+ * @flags: Flags, currently only used to follow wake line test
  * @rxid: RX data id
  * @txid: TX data id
  * @txqueue_len: TX queue length
@@ -137,7 +139,7 @@ struct ssi_protocol {
 	unsigned int		main_state;
 	unsigned int		send_state;
 	unsigned int		recv_state;
-	unsigned int		waketest:1;
+	unsigned long		flags;
 	u8			rxid;
 	u8			txid;
 	unsigned int		txqueue_len;
@@ -405,15 +407,17 @@ static void ssip_reset(struct hsi_client *cl)
 	spin_lock_bh(&ssi->lock);
 	if (ssi->send_state != SEND_IDLE)
 		hsi_stop_tx(cl);
-	if (ssi->waketest)
-		ssi_waketest(cl, 0);
+	spin_unlock_bh(&ssi->lock);
+	if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
+		ssi_waketest(cl, 0); /* FIXME: To be removed */
+	spin_lock_bh(&ssi->lock);
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
-	ssi->waketest = 0;
+	ssi->flags = 0;
 	ssi->rxid = 0;
 	ssi->txid = 0;
 	list_for_each_safe(head, tmp, &ssi->txqueue) {
@@ -437,7 +441,8 @@ static void ssip_dump_state(struct hsi_client *cl)
 	dev_err(&cl->device, "Send state: %d\n", ssi->send_state);
 	dev_err(&cl->device, "CMT %s\n", (ssi->main_state == ACTIVE) ?
 							"Online" : "Offline");
-	dev_err(&cl->device, "Wake test %d\n", ssi->waketest);
+	dev_err(&cl->device, "Wake test %d\n",
+				test_bit(SSIP_WAKETEST_FLAG, &ssi->flags));
 	dev_err(&cl->device, "Data RX id: %d\n", ssi->rxid);
 	dev_err(&cl->device, "Data TX id: %d\n", ssi->txid);
 
@@ -668,10 +673,12 @@ static void ssip_rx_bootinforeq(struct hsi_client *cl, u32 cmd)
 	case HANDSHAKE:
 		spin_lock(&ssi->lock);
 		ssi->main_state = HANDSHAKE;
-		if (!ssi->waketest) {
-			ssi->waketest = 1;
+		spin_unlock(&ssi->lock);
+
+		if (!test_and_set_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 			ssi_waketest(cl, 1); /* FIXME: To be removed */
-		}
+
+		spin_lock(&ssi->lock);
 		/* Start boot handshake watchdog */
 		mod_timer(&ssi->tx_wd, jiffies + msecs_to_jiffies(SSIP_WDTOUT));
 		spin_unlock(&ssi->lock);
@@ -718,10 +725,12 @@ static void ssip_rx_waketest(struct hsi_client *cl, u32 cmd)
 		spin_unlock(&ssi->lock);
 		return;
 	}
-	if (ssi->waketest) {
-		ssi->waketest = 0;
+	spin_unlock(&ssi->lock);
+
+	if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 		ssi_waketest(cl, 0); /* FIXME: To be removed */
-	}
+
+	spin_lock(&ssi->lock);
 	ssi->main_state = ACTIVE;
 	del_timer(&ssi->tx_wd); /* Stop boot handshake timer */
 	spin_unlock(&ssi->lock);
@@ -926,11 +935,11 @@ static int ssip_pn_open(struct net_device *dev)
 	}
 	dev_dbg(&cl->device, "Configuring SSI port\n");
 	hsi_setup(cl);
-	spin_lock_bh(&ssi->lock);
-	if (!ssi->waketest) {
-		ssi->waketest = 1;
+
+	if (!test_and_set_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 		ssi_waketest(cl, 1); /* FIXME: To be removed */
-	}
+
+	spin_lock_bh(&ssi->lock);
 	ssi->main_state = HANDSHAKE;
 	spin_unlock_bh(&ssi->lock);
 
-- 
2.8.1
