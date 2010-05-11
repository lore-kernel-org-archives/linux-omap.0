From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/6] omap: i2c: add a timeout to the busy waiting
Date: Tue, 11 May 2010 11:35:17 -0700
Message-ID: <20100511183517.15596.6282.stgit@baageli.muru.com>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511182854.15596.56293.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>

The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
context, which may lead to kernel hangs. The problem can be reproduced
by running the bus with wrong (too high) speed.

Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ef73483..00fd02e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -763,17 +763,25 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
  */
 static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 {
-	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
+	unsigned long timeout = 10000;
+
+	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
 			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
+
 		cpu_relax();
 		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
 
+	if (!timeout) {
+		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
+		return 0;
+	}
+
 	return 0;
 }
 
