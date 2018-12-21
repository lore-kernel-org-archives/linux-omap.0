From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 11/14] media: wl128x-radio: fix skb debug printing
Date: Fri, 21 Dec 2018 02:17:49 +0100
Message-ID: <20181221011752.25627-12-sre@kernel.org>
References: <20181221011752.25627-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

This fixes incorrect code in the TX/RX skb debug print
function and add stubs in receive/transmit packet path.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 473ec5738a11..c20d518af4f3 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -195,7 +195,7 @@ static inline void fm_irq_timeout_stage(struct fmdev *fmdev, u8 stage)
 
 #ifdef FM_DUMP_TXRX_PKT
  /* To dump outgoing FM Channel-8 packets */
-inline void dump_tx_skb_data(struct sk_buff *skb)
+static void dump_tx_skb_data(struct sk_buff *skb)
 {
 	int len, len_org;
 	u8 index;
@@ -220,7 +220,7 @@ inline void dump_tx_skb_data(struct sk_buff *skb)
 }
 
  /* To dump incoming FM Channel-8 packets */
-inline void dump_rx_skb_data(struct sk_buff *skb)
+static void dump_rx_skb_data(struct sk_buff *skb)
 {
 	int len, len_org;
 	u8 index;
@@ -228,7 +228,7 @@ inline void dump_rx_skb_data(struct sk_buff *skb)
 
 	evt_hdr = (struct fm_event_msg_hdr *)skb->data;
 	printk(KERN_INFO ">> hdr:%02x len:%02x sts:%02x numhci:%02x opcode:%02x type:%s dlen:%02x",
-	       evt_hdr->hdr, evt_hdr->len,
+	       evt_hdr->header, evt_hdr->len,
 	       evt_hdr->status, evt_hdr->num_fm_hci_cmds, evt_hdr->op,
 	       (evt_hdr->rd_wr) ? "RD" : "WR", evt_hdr->dlen);
 
@@ -243,6 +243,9 @@ inline void dump_rx_skb_data(struct sk_buff *skb)
 	}
 	printk(KERN_CONT "\n");
 }
+#else
+static void dump_tx_skb_data(struct sk_buff *skb) {}
+static void dump_rx_skb_data(struct sk_buff *skb) {}
 #endif
 
 void fmc_update_region_info(struct fmdev *fmdev, u8 region_to_set)
@@ -369,6 +372,7 @@ static void send_tasklet(unsigned long arg)
 	fmdev->resp_comp = fm_cb(skb)->completion;
 
 	/* Write FM packet to ST driver */
+	dump_tx_skb_data(skb);
 	len = g_st_write(skb);
 	if (len < 0) {
 		kfree_skb(skb);
@@ -1454,6 +1458,8 @@ static long fm_st_receive(void *arg, struct sk_buff *skb)
 	}
 
 	memcpy(skb_push(skb, 1), &skb->cb[0], 1);
+	dump_rx_skb_data(skb);
+
 	skb_queue_tail(&fmdev->rx_q, skb);
 	tasklet_schedule(&fmdev->rx_task);
 
-- 
2.19.2
