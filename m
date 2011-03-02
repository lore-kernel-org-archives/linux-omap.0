From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v8 4/7] omap3: pm: TWL5030 version checking
Date: Wed,  2 Mar 2011 19:00:50 +0530
Message-ID: <1299072653-13414-5-git-send-email-leslyam@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1CBNbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 08:31:09 -0500
In-Reply-To: <1299072653-13414-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Added api to get the TWL5030 Si version from the IDCODE register.
It is used for enabling the workaround for TWL errata 27.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl-core.c  |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h |   17 ++++++++++++-
 2 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a35fa7d..5e706d7 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -229,6 +229,9 @@
 /* is driver active, bound to a chip? */
 static bool inuse;
 
+/* TWL IDCODE Register value */
+static u32 twl_idcode;
+
 static unsigned int twl_id;
 unsigned int twl_rev(void)
 {
@@ -487,6 +490,61 @@ EXPORT_SYMBOL(twl_i2c_read_u8);
 
 /*----------------------------------------------------------------------*/
 
+/**
+ * twl_read_idcode_register - api to read the IDCODE register.
+ * @value: returns 32 bit IDCODE register value.
+ *
+ * Unlocks the IDCODE register and read the 32 bit value.
+ */
+int twl_read_idcode_register(void)
+{
+	int err;
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_INTBR, TWL_EEPROM_R_UNLOCK,
+						REG_UNLOCK_TEST_REG);
+	if (err) {
+		pr_err("TWL4030 Unable to unlock IDCODE registers\n");
+		goto fail;
+	}
+
+	err = twl_i2c_read(TWL4030_MODULE_INTBR, (u8 *)(&twl_idcode),
+						REG_IDCODE_7_0, 4);
+	if (err) {
+		pr_err("TWL4030: unable to read IDCODE -%d\n", err);
+		goto fail;
+	}
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_INTBR, 0x0, REG_UNLOCK_TEST_REG);
+	if (err) {
+		pr_err("TWL4030 Unable to relock IDCODE registers\n");
+		goto fail;
+	}
+fail:
+	return err;
+}
+
+/**
+ * twl_get_si_type - api to get TWL Si type.
+ *
+ * Api to get the TWL Si type from IDCODE value.
+ */
+int twl_get_si_type(void)
+{
+	return TWL_SIL_TYPE(twl_idcode);
+}
+EXPORT_SYMBOL(twl_get_si_type);
+
+/**
+ * twl_get_si_version - api to get TWL Si version.
+ *
+ * Api to get the TWL Si version from IDCODE value.
+ */
+int twl_get_si_version(void)
+{
+	return TWL_SIL_REV(twl_idcode);
+}
+EXPORT_SYMBOL(twl_get_si_version);
+
 static struct device *
 add_numbered_child(unsigned chip, const char *name, int num,
 		void *pdata, unsigned pdata_len,
@@ -1056,6 +1114,9 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* setup clock framework */
 	clocks_init(&client->dev, pdata->clock);
 
+	/* read TWL IDCODE Register */
+	twl_read_idcode_register();
+
 	/* load power event scripts */
 	if (twl_has_power() && pdata->power)
 		twl4030_power_init(pdata->power);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f4bd475..d3cc2ac 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -150,7 +150,12 @@
 #define MMC_PU				(0x1 << 3)
 #define MMC_PD				(0x1 << 2)
 
-
+#define TWL_SIL_TYPE(rev)		((rev) & 0x00FFFFFF)
+#define TWL_SIL_REV(rev)		((rev) >> 24)
+#define TWL_SIL_5030			0x09002F
+#define TWL5030_REV_1_0			0x00
+#define TWL5030_REV_1_1			0x10
+#define TWL5030_REV_1_2			0x30
 
 #define TWL4030_CLASS_ID 		0x4030
 #define TWL6030_CLASS_ID 		0x6030
@@ -180,6 +185,9 @@ int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
 int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
+int twl_get_si_type(void);
+int twl_get_si_version(void);
+
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 
@@ -279,7 +287,12 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
  *(Use TWL_4030_MODULE_INTBR)
  */
 
+#define REG_IDCODE_7_0			0x00
+#define REG_IDCODE_15_8			0x01
+#define REG_IDCODE_16_23		0x02
+#define REG_IDCODE_31_24		0x03
 #define REG_GPPUPDCTR1			0x0F
+#define REG_UNLOCK_TEST_REG		0x12
 
 /*I2C1 and I2C4(SR) SDA/SCL pull-up control bits */
 
@@ -288,6 +301,8 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 #define SR_I2C_SCL_CTRL_PU		BIT(4)
 #define SR_I2C_SDA_CTRL_PU		BIT(6)
 
+#define TWL_EEPROM_R_UNLOCK		0x49
+
 /*----------------------------------------------------------------------*/
 
 /*
-- 
1.7.1

