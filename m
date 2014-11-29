From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [RFC 2/2] i2c: omap: show that the reason of system lockup is an unhandled ISR event
Date: Sun, 30 Nov 2014 01:00:03 +0400
Message-ID: <1417294803-14729-3-git-send-email-al.kochet@gmail.com>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 079d8af24b948261e1dae5d7df6b31b7bf205cb4 ("i2c: omap: bus:
add a receiver flag") changed ISR loop to silently ignore unwanted
XDR/XRDY or RDR/RRDY events without processing. That unwanted events
will fire interrupt again and most likely they will be ignored again.
As a result, system enters lockup state. CPU loops through omap_i2c_isr()
and omap_i2c_isr_thread(). The lockup is signaled with the message
"sched: RT throttling activated" shown on console.

The commit allow unwanted events to enter into processing loop and
to be acked (at least) and processed (show error message).
Sometimes if unwannted event is acked, the ISR can continue it's work.
Sometimes system still remains in the lockup, but at least the reason
is obvious.

That unwanted events I tested with are events from IP slave receiver,
fired when General Call (GC) command is detected on the bus. As after
every master transfer IP enter into slave receiver mode. ISR must be
ready for events from slave receiver or slave receiver must be
disabled after master transfer to avoid lockups.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Fixes 079d8af24b948261e1dae5d7df6b31b7bf205cb4 "i2c: omap: bus: add a receiver flag"
---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e890295..192f9ce 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -939,6 +939,22 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
 		bool is_rdr)
 {
 	u16 w;
+	int warn = 0;
+
+	if (unlikely(!dev->receiver)) {
+		warn = 1;
+		/* REVISIT: errata i207 during transmission? */
+		if (dev->errata & I2C_OMAP_ERRATA_I207) {
+			if (is_rdr & !num_bytes)
+				warn = 0;
+		}
+		num_bytes = 0;
+	}
+
+	if (unlikely(warn)) {
+		dev_err(dev->dev, "%s interrupt while sending\n",
+			is_rdr ? "RDR" : "RRDY");
+	}
 
 	if (unlikely(num_bytes > dev->buf_len)) {
 		dev_err(dev->dev, "%s interrupt can't receive %u byte(s)\n",
@@ -971,6 +987,12 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 {
 	u16 w;
 
+	if (unlikely(dev->receiver)) {
+		dev_err(dev->dev, "%s interrupt while receiving\n",
+			is_xdr ? "XDR" : "XRDY");
+		num_bytes = 0;
+	}
+
 	if (unlikely(num_bytes > dev->buf_len)) {
 		dev_err(dev->dev, "%s interrupt can't transmit %u byte(s)\n",
 			is_xdr ? "XDR" : "XRDY", (num_bytes - dev->buf_len));
@@ -1043,12 +1065,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 		stat &= bits;
 
-		/* If we're in receiver mode, ignore XDR/XRDY */
-		if (dev->receiver)
-			stat &= ~(OMAP_I2C_STAT_XDR | OMAP_I2C_STAT_XRDY);
-		else
-			stat &= ~(OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_RRDY);
-
 		if (!stat) {
 			/* my work here is done */
 			goto out;
-- 
1.7.9.5
