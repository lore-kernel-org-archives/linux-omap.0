From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Wed, 13 Jul 2011 12:59:22 +0200
Message-ID: <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
References: <1310554738.18446.12.camel@lws-weitzel>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:57386 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965021Ab1GMK70 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 06:59:26 -0400
In-Reply-To: <1310554738.18446.12.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>

vusim is not used.

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/board-omap4pcm049.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index ad8cb46..85193ec 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -227,18 +227,6 @@ static struct platform_device pcm049_vcc_3v3_device = {
 	},
 };
 
-static struct regulator_init_data pcm049_vusim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3300000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-};
-
 static struct at24_platform_data board_eeprom = {
 	.byte_len = 4096,
 	.page_size = 32,
@@ -318,9 +306,7 @@ static struct i2c_board_info __initdata pcm049_i2c_4_boardinfo[] = {
 	}
 };
 
-static struct twl4030_platform_data pcm049_twldata = {
-	.vusim		= &pcm049_vusim,
-};
+static struct twl4030_platform_data pcm049_twldatai;
 
 static int __init pcm049_i2c_init(void)
 {
-- 
1.7.0.4

