From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] TWL4030: convert old-style function documentation to
	current kerneldoc
Date: Thu, 17 Jul 2008 20:15:51 -0600
Message-ID: <20080718021550.31884.69436.stgit@localhost.localdomain>
References: <20080718021356.31884.9848.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44362 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbYGRCQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 22:16:37 -0400
In-Reply-To: <20080718021356.31884.9848.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Several functions use old-style function documentation; convert those to
use the current kerneldoc style.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   54 ++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 54e392b..4104fd2 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -389,17 +389,18 @@ static struct irq_chip twl4030_irq_chip = {
 };
 
 /* Global Functions */
-/*
- * @brief twl4030_i2c_write - Writes a n bit register in TWL4030
+
+/**
+ * twl4030_i2c_write - Writes a n bit register in TWL4030
+ * @mod_no: module number
+ * @value: an array of num_bytes+1 containing data to write
+ * @reg: register address (just offset will do)
+ * @num_bytes: number of bytes to transfer
  *
- * @param mod_no - module number
- * @param *value - an array of num_bytes+1 containing data to write
- * IMPORTANT - Allocate value num_bytes+1 and valid data starts at
- *		 Offset 1.
- * @param reg - register address (just offset will do)
- * @param num_bytes - number of bytes to transfer
+ * IMPORTANT: for 'value' parameter: Allocate value num_bytes+1 and
+ * valid data starts at Offset 1.
  *
- * @return result of operation - 0 is success
+ * Results the result of operation - 0 is success
  */
 int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
 {
@@ -443,14 +444,13 @@ int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
 EXPORT_SYMBOL(twl4030_i2c_write);
 
 /**
- * @brief twl4030_i2c_read - Reads a n bit register in TWL4030
+ * twl4030_i2c_read - Reads a n bit register in TWL4030
+ * @mod_no: module number
+ * @value: an array of num_bytes containing data to be read
+ * @reg: register address (just offset will do)
+ * @num_bytes: number of bytes to transfer
  *
- * @param mod_no - module number
- * @param *value - an array of num_bytes containing data to be read
- * @param reg - register address (just offset will do)
- * @param num_bytes - number of bytes to transfer
- *
- * @return result of operation - num_bytes is success else failure.
+ * Returns result of operation - num_bytes is success else failure.
  */
 int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
 {
@@ -497,13 +497,12 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
 EXPORT_SYMBOL(twl4030_i2c_read);
 
 /**
- * @brief twl4030_i2c_write_u8 - Writes a 8 bit register in TWL4030
- *
- * @param mod_no - module number
- * @param value - the value to be written 8 bit
- * @param reg - register address (just offset will do)
+ * twl4030_i2c_write_u8 - Writes a 8 bit register in TWL4030
+ * @mod_no: module number
+ * @value: the value to be written 8 bit
+ * @reg: register address (just offset will do)
  *
- * @return result of operation - 0 is success
+ * Returns result of operation - 0 is success
  */
 int twl4030_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
 {
@@ -517,13 +516,12 @@ int twl4030_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
 EXPORT_SYMBOL(twl4030_i2c_write_u8);
 
 /**
- * @brief twl4030_i2c_read_u8 - Reads a 8 bit register from TWL4030
- *
- * @param mod_no - module number
- * @param *value - the value read 8 bit
- * @param reg - register address (just offset will do)
+ * twl4030_i2c_read_u8 - Reads a 8 bit register from TWL4030
+ * @mod_no: module number
+ * @value: the value read 8 bit
+ * @reg: register address (just offset will do)
  *
- * @return result of operation - 0 is success
+ * Returns result of operation - 0 is success
  */
 int twl4030_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
 {


