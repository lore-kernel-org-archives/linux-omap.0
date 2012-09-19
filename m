From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 26/29] ARM: OMAP2+: Make l3_3xxx.h local
Date: Wed, 19 Sep 2012 14:06:34 -0700
Message-ID: <20120919210634.28074.77013.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44482 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:36 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/l3_3xxx.h              |    0 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{plat-omap/include/plat/l3_3xxx.h => mach-omap2/l3_3xxx.h} (100%)

diff --git a/arch/arm/plat-omap/include/plat/l3_3xxx.h b/arch/arm/mach-omap2/l3_3xxx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/l3_3xxx.h
rename to arch/arm/mach-omap2/l3_3xxx.h
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 61486f2..13a9aa8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -20,7 +20,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
-#include <plat/l3_3xxx.h>
+#include "l3_3xxx.h"
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/mmc.h>

