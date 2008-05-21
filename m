From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Fix compiler error at pm-debug
Date: Wed, 21 May 2008 14:43:30 +0900
Message-ID: <20080521054330.GA5460@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47898 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbYEUF5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 01:57:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Fix compiler error at pm-debug

  CC      arch/arm/mach-omap2/pm-debug.o
In file included from arch/arm/mach-omap2/pm-debug.c:30:
arch/arm/mach-omap2/prm.h: In function `prm_rmw_reg_bits':
arch/arm/mach-omap2/prm.h:107: error: implicit declaration of function `__raw_readl'
arch/arm/mach-omap2/prm.h:110: error: implicit declaration of function `__raw_writel'
arch/arm/mach-omap2/pm-debug.c: In function `serial_wait_tx':
arch/arm/mach-omap2/pm-debug.c:59: error: implicit declaration of function `__raw_readb'
make[1]: *** [arch/arm/mach-omap2/pm-debug.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 361e52b..8a9f3c4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -23,6 +23,7 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/io.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/board.h>
