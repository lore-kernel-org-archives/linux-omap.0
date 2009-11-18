From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 1/8] omap3: Add platform data for the twl4030_codec MFD on IGEP v2
Date: Wed, 18 Nov 2009 21:20:33 +0100
Message-ID: <1258575640-8169-2-git-send-email-eballetbo@gmail.com>
References: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63735 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab0AMLCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:02:43 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so323499ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 03:02:43 -0800 (PST)
In-Reply-To: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
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
index 117b8fd..5beea22 100644
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

