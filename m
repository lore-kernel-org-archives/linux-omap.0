From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 6/6] Devkit8000: Change twl4030 to tps65930
Date: Sat,  8 May 2010 06:31:23 +0200
Message-ID: <1273293083-24063-7-git-send-email-weber@corscience.de>
References: <1273293083-24063-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56948 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0EHEbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 May 2010 00:31:52 -0400
In-Reply-To: <1273293083-24063-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Devkit8000 uses the TPS65930 and not the TWL4030.
The TPS65930 uses only a subset of the TWL4030.
So not all voltage regulators of the twl4030
are available on the Devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 4ca87f8..03332e8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -369,7 +369,7 @@ static struct twl4030_platform_data devkit8000_twldata = {
 
 static struct i2c_board_info __initdata devkit8000_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65930", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &devkit8000_twldata,
-- 
1.6.4.4

