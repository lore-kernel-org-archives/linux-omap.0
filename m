From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 6/7] i2c: add 'transferred' field to struct i2c_msg
Date: Thu, 25 Oct 2012 15:25:14 +0300
Message-ID: <1351167915-15079-7-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383Ab2JYMb3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 08:31:29 -0400
In-Reply-To: <1351167915-15079-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Benoit Cousson <b-cousson@ti.com>, w.sang@pengutronix.de, ben-linux@fluff.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, michael@amarulasolutions.com, Felipe Balbi <balbi@ti.com>

From: Shubhrajyoti D <shubhrajyoti@ti.com>

In case of a NACK, it's wise to tell our clients
drivers about how many bytes were actually transferred.

Support this by adding an extra field to the struct
i2c_msg which gets incremented the amount of bytes
actually transferred.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/uapi/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 0e949cb..4b35c9b 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -77,6 +77,7 @@ struct i2c_msg {
 #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
 	__u16 len;		/* msg length				*/
+	__u16 transferred;	/* actual bytes transferred             */
 	__u8 *buf;		/* pointer to msg data			*/
 };
 
-- 
1.8.0

