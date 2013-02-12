From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] ARM: omap: board-h4: remove warning for is_gpmc_muxed
Date: Mon, 11 Feb 2013 19:47:16 -0800
Message-ID: <1360640836-18792-1-git-send-email-olof@lixom.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44278 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3BLDr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 22:47:26 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so3449789pad.28
        for <linux-omap@vger.kernel.org>; Mon, 11 Feb 2013 19:47:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

If the ethernet driver is not selected, you otherwise get:

arch/arm/mach-omap2/board-h4.c:237:12: warning: 'is_gpmc_muxed' defined but not used [-Wunused-function]

I guess it could be argued that the device setup should/could always
be done even if the driver isn't enabled, but hopefully the board files
will all go away some day so let's stick to the smaller delta.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-omap2/board-h4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 812c829..e34541d 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -229,6 +229,8 @@ static u32 get_sysboot_value(void)
 		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
 }
 
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
+
 /* H4-2420's always used muxed mode, H4-2422's always use non-muxed
  *
  * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and is_cpu_omap2423
@@ -246,8 +248,6 @@ static u32 is_gpmc_muxed(void)
 		return 0;
 }
 
-#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
-
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs		= 1,
 	.gpio_irq	= 92,
-- 
1.8.1.192.gc4361b8

