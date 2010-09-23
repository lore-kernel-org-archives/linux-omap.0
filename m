From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] omap: zoom2: Fix ASoC multi-component build breakage by removing dead code
Date: Thu, 23 Sep 2010 19:11:53 +0300
Message-ID: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60869 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546Ab0IWQOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 12:14:08 -0400
Received: by ewy23 with SMTP id 23so511609ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 09:14:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>, Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>

ASoC Multi-Component Support patch removes #if 0 in board-zoom2.c that was
used to protect some uncompiling dead code. Remove that code as it seems to
be here quite some time since commit 479f12c.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Sorry for not noticing this before. Somehow my own test config didn't include
zoom2 like omap3_defconfig does.
---
 arch/arm/mach-omap2/board-zoom2.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index efbcd8f..86d4515 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -41,10 +41,6 @@ void zoom2_set_hs_extmute(int mute)
 	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
 }
 
-static struct twl4030_madc_platform_data zoom2_madc_data = {
-	.irq_line	= 1,
-};
-
 static struct twl4030_codec_audio_data zoom2_audio_data = {
 	.audio_mclk = 26000000,
 	.ramp_delay_value = 3,	/* 161 ms */
@@ -62,15 +58,7 @@ static struct twl4030_platform_data zoom2_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
-	.bci		= &zoom2_bci_data,
-	.madc		= &zoom2_madc_data,
-	.usb		= &zoom2_usb_data,
-	.gpio		= &zoom2_gpio_data,
-	.keypad		= &zoom2_kp_twl4030_data,
 	.codec		= &zoom2_codec_data,
-	.vmmc1          = &zoom2_vmmc1,
-	.vmmc2          = &zoom2_vmmc2,
-	.vsim           = &zoom2_vsim,
 };
 
 static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
-- 
1.7.1

