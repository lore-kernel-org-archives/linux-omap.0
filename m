From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH] i2c: omap: fix draining irq handling
Date: Sun, 20 Jan 2013 20:37:02 +0200
Message-ID: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit 0bdfe0cb803dce699ff337c35d8e97ac355fa417 (i2c: omap: sanitize
exit path) changed the interrupt handler to exit early and complete
the transfer after the draining IRQ is handled. As a result, the ARDY
may not be cleared properly, and it may cause all future I2C transfers
to timeout with "timeout waiting for bus ready". This is reproducible
at least with N900 when twl4030_gpio makes a long write (> FIFO size)
during the probe (http://marc.info/?l=linux-omap&m=135818882610432&w=2).

The fix is to continue until we get ARDY interrupt that completes the
transfer. Tested with 3.8-rc4 + N900: 20 boots in a row without errors;
without the patch the problem triggers after few reboots.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 832f16e..4cc2f05 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -963,7 +963,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 				i2c_omap_errata_i207(dev, stat);
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
-			break;
+			continue;
 		}
 
 		if (stat & OMAP_I2C_STAT_RRDY) {
@@ -989,7 +989,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 				break;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
-			break;
+			continue;
 		}
 
 		if (stat & OMAP_I2C_STAT_XRDY) {
-- 
1.7.10.4
