From: trickie@gmail.com
Subject: [PATCH] Fix n800 build - only register HW keyboard on i2c board if CONFIG_MACH_NOKIA_N810
Date: Fri,  2 May 2008 15:05:35 +0200
Message-ID: <1209733535-31057-1-git-send-email-trickie@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:4995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760161AbYEBNFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 09:05:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so658281nfc.21
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2008 06:05:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nick Loeve <trickie@gmail.com>

lm8323_pdata is only present if CONFIG_MACH_NOKIA_N810

Signed-off-by: Nick Loeve <trickie@gmail.com>
---
 arch/arm/mach-omap2/board-n800.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 8b5956b..b62f2d5 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -654,12 +654,14 @@ static struct i2c_board_info __initdata n800_i2c_board_info_2[] = {
 		I2C_BOARD_INFO("tea5761", 0x10),
 	},
 #endif
+#ifdef CONFIG_MACH_NOKIA_N810
 	{
 		I2C_BOARD_INFO("lm8323", 0x45),
 		.type		= "lm8323",
 		.irq		= OMAP_GPIO_IRQ(109),
 		.platform_data	= &lm8323_pdata,
 	},
+#endif
 	{
 		I2C_BOARD_INFO("tsl2563", 0x29),
 		.type		= "tsl2563",
-- 
1.5.5.1

