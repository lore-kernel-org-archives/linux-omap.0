From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/3] omap3: Add platform data for the twl4030_codec MFD on IGEP v2
Date: Wed, 18 Nov 2009 19:13:22 +0100
Message-ID: <1258568004-6993-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59112 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350AbZLNR6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 12:58:41 -0500
Received: by ewy19 with SMTP id 19so3657006ewy.21
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 09:58:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 44239e3..221b497 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -173,12 +173,22 @@ static void __init igep2_init_irq(void)
 	omap_gpio_init();
 }
 
+static struct twl4030_codec_audio_data igep2_audio_data = {
+	.audio_mclk = 26000000,
+};
+
+static struct twl4030_codec_data igep2_codec_data = {
+	.audio_mclk = 26000000,
+	.audio = &igep2_audio_data,
+};
+
 static struct twl4030_platform_data igep2_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.usb		= &igep2_usb_data,
+	.codec		= &igep2_codec_data,
 	.gpio		= &igep2_gpio_data,
 	.vmmc1          = &igep2_vmmc1,
 
-- 
1.5.4.3

