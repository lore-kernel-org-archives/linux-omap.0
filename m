From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 8/8] ARM: OMAP1: Remove dma.h
Date: Sat, 15 Jun 2013 11:31:09 +0300
Message-ID: <1371285069-6834-9-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33810 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab3FOIcB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:32:01 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Add definitions in arch/arm/mach-omap1/dma.h are now removed so remove
the file and include statements from dma.c and lcd_dma.c.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/dma.c     |    2 --
 arch/arm/mach-omap1/dma.h     |   26 --------------------------
 arch/arm/mach-omap1/lcd_dma.c |    2 --
 3 files changed, 30 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/dma.h

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index a94b3a7..5bb8ce8 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -30,8 +30,6 @@
 
 #include <mach/irqs.h>
 
-#include "dma.h"
-
 #define OMAP1_DMA_BASE			(0xfffed800)
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
 #define OMAP1_DMA_STRIDE		0x40
diff --git a/arch/arm/mach-omap1/dma.h b/arch/arm/mach-omap1/dma.h
deleted file mode 100644
index 6c751e8..0000000
--- a/arch/arm/mach-omap1/dma.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  OMAP1 DMA channel definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __OMAP1_DMA_CHANNEL_H
-#define __OMAP1_DMA_CHANNEL_H
-
-/* DMA channels for omap1 */
-
-/* These are only for 1610 */
-
-#endif /* __OMAP1_DMA_CHANNEL_H */
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
index 77924be..26a2b01 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -32,8 +32,6 @@
 #include <mach/hardware.h>
 #include <mach/lcdc.h>
 
-#include "dma.h"
-
 int omap_lcd_dma_running(void)
 {
 	/*
-- 
1.7.10.4

