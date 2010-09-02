From: David Barksdale <amatus.amongus@gmail.com>
Subject: [PATCH] OMAP: Fix TI Innovator 1510/1610 LCD regression
Date: Thu, 2 Sep 2010 01:52:17 -0400
Message-ID: <AANLkTiki6Gz-G4qX1WuaT6Fo3jK6XBgNm=1ddwepnqdj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55951 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0IBFwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 01:52:18 -0400
Received: by vws3 with SMTP id 3so85839vws.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Sep 2010 22:52:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch fixes a regression introduced by the "OMAP: UART: drop
OMAP_TAG_UART, enable all UARTs, auto-disabled on idle" patch.

Signed-off-by: David Barksdale <amatus.amongus@gmail.com>
---
diff --git a/arch/arm/mach-omap1/board-innovator.c
b/arch/arm/mach-omap1/board-innovator.c
index 3daf87a..2ee8a70 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -423,13 +423,13 @@ static void __init innovator_init(void)
 #ifdef CONFIG_ARCH_OMAP15XX
        if (cpu_is_omap1510()) {
                omap1_usb_init(&innovator1510_usb_config);
-               innovator_config[1].data = &innovator1510_lcd_config;
+               innovator_config[0].data = &innovator1510_lcd_config;
        }
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
        if (cpu_is_omap1610()) {
                omap1_usb_init(&h2_usb_config);
-               innovator_config[1].data = &innovator1610_lcd_config;
+               innovator_config[0].data = &innovator1610_lcd_config;
        }
 #endif
        omap_board_config = innovator_config;
