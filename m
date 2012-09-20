From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: arm-soc/for-next: fixup compile after platform_data move
Date: Thu, 20 Sep 2012 09:38:14 -0700
Message-ID: <87obl0hcp5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62034 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab2ITQiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 12:38:10 -0400
Received: by pbbrr4 with SMTP id rr4so576248pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 09:38:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Arnd, Olof,

Not sure if this has been reported yet, but arm-soc/for-next now has a
build error on omap due to the recent merge of the platform_data move
series.

The arm-soc/next/soc branch contains the arm-soc/omap/am33xx branch
which adds an include of "plat/mscpi.h" which has now moved.

Below is a simple fix.

Kevin


>From cae062932d1d28e499b03d31da815fc2696badfd Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 20 Sep 2012 09:28:43 -0700
Subject: [PATCH] ARM: OMAP: AM33xx hwmod: fixup SPI after platform_data move

AM33xx hwmod data includes "mcspi.h" which has now been moved after
the platform_data move.  Fix it.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 22433cb..59d5c1c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -17,9 +17,9 @@
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
-#include <plat/mcspi.h>
 #include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
-- 
1.7.9.2
