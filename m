From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 2/3] Minor checkpatch cleanup
Date: Thu,  6 Nov 2008 21:49:57 +0200
Message-ID: <1226000998-22397-2-git-send-email-notasas@gmail.com>
References: <1226000998-22397-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:14781 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYKFTuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 14:50:22 -0500
Received: by nf-out-0910.google.com with SMTP id d3so421206nfc.21
        for <linux-omap@vger.kernel.org>; Thu, 06 Nov 2008 11:50:20 -0800 (PST)
In-Reply-To: <1226000998-22397-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

Clean a line over 80 characters.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index b10bf00..c2c4930 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -269,7 +269,8 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 static void __init omap3pandora_init(void)
 {
 	omap3pandora_i2c_init();
-	platform_add_devices(omap3pandora_devices, ARRAY_SIZE(omap3pandora_devices));
+	platform_add_devices(omap3pandora_devices,
+			ARRAY_SIZE(omap3pandora_devices));
 	omap_board_config = omap3pandora_config;
 	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
 	omap_serial_init();
-- 
1.5.4.3

