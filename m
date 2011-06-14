From: Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] ARM: OMAP2+ i2c NACK without STP
Date: Tue, 14 Jun 2011 12:54:13 +0200
Message-ID: <1308048853-21911-1-git-send-email-j.weitzel@phytec.de>
References: <20110614102409.GN3352@atomide.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110614102409.GN3352-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On OMAP4 OMAP_I2C_STAT_NACK is causing a timeout on the next access.
The isr cleans all flags in OMAP_I2C_CON_REG by setting OMAP_I2C_CON_STP
OMAP_I2C_CON_STP is also set in omap_i2c_xfer_msg on the last message.

According to the TI TSR the sequence for OMAP_I2C_STAT_NACK and
OMAP_I2C_STAT_AL are nearly the same.
Removing the OMAP_I2C_CON_STP part in the isr fix the problem.
Tested on OMAP4430 and OMAP3530 (here NACK was not a problem)
Fixes also booting on 2430sdp.

Signed-off-by: Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 58a58c7..670f2a2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -836,11 +836,9 @@ complete:
 				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
 				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 
-		if (stat & OMAP_I2C_STAT_NACK) {
+		if (stat & OMAP_I2C_STAT_NACK)
 			err |= OMAP_I2C_STAT_NACK;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
-					   OMAP_I2C_CON_STP);
-		}
+
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
-- 
1.7.0.4
