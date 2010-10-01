From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: enable twl4030 charger
Date: Fri,  1 Oct 2010 12:53:16 +0300
Message-ID: <1285926796-8034-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34964 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0JAJxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 05:53:22 -0400
Received: by ewy23 with SMTP id 23so1179225ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 02:53:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Add platform data to make use of newly added charging driver.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
Now that the charger driver is in power_supply battery.git,
I'd love to have it working in next Linus kernel.

 arch/arm/mach-omap2/board-omap3pandora.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index f24528e..ed1dde3 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -533,6 +533,8 @@ static struct twl4030_codec_data omap3pandora_codec_data = {
 	.audio = &omap3pandora_audio_data,
 };
 
+static struct twl4030_bci_platform_data pandora_bci_data;
+
 static struct twl4030_platform_data omap3pandora_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -548,6 +550,7 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.vaux4		= &pandora_vaux4,
 	.vsim		= &pandora_vsim,
 	.keypad		= &pandora_kp_data,
+	.bci		= &pandora_bci_data,
 };
 
 static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
-- 
1.6.3.3

