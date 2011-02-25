From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH] omap: rx51: Add support for vibra
Date: Fri, 25 Feb 2011 10:46:23 +0200
Message-ID: <1298623583-9743-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:34645 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab1BYIuJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 03:50:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: ilkka.koskinen@nokia.com

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e75e240..dcd98fa 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -699,6 +699,14 @@ static struct twl4030_power_data rx51_t2scripts_data __initdata = {
 	.resource_config = twl4030_rconfig,
 };
 
+struct twl4030_codec_vibra_data rx51_vibra_data __initdata = {
+	.coexist	= 0,
+};
+
+struct twl4030_codec_data rx51_codec_data __initdata = {
+	.audio_mclk	= 26000000,
+	.vibra		= &rx51_vibra_data,
+};
 
 static struct twl4030_platform_data rx51_twldata __initdata = {
 	.irq_base		= TWL4030_IRQ_BASE,
@@ -710,6 +718,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.madc			= &rx51_madc_data,
 	.usb			= &rx51_usb_data,
 	.power			= &rx51_t2scripts_data,
+	.codec			= &rx51_codec_data,
 
 	.vaux1			= &rx51_vaux1,
 	.vaux2			= &rx51_vaux2,
-- 
1.7.0.4

