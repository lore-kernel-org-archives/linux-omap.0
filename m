From: David Brownell <david-b@pacbell.net>
Subject: [patch 1/4] twl: update overo and pandora i2c data
Date: Sat, 15 Nov 2008 12:38:43 -0800
Message-ID: <200811151238.43725.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:20755 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751575AbYKOUyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Nov 2008 15:54:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Update Pandora and Overo board-specific code to report that
they use catalog versions of the twl5030 ... this affects
the range of usable VAUX2 voltages.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/board-overo.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -167,7 +167,7 @@ static struct twl4030_platform_data omap
 
 static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65950", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &omap3pandora_twldata,
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -167,7 +167,7 @@ static struct twl4030_platform_data over
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65950", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &overo_twldata,
