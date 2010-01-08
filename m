From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 05/15] OMAP: DSS2: RFBI: convert to new kfifo API
Date: Fri,  8 Jan 2010 15:22:39 +0200
Message-ID: <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25339 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0AHNWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:37 -0500
In-Reply-To: <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Compiles, but not tested.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/rfbi.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index d0b3006..b936495 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -120,7 +120,7 @@ static struct {
 
 	struct omap_dss_device *dssdev[2];
 
-	struct kfifo      *cmd_fifo;
+	struct kfifo      cmd_fifo;
 	spinlock_t        cmd_lock;
 	struct completion cmd_done;
 	atomic_t          cmd_fifo_full;
@@ -1011,20 +1011,20 @@ static void process_cmd_fifo(void)
 		return;
 
 	while (true) {
-		spin_lock_irqsave(rfbi.cmd_fifo->lock, flags);
+		spin_lock_irqsave(&rfbi.cmd_lock, flags);
 
-		len = __kfifo_get(rfbi.cmd_fifo, (unsigned char *)&p,
+		len = kfifo_out(&rfbi.cmd_fifo, (unsigned char *)&p,
 				  sizeof(struct update_param));
 		if (len == 0) {
 			DSSDBG("nothing more in fifo\n");
 			atomic_set(&rfbi.cmd_pending, 0);
-			spin_unlock_irqrestore(rfbi.cmd_fifo->lock, flags);
+			spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
 			break;
 		}
 
 		/* DSSDBG("fifo full %d\n", rfbi.cmd_fifo_full.counter);*/
 
-		spin_unlock_irqrestore(rfbi.cmd_fifo->lock, flags);
+		spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
 
 		BUG_ON(len != sizeof(struct update_param));
 		BUG_ON(p.rfbi_module > 1);
@@ -1052,25 +1052,25 @@ static void rfbi_push_cmd(struct update_param *p)
 		unsigned long flags;
 		int available;
 
-		spin_lock_irqsave(rfbi.cmd_fifo->lock, flags);
+		spin_lock_irqsave(&rfbi.cmd_lock, flags);
 		available = RFBI_CMD_FIFO_LEN_BYTES -
-			__kfifo_len(rfbi.cmd_fifo);
+			kfifo_len(&rfbi.cmd_fifo);
 
 /*		DSSDBG("%d bytes left in fifo\n", available); */
 		if (available < sizeof(struct update_param)) {
 			DSSDBG("Going to wait because FIFO FULL..\n");
-			spin_unlock_irqrestore(rfbi.cmd_fifo->lock, flags);
+			spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
 			atomic_inc(&rfbi.cmd_fifo_full);
 			wait_for_completion(&rfbi.cmd_done);
 			/*DSSDBG("Woke up because fifo not full anymore\n");*/
 			continue;
 		}
 
-		ret = __kfifo_put(rfbi.cmd_fifo, (unsigned char *)p,
+		ret = kfifo_in(&rfbi.cmd_fifo, (unsigned char *)p,
 				  sizeof(struct update_param));
 /*		DSSDBG("pushed %d bytes\n", ret);*/
 
-		spin_unlock_irqrestore(rfbi.cmd_fifo->lock, flags);
+		spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
 
 		BUG_ON(ret != sizeof(struct update_param));
 
@@ -1155,12 +1155,12 @@ int rfbi_init(void)
 {
 	u32 rev;
 	u32 l;
+	int r;
 
 	spin_lock_init(&rfbi.cmd_lock);
-	rfbi.cmd_fifo = kfifo_alloc(RFBI_CMD_FIFO_LEN_BYTES, GFP_KERNEL,
-				    &rfbi.cmd_lock);
-	if (IS_ERR(rfbi.cmd_fifo))
-		return -ENOMEM;
+	r = kfifo_alloc(&rfbi.cmd_fifo, RFBI_CMD_FIFO_LEN_BYTES, GFP_KERNEL);
+	if (r)
+		return r;
 
 	init_completion(&rfbi.cmd_done);
 	atomic_set(&rfbi.cmd_fifo_full, 0);
@@ -1196,7 +1196,7 @@ void rfbi_exit(void)
 {
 	DSSDBG("rfbi_exit\n");
 
-	kfifo_free(rfbi.cmd_fifo);
+	kfifo_free(&rfbi.cmd_fifo);
 
 	iounmap(rfbi.base);
 }
-- 
1.6.5

