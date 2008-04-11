From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 04/23] I2C: TWL4030: checkpatch.pl fixes to tlw4030.h
Date: Fri, 11 Apr 2008 11:28:17 +0300
Message-ID: <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40649 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbYDKIaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:07 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8Tqeb015773
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:04 +0300
In-Reply-To: <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 include/linux/i2c/twl4030.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index fc11fd0..2452282 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -107,14 +107,14 @@
  * It is the caller's responsibility to ensure sane values
  */
 int twl4030_i2c_write_u8(u8 mod_no, u8 val, u8 reg);
-int twl4030_i2c_read_u8(u8 mod_no, u8* val, u8 reg);
+int twl4030_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
 
  /*
   * i2c_write: IMPORTANT - Allocate value num_bytes+1 and valid data starts at
   *		Offset 1.
   */
-int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
-int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes);
+int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
+int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
 
 /*
  * Exported TWL4030 GPIO APIs
-- 
1.5.5.23.g2a5fe

