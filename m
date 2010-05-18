From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 14/14] OMAP2: Devkit8000: Correct regulator
Date: Tue, 18 May 2010 14:05:35 +0200
Message-ID: <1274184335-29322-15-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58549 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab0ERMGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:04 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Devkit8000 uses the TPS65930 and not the TWL4030.
The TPS65930 uses only a subset of the voltage
regulators of the TWL4030.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 81000e4..96836fe 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -377,7 +377,7 @@ static struct twl4030_platform_data devkit8000_twldata = {
 
 static struct i2c_board_info __initdata devkit8000_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65930", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &devkit8000_twldata,
-- 
1.6.4.4

