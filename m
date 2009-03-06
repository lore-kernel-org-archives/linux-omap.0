From: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Fri,  6 Mar 2009 15:34:53 +0200
Message-ID: <187aef71c7b1862caf6fe6a935ed94cdb64ca3fd.1236345858.git.Ext-Ari.Kauppi@nokia.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1236345858.git.Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

The number of bytes to be received is read from wrong
place with all OMAPs with highspeed I2C support,
which involves a FIFO and BUFSTAT_REG. It is the 6
bits starting from the bit 8 in the BUFSTAT_REG
that indicate this amount of bytes to be read.
Moreover, only the 6 LSB:s are relevant for the
TXSTAT field.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index be8ee2c..0c3ed41 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -675,8 +675,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
 				else
-					num_bytes = omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG);
+					num_bytes = (omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG)
+							>> 8) & 0x3F;
 			}
 			while (num_bytes) {
 				num_bytes--;
@@ -714,8 +715,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				if (stat & OMAP_I2C_STAT_XRDY)
 					num_bytes = dev->fifo_size;
 				else
-					num_bytes = omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG);
+					num_bytes = (omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG))
+							& 0x3F;
 			}
 			while (num_bytes) {
 				num_bytes--;
-- 
1.5.6.5
