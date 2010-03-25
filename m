From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2 2/2] omap i2c: add a timeout to the busy waiting
Date: Thu, 25 Mar 2010 11:52:37 +0200
Message-ID: <1269510757-8119-3-git-send-email-virtuoso@slind.org>
References: <20100316143025.GR2900@atomide.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100316143025.GR2900-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
context, which may lead to kernel hangs. The problem can be reproduced
by running the bus with wrong (too high) speed.

Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: nm-l0cyMroinI0@public.gmane.org
---
 drivers/i2c/busses/i2c-omap.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2d146ac..7d56a25 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -678,6 +678,8 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
  */
 static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(1);
+
 	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
@@ -685,6 +687,12 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev->dev, "timeout waiting on XUDF bit\n");
+			return 0;
+		}
+
 		cpu_relax();
 		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
-- 
1.6.3.3
