From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 18/18] i2c: omap: remove redundant status read
Date: Tue, 3 Jul 2012 20:07:56 +0530
Message-ID: <1341326276-25434-19-git-send-email-shubhrajyoti@ti.com>
References: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab2GCOks (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 10:40:48 -0400
In-Reply-To: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Remove the redundant read of the status register.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
v4:Patch addition(fixes a review comment)

 drivers/i2c/busses/i2c-omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8940eb3..b1a32f8 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -965,7 +965,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				num_bytes = dev->buf_len;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
 				goto out;
 
@@ -981,7 +980,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 				num_bytes = dev->threshold;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
 				goto out;
 
-- 
1.7.5.4

