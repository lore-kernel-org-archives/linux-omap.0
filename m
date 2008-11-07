From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-git] twl4030-core: allow reading entire register banks
Date: Fri, 7 Nov 2008 14:00:03 -0800
Message-ID: <200811071400.04181.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:23949 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751522AbYKGWPM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 17:15:12 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Minor change to the TWL4030 utility interface:  support reads
of all 256 bytes in each register bank (vs just 255).  This
can help when debugging, but is otherwise a NOP.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-core.c  |    4 ++--
 include/linux/i2c/twl4030.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -233,7 +233,7 @@ extern void twl4030_power_init(struct tw
  *
  * Returns the result of operation - 0 is success
  */
-int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
+int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
 	int ret;
 	int sid;
@@ -282,7 +282,7 @@ EXPORT_SYMBOL(twl4030_i2c_write);
  *
  * Returns result of operation - num_bytes is success else failure.
  */
-int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes)
+int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 {
 	int ret;
 	u8 val;
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -78,8 +78,8 @@ int twl4030_i2c_read_u8(u8 mod_no, u8 *v
  * IMPORTANT:  For twl4030_i2c_write(), allocate num_bytes + 1
  * for the value, and populate your data starting at offset 1.
  */
-int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
-int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
+int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
+int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
 /*----------------------------------------------------------------------*/
 
