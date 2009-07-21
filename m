From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: [PATCH 1/3] [OMAP:I2C]Bug in reading the RXSTAT/TXSTAT values from
 the I2C_BUFFSTAT register
Date: Tue, 21 Jul 2009 10:14:06 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202958D2F87@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbZGUPON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 11:14:13 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Fix bug in reading the I2C_BUFFSTAT register for getting byte count on RX/TX interrupt.

On Interrupt: I2C_STAT[RDR],
	read 'RXSTAT' from I2C_BUFFSTAT[8-13]
On Interrupt: I2C_STAT[XDR]
	read 'TXSTAT' from I2C_BUFFSTAT[0-5]

Signed-off-by: Jagadeesh Pakaravoor<j-pakaravoor@ti.com>
Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
Signed-off-by: Vikram pandita<vikram.pandita@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ad8d201..d280acf 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -692,9 +692,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
-				else
-					num_bytes = omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG);
+				else    /* read RXSTAT on RDR interrupt */
+					num_bytes = (omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG)
+							>> 8) & 0x3F;
 			}
 			while (num_bytes) {
 				num_bytes--;
@@ -731,9 +732,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_XRDY)
 					num_bytes = dev->fifo_size;
-				else
-					num_bytes = omap_i2c_read_reg(dev,
-							OMAP_I2C_BUFSTAT_REG);
+				else    /* read TXSTAT on XDR interrupt */
+					num_bytes = omap_i2c_read_reg(dev,
+							OMAP_I2C_BUFSTAT_REG)
+							& 0x3F;
 			}
 			while (num_bytes) {
 				num_bytes--;
-- 
1.5.6.3

