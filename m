From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [RFC PATCH 2/3] i2c: omap: implement handling for 'actual' bytes transferred
Date: Fri, 29 Jun 2012 16:35:26 +0530
Message-ID: <1340967927-27354-3-git-send-email-shubhrajyoti@ti.com>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51101 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab2F2LGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 07:06:07 -0400
In-Reply-To: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

this is important in cases where client driver
wants to know how many bytes were actually
transferred.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 266bba7..fc726a6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -189,6 +189,7 @@ struct omap_i2c_dev {
 	u8			*buf;
 	u8			*regs;
 	size_t			buf_len;
+	u16			actual;
 	struct i2c_adapter	adapter;
 	u8			threshold;
 	u8			fifo_size;	/* use as flag and value
@@ -601,6 +602,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
 	}
+	msg->actual = dev->actual;
 
 	if (likely(!dev->cmd_err))
 		return 0;
@@ -828,6 +830,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
 		w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 		*dev->buf++ = w;
 		dev->buf_len--;
+		dev->actual++;
 
 		/*
 		 * Data reg in 2430, omap3 and
@@ -848,6 +851,7 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 	while (num_bytes--) {
 		w = *dev->buf++;
 		dev->buf_len--;
+		dev->actual++;
 
 		/*
 		 * Data reg in 2430, omap3 and
@@ -908,6 +912,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
+			dev->actual--;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
 			goto out;
 		}
-- 
1.7.5.4

