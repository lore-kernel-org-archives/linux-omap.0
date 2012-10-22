From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
Date: Mon, 22 Oct 2012 12:46:57 +0300
Message-ID: <1350899218-13624-8-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350899218-13624-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

In case of a NACK, it's wise to tell our clients
drivers about how many bytes were actually transferred.

Support this by adding an extra field to the struct
i2c_msg which gets incremented the amount of bytes
actually transferred.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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
1.8.0.rc0
