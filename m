From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: omap: fix i207 errata handling
Date: Fri, 21 Nov 2014 04:16:51 +0400
Message-ID: <1416529011-21803-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

commit 6d9939f651419a63e091105663821f9c7d3fec37 (i2c: omap: split out [XR]DR
and [XR]RDY) changed the way how errata i207 (I2C: RDR Flag May Be Incorrectly
Set) get handled. 6d9939f6514 code doesn't correspond to workaround provided by
errata.

According to errata ISR must filter out spurious RDR before data read not after.
ISR must read RXSTAT to get number of bytes available to read. Because RDR
could be set while there could no data in the receive FIFO.

Restored pre 6d9939f6514 way of handling errata.

Found by code review. Real impact haven't seen.
Tested on Beagleboard XM C.

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Fixes: 6d9939f651419a63e09110 i2c: omap: split out [XR]DR and [XR]RDY
---
 drivers/i2c/busses/i2c-omap.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 90dcc2e..e7cbcb0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -958,11 +958,13 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 			if (dev->fifo_size)
 				num_bytes = dev->buf_len;
 
-			omap_i2c_receive_data(dev, num_bytes, true);
-
-			if (dev->errata & I2C_OMAP_ERRATA_I207)
+			if (dev->errata & I2C_OMAP_ERRATA_I207) {
 				i2c_omap_errata_i207(dev, stat);
+				num_bytes = (omap_i2c_read_reg(dev,
+					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
+			}
 
+			omap_i2c_receive_data(dev, num_bytes, true);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
 			continue;
 		}
-- 
1.7.9.5
