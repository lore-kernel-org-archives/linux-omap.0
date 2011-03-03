From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] mfd: TWL6030: Fix buggy burst read in TWL6030 ES1.0
Date: Thu,  3 Mar 2011 18:28:34 +0530
Message-ID: <1299157114-19381-3-git-send-email-balajitk@ti.com>
References: <1299157114-19381-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39360 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757762Ab1CCMzu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 07:55:50 -0500
In-Reply-To: <1299157114-19381-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, linux-omap@vger.kernel.org
Cc: leslyam@ti.com, paul@pwsan.com, Balaji T K <balajitk@ti.com>

Convert multi byte i2c read to several single byte i2c read as workaround.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mfd/twl-core.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index cd0ce54..b4cfba3 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -224,6 +224,9 @@
 #define TWL5031			BIT(2)  /* twl5031 has different registers */
 #define TWL6030_CLASS		BIT(3)	/* TWL6030 class */
 
+static int errata;
+#define ERRATA_107890		(1 << 0) /* Buggy burst read at 400 KHz */
+
 /*----------------------------------------------------------------------*/
 
 /* is driver active, bound to a chip? */
@@ -405,7 +408,7 @@ EXPORT_SYMBOL(twl_i2c_write);
  *
  * Returns result of operation - num_bytes is success else failure.
  */
-int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
+static int twl_i2c_read_burst(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
 	int ret;
 	u8 val;
@@ -453,6 +456,29 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		return 0;
 	}
 }
+
+int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
+{
+	int ret = 0, i = 0;
+
+	/*
+	 * Glitch in the I2C Data line when the I2C controller
+	 * performs a Burst Read at I2C bus speed of 400KHz
+	 * This glitch causes burst read to fail in Phoenix TWL6030 ES1.0
+	 * Convert multi byte read to byte read if burst read is buggy
+	 */
+	if (errata & ERRATA_107890) {
+		for (i = 0; i < num_bytes; i++)
+			ret = twl_i2c_read_burst(mod_no, value + i,
+								reg + i, 1);
+			if (ret)
+				return ret;
+	} else {
+		ret = twl_i2c_read_burst(mod_no, value, reg, num_bytes);
+	}
+
+	return ret;
+}
 EXPORT_SYMBOL(twl_i2c_read);
 
 /**
@@ -484,7 +510,7 @@ EXPORT_SYMBOL(twl_i2c_write_u8);
  */
 int twl_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
 {
-	return twl_i2c_read(mod_no, value, reg, 1);
+	return twl_i2c_read_burst(mod_no, value, reg, 1);
 }
 EXPORT_SYMBOL(twl_i2c_read_u8);
 
@@ -1065,6 +1091,7 @@ static void __devinit twl6030_check_version(void)
 	switch (es_id) {
 	case 0:
 		sprintf(es_version, "%s", "1.0");
+		errata = ERRATA_107890;
 		break;
 	case 1:
 	default:
-- 
1.7.0.4

