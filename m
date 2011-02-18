From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 09/12] omap3: pm: TWL5030 version checking
Date: Fri, 18 Feb 2011 22:38:55 +0530
Message-ID: <1298048938-1480-10-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34798 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab1BRRJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:09:22 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
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
 drivers/mfd/twl-core.c  |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h |   10 +++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a35fa7d..211c2cc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -487,6 +487,56 @@ EXPORT_SYMBOL(twl_i2c_read_u8);
 
 /*----------------------------------------------------------------------*/
 
+/**
+ * twl_read_idcode_register - api to read the IDCODE register.
+ * @value: returns 32 bit IDCODE register value.
+ *
+ * Unlocks the IDCODE register and read the 32 bit value.
+ */
+int twl_read_idcode_register(u32 *value)
+{
+	int err = 0;
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_INTBR, TWL_EEPROM_R_UNLOCK,
+						R_UNLOCK_TEST_REG);
+	if (err)
+		pr_err("TWL4030 Unable to unlock IDCODE registers\n");
+
+	err = twl_i2c_read(TWL4030_MODULE_INTBR, (u8 *)(value),
+							0x0, 4);
+	if (err)
+		pr_err("TWL4030: unable to read IDCODE-%d\n", err);
+
+	err = twl_i2c_write_u8(TWL4030_MODULE_INTBR, 0x0, R_UNLOCK_TEST_REG);
+	if (err)
+		pr_err("TWL4030 Unable to relock IDCODE registers\n");
+
+	return err;
+}
+
+/**
+ * twl5030_get_si_ver - api to get TWL5030 Si version.
+ * @value: returns Si version from IDCODE.
+ *
+ * Api to get the TWL5030 Si version from IDCODE value.
+ */
+int twl5030_get_si_ver(u32 *value)
+{
+	int ret = 0;
+	static u32 twl_idcode;
+
+	if (twl_idcode == 0)
+		ret = twl_read_idcode_register(&twl_idcode);
+	if (ret)
+		pr_err("TWL4030 Unable to check Si version\n");
+
+	if (TWL_SIL_TYPE(twl_idcode) == TWL_SIL_5030)
+		*value = TWL_SIL_REV(twl_idcode);
+
+	return ret;
+}
+EXPORT_SYMBOL(twl5030_get_si_ver);
+
 static struct device *
 add_numbered_child(unsigned chip, const char *name, int num,
 		void *pdata, unsigned pdata_len,
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f4bd475..5d3f2bf 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -150,7 +150,15 @@
 #define MMC_PU				(0x1 << 3)
 #define MMC_PD				(0x1 << 2)
 
+#define R_UNLOCK_TEST_REG	0x12
+#define TWL_EEPROM_R_UNLOCK	0x49
 
+#define TWL_SIL_TYPE(rev)	((rev) & 0x00FFFFFF)
+#define TWL_SIL_REV(rev)	((rev) >> 24)
+#define TWL_SIL_5030		0x09002F
+#define TWL5030_REV_1_0		0x00
+#define TWL5030_REV_1_1		0x10
+#define TWL5030_REV_1_2		0x30
 
 #define TWL4030_CLASS_ID 		0x4030
 #define TWL6030_CLASS_ID 		0x6030
@@ -180,6 +188,8 @@ int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
 int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
+int twl5030_get_si_ver(u32 *value);
+
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 
-- 
1.7.1

