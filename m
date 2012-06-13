From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 20/22] i2c: omap: avoid unnecessary register read
Date: Wed, 13 Jun 2012 18:51:09 +0300
Message-ID: <1339602671-8431-21-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50115 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754335Ab2FMPyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:54:23 -0400
Received: by lbbgh12 with SMTP id gh12so1485451lbb.11
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:54:08 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

dev->buf_len will always contain the correct
number we're looking for. No need to read
from BUFSTAT register.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5a7a223..f2ab95a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -934,18 +934,15 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 		if (stat & OMAP_I2C_STAT_RDR) {
 			u8 num_bytes = 1;
 
-			if (dev->errata & I2C_OMAP_ERRATA_I207)
-				i2c_omap_errata_i207(dev, stat);
-
-			if (dev->fifo_size) {
-				num_bytes = omap_i2c_read_reg(dev,
-						OMAP_I2C_BUFSTAT_REG);
-				num_bytes >>= 8;
-				num_bytes &= 0x3f;
-			}
+			if (dev->fifo_size)
+				num_bytes = dev->buf_len;
 
 			omap_i2c_receive_data(dev, num_bytes, true);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
+
+			if (dev->errata & I2C_OMAP_ERRATA_I207)
+				i2c_omap_errata_i207(dev, stat);
+
 			continue;
 		}
 
@@ -964,11 +961,8 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 			int ret;
 			u8 num_bytes = 1;
 
-			if (dev->fifo_size) {
-				num_bytes = omap_i2c_read_reg(dev,
-						OMAP_I2C_BUFSTAT_REG);
-				num_bytes &= 0x3f;
-			}
+			if (dev->fifo_size)
+				num_bytes = dev->buf_len;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-- 
1.7.10.4

