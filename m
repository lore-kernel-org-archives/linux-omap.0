From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [RFC/PATCH 3/3] i2c: omap: Add support for I2C_M_STOP message flag
Date: Tue, 26 Jun 2012 16:17:09 +0200
Message-ID: <1340720229-30356-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340720229-30356-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Generate a stop condition after each message marked with I2C_M_STOP.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..cf1bda0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -545,6 +545,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (dev->speed > 400)
 		w |= OMAP_I2C_CON_OPMODE_HS;
 
+	if (msg->flags & I2C_M_STOP)
+		stop = 1;
 	if (msg->flags & I2C_M_TEN)
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
-- 
1.7.3.4
