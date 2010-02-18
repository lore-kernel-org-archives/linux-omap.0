From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/23] omap3: Add platform data for the twl4030_codec MFD on
	IGEP v2
Date: Wed, 17 Feb 2010 17:32:10 -0800
Message-ID: <20100218013210.32075.40017.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63233 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209Ab0BRBbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:20 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add platform data for the twl4030_codec MFD on IGEP v2

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index adc1b46..71488b2 100644
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
 

