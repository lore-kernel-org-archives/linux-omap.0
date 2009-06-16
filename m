From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Remove duplicate definitions
Date: Tue, 16 Jun 2009 16:44:52 +0530
Message-ID: <1245150892-5837-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56598 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbZFPLO5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2009 07:14:57 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBErgF030738
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:14:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fixes the duplicate definitions of KEY and PERSISTENT_KEY
leading to these compile-time warnings:

In file included from arch/arm/mach-omap2/board-omap3evm.c:39:
arch/arm/plat-omap/include/mach/keypad.h:38:1: warning: "KEY" redefined
In file included from arch/arm/mach-omap2/board-omap3evm.c:27:
include/linux/i2c/twl4030.h:341:1: warning: this is the location of the previous definition
In file included from arch/arm/mach-omap2/board-omap3evm.c:39:
arch/arm/plat-omap/include/mach/keypad.h:39:1: warning: "PERSISTENT_KEY" redefined
In file included from arch/arm/mach-omap2/board-omap3evm.c:27:
include/linux/i2c/twl4030.h:342:1: warning: this is the location of the previous definition

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 include/linux/i2c/twl4030.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 87accda..21e65bf 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -333,14 +333,6 @@ struct twl4030_madc_platform_data {
 	int		irq_line;
 };
 
-/* Boards have uniqe mappings of {col, row} --> keycode.
- * Column and row are 4 bits, but range only from 0..7;
- * a PERSISTENT_KEY is "always on" and never reported.
- */
-#define KEY_PERSISTENT		0x00800000
-#define KEY(col, row, keycode)	(((col) << 28) | ((row) << 24) | (keycode))
-#define PERSISTENT_KEY(c, r)	KEY(c, r, KEY_PERSISTENT)
-
 struct twl4030_keypad_data {
 	unsigned rows;
 	unsigned cols;
-- 
1.6.2.2

