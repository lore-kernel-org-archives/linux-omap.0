From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 7/7] OMAP3 EVM: add rtc support
Date: Mon, 28 Apr 2008 16:30:33 -0700
Message-ID: <5e088bd90804281630n7ca89dc6lf7027148fd599649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43564 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbYD1Xae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:30:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so953239ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 16:30:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Add twl4030 RTC support for OMAP3 EVM

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 board-omap3evm.c |    8 ++++++++
 1 file changed, 8 insertions(+)
diff -uprN -X a/Documentation/dontdiff
a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
--- a/arch/arm/mach-omap2/board-omap3evm.c	2008-04-28 13:48:30.000000000 -0700
+++ b/arch/arm/mach-omap2/board-omap3evm.c	2008-04-28 14:20:12.000000000 -0700
@@ -60,6 +60,11 @@ static struct omap_lcd_config omap3_evm_
 	.ctrl_name	= "internal",
 };

+static struct platform_device omap3_evm_twl4030rtc_device = {
+	.name		= "twl4030_rtc",
+	.id		= -1,
+};
+
 static void __init omap3_evm_init_irq(void)
 {
 	omap2_init_common_hw();
@@ -75,6 +80,9 @@ static struct omap_board_config_kernel o

 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&omap3_evm_twl4030rtc_device,
+#endif
 };

 static void __init omap3_evm_init(void)
