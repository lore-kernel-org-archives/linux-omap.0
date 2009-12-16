From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 2/2] omap i2c: add a timeout to the busy waiting
Date: Wed, 16 Dec 2009 15:46:38 +0200
Message-ID: <1260971198-28549-1-git-send-email-virtuoso@slind.org>
References: <1260970986-26613-3-git-send-email-virtuoso@slind.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260970986-26613-3-git-send-email-virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
context, which may lead to kernel hangs. The problem can be reproduced
by running the bus with wrong (too high) speed.

Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-omap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ad8242a..b474c20 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -678,7 +678,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
  */
 static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
 {
-	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
+	unsigned long timeout = 10000;
+
+	while (!(*stat & OMAP_I2C_STAT_XUDF && --timeout)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
@@ -689,6 +691,9 @@ static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
 
+	if (!timeout)
+		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
+
 	return 0;
 }
 
-- 
1.6.3.3
