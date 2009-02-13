From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 6/6] arm: omap: n810: add lp5521 platform_data
Date: Fri, 13 Feb 2009 14:43:52 +0200
Message-ID: <1234529032-25354-7-git-send-email-felipe.balbi@nokia.com>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com>
 <1234529032-25354-1-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-2-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-3-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-4-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-5-git-send-email-felipe.balbi@nokia.com>
 <1234529032-25354-6-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49806 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZBMM6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 07:58:38 -0500
In-Reply-To: <1234529032-25354-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

Without it, driver won't probe.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index b38b295..18a0fe7 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/lm8323.h>
 #include <linux/i2c/menelaus.h>
+#include <linux/i2c/lp5521.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -628,6 +629,14 @@ static struct i2c_board_info __initdata n800_i2c_board_info_1[] = {
 	},
 };
 
+static struct lp5521_platform_data n810_lp5521_platform_data = {
+	.mode		= LP5521_MODE_DIRECT_CONTROL,
+	.label		= "n810",
+	.red_present	= true,
+	.green_present	= true,
+	.blue_present	= true,
+};
+
 extern struct tcm825x_platform_data n800_tcm825x_platform_data;
 
 static struct i2c_board_info __initdata_or_module n8x0_i2c_board_info_2[] = {
@@ -657,6 +666,7 @@ static struct i2c_board_info __initdata_or_module n810_i2c_board_info_2[] = {
 	},
 	{
 		I2C_BOARD_INFO("lp5521", 0x32),
+		.platform_data = &n810_lp5521_platform_data,
 	},
 };
 
-- 
1.6.1.265.g9a013

