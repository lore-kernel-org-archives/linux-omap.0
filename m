From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [RFC 1/5] i2c: omap: ack only reported events
Date: Wed,  3 Dec 2014 18:33:58 +0400
Message-ID: <1417617242-16869-2-git-send-email-al.kochet@gmail.com>
References: <1417617242-16869-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417617242-16869-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4563200..53b4234 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1059,7 +1059,11 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
 					OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
+			/*
+			 * These are pending events not handled in time
+			 * due to ISR latency.
+			 */
+			omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_RRDY |
 						OMAP_I2C_STAT_RDR |
 						OMAP_I2C_STAT_XRDY |
 						OMAP_I2C_STAT_XDR |
-- 
1.7.9.5
