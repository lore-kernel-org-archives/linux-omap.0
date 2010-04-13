From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 05/11] AM3517: Add audio codec platform data
Date: Tue, 13 Apr 2010 17:31:55 +0800
Message-ID: <1271151118-12999-6-git-send-email-stanley.miao@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51232 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0DMJXa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 05:23:30 -0400
In-Reply-To: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Codec tlv320aic23 is on the second i2c bus. Add the tlv320aic23 info in
i2c2 board_info.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 2d7fd08..879c13f 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -312,6 +312,9 @@ static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
 };
 static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
 	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1A),
+	},
+	{
 		I2C_BOARD_INFO("tca6416", 0x21),
 		.platform_data = &am3517evm_gpio_expander_info_0,
 	},
-- 
1.5.4.3

