From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 05/19] HSI: ssi_protocol: fix ssip_xmit invocation
Date: Sat, 18 Jun 2016 18:26:55 +0200
Message-ID: <1466267229-25012-6-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

ssip_xmit should be called from process context,
since it calls hsi_async_write.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 2388857db14b..6031cd146556 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -150,6 +150,7 @@ struct ssi_protocol {
 	struct net_device	*netdev;
 	struct list_head	txqueue;
 	struct list_head	cmdqueue;
+	struct work_struct	work;
 	struct hsi_client	*cl;
 	struct list_head	link;
 	atomic_t		tx_usecnt;
@@ -968,6 +969,15 @@ static int ssip_pn_set_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+static void ssip_xmit_work(struct work_struct *work)
+{
+	struct ssi_protocol *ssi =
+				container_of(work, struct ssi_protocol, work);
+	struct hsi_client *cl = ssi->cl;
+
+	ssip_xmit(cl);
+}
+
 static int ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct hsi_client *cl = to_hsi_client(dev->dev.parent);
@@ -1020,7 +1030,7 @@ static int ssip_pn_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_dbg(&cl->device, "Start TX on SEND READY qlen %d\n",
 							ssi->txqueue_len);
 		spin_unlock_bh(&ssi->lock);
-		ssip_xmit(cl);
+		schedule_work(&ssi->work);
 	} else {
 		spin_unlock_bh(&ssi->lock);
 	}
@@ -1097,6 +1107,7 @@ static int ssi_protocol_probe(struct device *dev)
 	atomic_set(&ssi->tx_usecnt, 0);
 	hsi_client_set_drvdata(cl, ssi);
 	ssi->cl = cl;
+	INIT_WORK(&ssi->work, ssip_xmit_work);
 
 	ssi->channel_id_cmd = hsi_get_channel_id_by_name(cl, "mcsaab-control");
 	if (ssi->channel_id_cmd < 0) {
-- 
2.8.1
