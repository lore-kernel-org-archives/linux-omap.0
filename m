From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH] ARM:OMAP2: follow new twl4030 RTC init convention in Overo board file
Date: Sat, 13 Sep 2008 22:19:57 -0700
Message-ID: <5e088bd90809132219j63bbec48hdd36ddb1357741e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:30133 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbYINFT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 01:19:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1485480wfd.4
        for <linux-omap@vger.kernel.org>; Sat, 13 Sep 2008 22:19:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Overo was omitted from the changes in 74fcfe9c589f1060b5e5a791e9c0c54212d7c1b8

This patch brings Overo RTC setup into line with the other omap boards

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 5c23b4d..85ef43f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -158,11 +158,6 @@ static void __init overo_init_irq(void)
 	omap_gpio_init();
 }

-static struct platform_device overo_twl4030rtc_device = {
-	.name           = "twl4030_rtc",
-	.id             = -1,
-};
-
 static struct platform_device overo_lcd_device = {
 	.name		= "overo_lcd",
 	.id		= -1,
@@ -179,9 +174,6 @@ static struct omap_board_config_kernel
overo_config[] __initdata = {

 static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
-#ifdef CONFIG_RTC_DRV_TWL4030
-	&overo_twl4030rtc_device,
-#endif
 };

 static void __init overo_init(void)
-- 
1.5.4.5
