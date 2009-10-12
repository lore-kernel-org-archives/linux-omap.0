From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
Date: Mon, 12 Oct 2009 13:21:25 +0300
Message-ID: <1255342885-15786-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54564 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbZJLKXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 06:23:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org, linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, j-pakaravoor@ti.com

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Include wake up events for receiver overflow and transmitter
underflow in OMAP_I2C_WE_REG configuration. Also fix a small
typo.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 827da08..34ea9ed 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -92,8 +92,10 @@
 #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
 
 /* I2C WE wakeup enable register */
-#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
+#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
 #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
+#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
+#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */
 #define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
 #define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
 #define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
@@ -104,6 +106,7 @@
 #define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
 
 #define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
+				OMAP_I2C_WE_ROVR_WE | OMAP_I2C_WE_XUDF_WE | \
 				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
 				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
 				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
-- 
1.6.0.4

