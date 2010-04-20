From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 4/7] AM3517: initialize i2c subsystem after mux subsystem
Date: Tue, 20 Apr 2010 14:33:29 +0800
Message-ID: <1271745212-4474-5-git-send-email-stanley.miao@windriver.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:55753 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab0DTGYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 02:24:48 -0400
In-Reply-To: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, hvaibhav@ti.com, srk@ti.com, anuj.aggarwal@ti.com

The initialize of i2c subsystem will set pinmux, so it should be done
after the initialize of mux subsystem initialization.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 3acfcae..cd031c9 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -294,9 +294,9 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static void __init am3517_evm_init(void)
 {
-	am3517_evm_i2c_init();
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+
+	am3517_evm_i2c_init();
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
 
-- 
1.5.4.3

