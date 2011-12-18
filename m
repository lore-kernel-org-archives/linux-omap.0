From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] davinci-cpdma: fix locking issue in cpdma_chan_stop
Date: Sun, 18 Dec 2011 21:02:04 +0100
Message-ID: <1324238524-21330-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58546 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab1LRUCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Dec 2011 15:02:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Ilya Yanok <yanok@emcraft.com>

Free the channel lock before calling __cpdma_chan_process to prevent
dead lock.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 drivers/net/ethernet/ti/davinci_cpdma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index dca9d33..c97d2f5 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -836,11 +836,13 @@ int cpdma_chan_stop(struct cpdma_chan *chan)
 	chan_write(chan, cp, CPDMA_TEARDOWN_VALUE);
 
 	/* handle completed packets */
+	spin_unlock_irqrestore(&chan->lock, flags);
 	do {
 		ret = __cpdma_chan_process(chan);
 		if (ret < 0)
 			break;
 	} while ((ret & CPDMA_DESC_TD_COMPLETE) == 0);
+	spin_lock_irqsave(&chan->lock, flags);
 
 	/* remaining packets haven't been tx/rx'ed, clean them up */
 	while (chan->head) {
-- 
1.7.6.4

