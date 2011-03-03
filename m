From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] mfd: TWL6030: Add support for version detection
Date: Thu,  3 Mar 2011 18:28:33 +0530
Message-ID: <1299157114-19381-2-git-send-email-balajitk@ti.com>
References: <1299157114-19381-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39362 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab1CCMzv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 07:55:51 -0500
In-Reply-To: <1299157114-19381-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, linux-omap@vger.kernel.org
Cc: leslyam@ti.com, paul@pwsan.com, Balaji T K <balajitk@ti.com>

Print chip version at bootup
pack product id and version id in a way similar to Triton TWL5030
so that twl_get_si_type and twl_get_si_version can be used for TWL6030
Use this to set flags for errata based on particular chip version.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mfd/twl-core.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h |   10 ++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 5e706d7..cd0ce54 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1036,6 +1036,48 @@ int twl4030_init_chip_irq(const char *chip);
 int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
 int twl6030_exit_irq(void);
 
+static void __devinit twl6030_check_version(void)
+{
+	int	ret;
+	u8	es_id = 0;
+	u8	prd_lsb = 0;
+	u8	prd_msb = 0;
+	char	es_version[8];
+
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID2, &es_id, TWL6030_JTAGVERNUM);
+	if (ret < 0) {
+		pr_err("TWL6030 failed to read version register %d\n", ret);
+		return;
+	}
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &prd_lsb,
+					TWL6030_USB_PRODUCT_ID_LSB);
+	if (ret < 0) {
+		pr_err("TWL6030 failed to read product lsb register %d\n", ret);
+		return;
+	}
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &prd_msb,
+					TWL6030_USB_PRODUCT_ID_MSB);
+	if (ret < 0) {
+		pr_err("TWL6030 failed to read product msb register %d\n", ret);
+		return;
+	}
+
+	switch (es_id) {
+	case 0:
+		sprintf(es_version, "%s", "1.0");
+		break;
+	case 1:
+	default:
+		sprintf(es_version, "%s", "2.0");
+		break;
+	}
+	twl_idcode = (es_id << 24) | (prd_msb << 8) | prd_lsb;
+
+	pr_info("TWL6030 version ES%s\n", es_version);
+
+	return;
+}
+
 static int twl_remove(struct i2c_client *client)
 {
 	unsigned i;
@@ -1106,6 +1148,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if ((id->driver_data) & TWL6030_CLASS) {
 		twl_id = TWL6030_CLASS_ID;
 		twl_map = &twl6030_map[0];
+		twl6030_check_version();
 	} else {
 		twl_id = TWL4030_CLASS_ID;
 		twl_map = &twl4030_map[0];
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index ff1f1e0..470dd97 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -793,4 +793,14 @@ static inline int twl4030charger_usb_en(int enable) { return 0; }
 /* INTERNAL LDOs */
 #define TWL6030_REG_VRTC	47
 
+/* TWL6030 - Register offset for i2c slave address 0x48 */
+
+/* TWL6030 - Register offset for i2c slave address 0x49 */
+#define TWL6030_USB_PRODUCT_ID_LSB		0x02
+#define TWL6030_USB_PRODUCT_ID_MSB		0x03
+
+/* TWL6030 - Register offset for i2c slave address 0x4A */
+#define TWL6030_JTAGVERNUM			0x87
+#define TWL6030_EPROM_REV			0xD7
+
 #endif /* End of __TWL4030_H */
-- 
1.7.0.4

