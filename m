From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/6] i2c: omap: improve 'rev' a little bit
Date: Wed, 23 Jan 2013 12:23:05 +0200
Message-ID: <1358936588-16375-4-git-send-email-balbi@ti.com>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39849 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488Ab3AWKXm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jan 2013 05:23:42 -0500
In-Reply-To: <1358936588-16375-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, Felipe Balbi <balbi@ti.com>

a later patch will use scheme detection at
another part of the code, but current scheme
detection implementation relies on the fact that
we still hold scheme on the first 16 bits of our
rev variable, which won't be true as soon as
we move away from probe() because we left shift
it by 16 in case of newer IP versions in order
to fit other revision data in the lower 16 bits.

To fix that, we are changing scheme implementation
to assume scheme is always placed on the top 16
bits.

While at that, also move those macro definitions
to the top of the source file, where they should've
been to start with, because a later patch will use
them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 53985b4..c75ba13 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -60,6 +60,17 @@
 /* timeout for pm runtime autosuspend */
 #define OMAP_I2C_PM_TIMEOUT		1000	/* ms */
 
+#define OMAP_I2C_SCHEME(rev)		((rev & 0xc0000000) >> 30)
+
+#define OMAP_I2C_SCHEME_0		0
+#define OMAP_I2C_SCHEME_1		1
+
+#define OMAP_I2C_REV_SCHEME_0_MAJOR(rev) (rev >> 4)
+#define OMAP_I2C_REV_SCHEME_0_MINOR(rev) (rev & 0xf)
+
+#define OMAP_I2C_REV_SCHEME_1_MAJOR(rev) ((rev & 0x0700) >> 7)
+#define OMAP_I2C_REV_SCHEME_1_MINOR(rev) (rev & 0x1f)
+
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
 enum {
 	OMAP_I2C_REV_REG = 0,
@@ -1058,16 +1069,6 @@ static const struct of_device_id omap_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 #endif
 
-#define OMAP_I2C_SCHEME(rev)		((rev & 0xc000) >> 14)
-
-#define OMAP_I2C_REV_SCHEME_0_MAJOR(rev) (rev >> 4)
-#define OMAP_I2C_REV_SCHEME_0_MINOR(rev) (rev & 0xf)
-
-#define OMAP_I2C_REV_SCHEME_1_MAJOR(rev) ((rev & 0x0700) >> 7)
-#define OMAP_I2C_REV_SCHEME_1_MINOR(rev) (rev & 0x1f)
-#define OMAP_I2C_SCHEME_0		0
-#define OMAP_I2C_SCHEME_1		1
-
 static int
 omap_i2c_probe(struct platform_device *pdev)
 {
@@ -1158,7 +1159,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	 * Also since the omap_i2c_read_reg uses reg_map_ip_* a
 	 * raw_readw is done.
 	 */
-	rev = __raw_readw(dev->base + 0x04);
+	rev = __raw_readw(dev->base + 0x04) << 16;
 
 	scheme = OMAP_I2C_SCHEME(rev);
 	switch (scheme) {
@@ -1172,8 +1173,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		/* FALLTHROUGH */
 	default:
 		dev->regs = (u8 *)reg_map_ip_v2;
-		rev = (rev << 16) |
-			omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
+		rev |= omap_i2c_read_reg(dev, OMAP_I2C_IP_V2_REVNB_LO);
 		minor = OMAP_I2C_REV_SCHEME_1_MINOR(rev);
 		major = OMAP_I2C_REV_SCHEME_1_MAJOR(rev);
 		dev->rev = rev;
-- 
1.8.1.rc1.5.g7e0651a

