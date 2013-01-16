From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 11/11] mfd: twl-core: Move twl_i2c_read/write_u8 to header as inline function
Date: Wed, 16 Jan 2013 14:53:59 +0100
Message-ID: <1358344439-23017-12-git-send-email-peter.ujfalusi@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

twl_i2c_read/write_u8 become as a simple wrapper over the twl_i2c_read/write.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c  | 28 ----------------------------
 include/linux/i2c/twl.h | 17 +++++++++++------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 9661204..557f9ee 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -379,34 +379,6 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 }
 EXPORT_SYMBOL(twl_i2c_read);
 
-/**
- * twl_i2c_write_u8 - Writes a 8 bit register in TWL4030/TWL5030/TWL60X0
- * @mod_no: module number
- * @value: the value to be written 8 bit
- * @reg: register address (just offset will do)
- *
- * Returns result of operation - 0 is success
- */
-int twl_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
-{
-	return twl_i2c_write(mod_no, &value, reg, 1);
-}
-EXPORT_SYMBOL(twl_i2c_write_u8);
-
-/**
- * twl_i2c_read_u8 - Reads a 8 bit register from TWL4030/TWL5030/TWL60X0
- * @mod_no: module number
- * @value: the value read 8 bit
- * @reg: register address (just offset will do)
- *
- * Returns result of operation - 0 is success
- */
-int twl_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
-{
-	return twl_i2c_read(mod_no, value, reg, 1);
-}
-EXPORT_SYMBOL(twl_i2c_read_u8);
-
 /*----------------------------------------------------------------------*/
 
 /**
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index e441fd8..488debb 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -175,17 +175,22 @@ TWL_CLASS_IS(4030, TWL4030_CLASS_ID)
 TWL_CLASS_IS(6030, TWL6030_CLASS_ID)
 
 /*
- * Read and write single 8-bit registers
- */
-int twl_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
-int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
-
-/*
  * Read and write several 8-bit registers at once.
  */
 int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
+/*
+ * Read and write single 8-bit registers
+ */
+static inline int twl_i2c_write_u8(u8 mod_no, u8 val, u8 reg) {
+	return twl_i2c_write(mod_no, &val, reg, 1);
+}
+
+static inline int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg) {
+	return twl_i2c_read(mod_no, val, reg, 1);
+}
+
 int twl_get_type(void);
 int twl_get_version(void);
 int twl_get_hfclk_rate(void);
-- 
1.8.1
