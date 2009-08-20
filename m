From: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] i2c-omap: Enable workaround for Errata 1.153 based on
Date: Thu, 20 Aug 2009 11:21:16 -0500
Message-ID: <1250785276-31713-4-git-send-email-m-sonasath@ti.com>
References: <1250785276-31713-1-git-send-email-m-sonasath@ti.com>
 <1250785276-31713-2-git-send-email-m-sonasath@ti.com>
 <1250785276-31713-3-git-send-email-m-sonasath@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250785276-31713-3-git-send-email-m-sonasath-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Silicon Errata 1.153 has been fixed on OMAP 3630|4430 with the use of a later
version of I2C IP block.

The errata impacts OMAP 2420|2430|3430, enable the workaround for these based 
on I2C IP block revision number instead of OMAP CPU type

Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org
Reviewed-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 16b39f4..827da08 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -784,7 +784,7 @@ complete:
 				 * memory to the I2C interface.
 				 */
 
-				if (cpu_is_omap34xx()) {
+				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
 						while (!(stat & OMAP_I2C_STAT_XUDF)) {
 							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-- 
1.5.6.3
