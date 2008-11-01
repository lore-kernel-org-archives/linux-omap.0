From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap] H4: fix i2c registration
Date: Sat, 1 Nov 2008 00:38:05 -0700
Message-ID: <200811010038.05711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:48236 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750820AbYKAHiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 03:38:09 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Registering the I2C devices on H4 boards once is enough;
remove the extra call.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Mainline doesn't have the call to register the I2C adapter
along with its devices ... this has that call *plus* the call
to register just the board_info.  Seems to be the only OMAP2/3
board with this bug.

 arch/arm/mach-omap2/board-h4.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -746,9 +746,6 @@ static void __init omap_h4_init(void)
 	/* Menelaus interrupt */
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
 
-	i2c_register_board_info(1, h4_i2c_board_info,
-			ARRAY_SIZE(h4_i2c_board_info));
-
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
