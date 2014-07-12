From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ARM: OMAP: generic: add call to of_clk_init()
Date: Sat, 12 Jul 2014 12:55:08 +0200
Message-ID: <1405162508-9835-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58793 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaGLKzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Jul 2014 06:55:25 -0400
Received: by mail-we0-f180.google.com with SMTP id k48so1219933wev.11
        for <linux-omap@vger.kernel.org>; Sat, 12 Jul 2014 03:55:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>

This is needed to instanciate fixed clocks in the DT.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/board-generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 5606fa2..39f154a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/clk-provider.h>
 
 #include <asm/mach/arch.h>
 
@@ -33,6 +34,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ }
 };
 
+static struct of_device_id clk_match[] __initdata = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ }
+};
+
 static void __init omap_generic_init(void)
 {
 	omapdss_early_init_of();
@@ -40,6 +46,8 @@ static void __init omap_generic_init(void)
 	pdata_quirks_init(omap_dt_match_table);
 
 	omapdss_init_of();
+
+	of_clk_init(clk_match);
 }
 
 #ifdef CONFIG_SOC_OMAP2420
-- 
1.9.3

