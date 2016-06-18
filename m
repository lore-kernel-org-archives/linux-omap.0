From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 04/19] HSI: ssi_protocol: replace spin_lock with spin_lock_bh
Date: Sat, 18 Jun 2016 18:26:54 +0200
Message-ID: <1466267229-25012-5-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

To avoid setting irq_safe runtime pm flag in omap-ssi, multiple calls
will be moved to process context. This also affects ssi-protocol, so
use the safer spin_lock_bh instead of a simple spin_lock.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 8534efda8140..2388857db14b 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -520,17 +520,17 @@ static void ssip_start_rx(struct hsi_client *cl)
 
 	dev_dbg(&cl->device, "RX start M(%d) R(%d)\n", ssi->main_state,
 						ssi->recv_state);
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	/*
 	 * We can have two UP events in a row due to a short low
 	 * high transition. Therefore we need to ignore the sencond UP event.
 	 */
 	if ((ssi->main_state != ACTIVE) || (ssi->recv_state == RECV_READY)) {
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		return;
 	}
 	ssip_set_rxstate(ssi, RECV_READY);
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 
 	msg = ssip_claim_cmd(ssi);
 	ssip_set_cmd(msg, SSIP_READY_CMD);
@@ -544,10 +544,10 @@ static void ssip_stop_rx(struct hsi_client *cl)
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 
 	dev_dbg(&cl->device, "RX stop M(%d)\n", ssi->main_state);
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (likely(ssi->main_state == ACTIVE))
 		ssip_set_rxstate(ssi, RECV_IDLE);
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 }
 
 static void ssip_free_strans(struct hsi_msg *msg)
@@ -564,9 +564,9 @@ static void ssip_strans_complete(struct hsi_msg *msg)
 
 	data = msg->context;
 	ssip_release_cmd(msg);
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	ssip_set_txstate(ssi, SENDING);
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 	hsi_async_write(cl, data);
 }
 
@@ -671,17 +671,17 @@ static void ssip_rx_bootinforeq(struct hsi_client *cl, u32 cmd)
 		/* Fall through */
 	case INIT:
 	case HANDSHAKE:
-		spin_lock(&ssi->lock);
+		spin_lock_bh(&ssi->lock);
 		ssi->main_state = HANDSHAKE;
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 
 		if (!test_and_set_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 			ssi_waketest(cl, 1); /* FIXME: To be removed */
 
-		spin_lock(&ssi->lock);
+		spin_lock_bh(&ssi->lock);
 		/* Start boot handshake watchdog */
 		mod_timer(&ssi->tx_wd, jiffies + msecs_to_jiffies(SSIP_WDTOUT));
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		dev_dbg(&cl->device, "Send BOOTINFO_RESP\n");
 		if (SSIP_DATA_VERSION(cmd) != SSIP_LOCAL_VERID)
 			dev_warn(&cl->device, "boot info req verid mismatch\n");
@@ -703,14 +703,14 @@ static void ssip_rx_bootinforesp(struct hsi_client *cl, u32 cmd)
 	if (SSIP_DATA_VERSION(cmd) != SSIP_LOCAL_VERID)
 		dev_warn(&cl->device, "boot info resp verid mismatch\n");
 
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (ssi->main_state != ACTIVE)
 		/* Use tx_wd as a boot watchdog in non ACTIVE state */
 		mod_timer(&ssi->tx_wd, jiffies + msecs_to_jiffies(SSIP_WDTOUT));
 	else
 		dev_dbg(&cl->device, "boot info resp ignored M(%d)\n",
 							ssi->main_state);
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 }
 
 static void ssip_rx_waketest(struct hsi_client *cl, u32 cmd)
@@ -718,22 +718,22 @@ static void ssip_rx_waketest(struct hsi_client *cl, u32 cmd)
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 	unsigned int wkres = SSIP_PAYLOAD(cmd);
 
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (ssi->main_state != HANDSHAKE) {
 		dev_dbg(&cl->device, "wake lines test ignored M(%d)\n",
 							ssi->main_state);
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		return;
 	}
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 
 	if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
 		ssi_waketest(cl, 0); /* FIXME: To be removed */
 
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	ssi->main_state = ACTIVE;
 	del_timer(&ssi->tx_wd); /* Stop boot handshake timer */
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 
 	dev_notice(&cl->device, "WAKELINES TEST %s\n",
 				wkres & SSIP_WAKETEST_FAILED ? "FAILED" : "OK");
@@ -750,20 +750,20 @@ static void ssip_rx_ready(struct hsi_client *cl)
 {
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (unlikely(ssi->main_state != ACTIVE)) {
 		dev_dbg(&cl->device, "READY on wrong state: S(%d) M(%d)\n",
 					ssi->send_state, ssi->main_state);
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		return;
 	}
 	if (ssi->send_state != WAIT4READY) {
 		dev_dbg(&cl->device, "Ignore spurious READY command\n");
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		return;
 	}
 	ssip_set_txstate(ssi, SEND_READY);
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 	ssip_xmit(cl);
 }
 
@@ -775,22 +775,22 @@ static void ssip_rx_strans(struct hsi_client *cl, u32 cmd)
 	int len = SSIP_PDU_LENGTH(cmd);
 
 	dev_dbg(&cl->device, "RX strans: %d frames\n", len);
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (unlikely(ssi->main_state != ACTIVE)) {
 		dev_err(&cl->device, "START TRANS wrong state: S(%d) M(%d)\n",
 					ssi->send_state, ssi->main_state);
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		return;
 	}
 	ssip_set_rxstate(ssi, RECEIVING);
 	if (unlikely(SSIP_MSG_ID(cmd) != ssi->rxid)) {
 		dev_err(&cl->device, "START TRANS id %d expected %d\n",
 					SSIP_MSG_ID(cmd), ssi->rxid);
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		goto out1;
 	}
 	ssi->rxid++;
-	spin_unlock(&ssi->lock);
+	spin_unlock_bh(&ssi->lock);
 	skb = netdev_alloc_skb(ssi->netdev, len * 4);
 	if (unlikely(!skb)) {
 		dev_err(&cl->device, "No memory for rx skb\n");
@@ -858,7 +858,7 @@ static void ssip_swbreak_complete(struct hsi_msg *msg)
 	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
 
 	ssip_release_cmd(msg);
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (list_empty(&ssi->txqueue)) {
 		if (atomic_read(&ssi->tx_usecnt)) {
 			ssip_set_txstate(ssi, SEND_READY);
@@ -866,9 +866,9 @@ static void ssip_swbreak_complete(struct hsi_msg *msg)
 			ssip_set_txstate(ssi, SEND_IDLE);
 			hsi_stop_tx(cl);
 		}
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 	} else {
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		ssip_xmit(cl);
 	}
 	netif_wake_queue(ssi->netdev);
@@ -885,17 +885,17 @@ static void ssip_tx_data_complete(struct hsi_msg *msg)
 		ssip_error(cl);
 		goto out;
 	}
-	spin_lock(&ssi->lock);
+	spin_lock_bh(&ssi->lock);
 	if (list_empty(&ssi->txqueue)) {
 		ssip_set_txstate(ssi, SENDING_SWBREAK);
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		cmsg = ssip_claim_cmd(ssi);
 		ssip_set_cmd(cmsg, SSIP_SWBREAK_CMD);
 		cmsg->complete = ssip_swbreak_complete;
 		dev_dbg(&cl->device, "Send SWBREAK\n");
 		hsi_async_write(cl, cmsg);
 	} else {
-		spin_unlock(&ssi->lock);
+		spin_unlock_bh(&ssi->lock);
 		ssip_xmit(cl);
 	}
 out:
-- 
2.8.1
