From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 21/22] i2c: omap: no need to reinitialize "stat"
Date: Wed, 13 Jun 2012 18:51:10 +0300
Message-ID: <1339602671-8431-22-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:43954 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754302Ab2FMPyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:54:16 -0400
Received: by lban1 with SMTP id n1so1255607lba.38
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:54:14 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we will already loop again and that variable
will be reinitialized at the beginning of the
loop.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f2ab95a..492e340 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -965,7 +965,6 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 				num_bytes = dev->buf_len;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
 				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
@@ -985,7 +984,6 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 				num_bytes = dev->fifo_size;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
 				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
-- 
1.7.10.4

