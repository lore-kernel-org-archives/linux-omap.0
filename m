From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [RFC PATCH] OMAP: DSS2: RFBI driver: Cleanup "kfifo is full" test
Date: Mon, 14 Dec 2009 05:18:16 +0200
Message-ID: <20091214031816.GA1829@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zakalwe.fi ([91.90.49.150]:43123 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbZLND13 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Dec 2009 22:27:29 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

RFBI_CMD_FIFO_LEN_BYTES might not be a power-of-two,
but kfifo() allocates the size up to the next power of two,
which makes (RFBI_CMD_FIFO_LEN_BYTES - kfifo_len())
look very dubious (possibly a negative value!).

Notes:

[1] Not tested nor compiled here

[2] The removed code compares int with a size_t.
It looks buggy, because if the full allocated
size of the fifo is used, the integer comparison
leads to "always empty space in the fifo".
Fortunately, the code can never go there, because
available == 0 will come before negative integer
values.

[3] Do we want to use the whole allocated space?
In that case the change should be:

-               available = RFBI_CMD_FIFO_LEN_BYTES -
-                       __kfifo_len(rfbi.cmd_fifo);
+               available = rfbi.cmd_fifo->size - __kfifo_len(rfbi.cmd_fifo);

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 drivers/video/omap2/dss/rfbi.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index d0b3006..1dbe993 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1050,14 +1050,11 @@ static void rfbi_push_cmd(struct update_param *p)
 
 	while (1) {
 		unsigned long flags;
-		int available;
 
 		spin_lock_irqsave(rfbi.cmd_fifo->lock, flags);
-		available = RFBI_CMD_FIFO_LEN_BYTES -
-			__kfifo_len(rfbi.cmd_fifo);
 
 /*		DSSDBG("%d bytes left in fifo\n", available); */
-		if (available < sizeof(struct update_param)) {
+		if (__kfifo_len(rfbi.cmd_fifo) >= RFBI_CMD_FIFO_LEN_BYTES) {
 			DSSDBG("Going to wait because FIFO FULL..\n");
 			spin_unlock_irqrestore(rfbi.cmd_fifo->lock, flags);
 			atomic_inc(&rfbi.cmd_fifo_full);
-- 
1.6.4.4
