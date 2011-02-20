From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap: Fix linker error in drivers/video/omap/lcd_2430sdp.c
Date: Sun, 20 Feb 2011 11:17:46 +0200
Message-ID: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60113 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab1BTJSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Feb 2011 04:18:07 -0500
Received: by bwz15 with SMTP id 15so293995bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 01:18:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

There is a linker error from lcd_2430sdp.c if CONFIG_TWL4030_CORE is not
set. This can be triggered on OMAP2 builds where OMAP3 or OMAP4 are not set.

drivers/built-in.o: In function `sdp2430_panel_disable':
drivers/video/omap/lcd_2430sdp.c:123: undefined reference to `twl_i2c_write_u8'
drivers/video/omap/lcd_2430sdp.c:124: undefined reference to `twl_i2c_write_u8'
drivers/built-in.o: In function `sdp2430_panel_enable':
drivers/video/omap/lcd_2430sdp.c:110: undefined reference to `twl_i2c_write_u8'
drivers/video/omap/lcd_2430sdp.c:112: undefined reference to `twl_i2c_write_u8'

Fix this by adding TWL4030_CORE dependency to CONFIG_MACH_OMAP_2430SDP as
there is no own entry in drivers/video/omap/Kconfig.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
Quite old issue most probably. Can be triggered in mainline anyway.
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b9d8a7b..bfdf240 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -132,6 +132,7 @@ config MACH_OMAP_2430SDP
 	depends on SOC_OMAP2430
 	default y
 	select OMAP_PACKAGE_ZAC
+	select TWL4030_CORE
 
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
-- 
1.7.0.4

