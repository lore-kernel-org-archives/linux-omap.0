From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 4/8] ARM: OMAP2+: Remove dma.h
Date: Sat, 15 Jun 2013 11:31:05 +0300
Message-ID: <1371285069-6834-5-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33798 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab3FOIbw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:52 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

All definitions in arch/arm/mach-omap2/dma.h are removed so it can be
removed now.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap2/devices.c                      |    1 -
 arch/arm/mach-omap2/dma.h                          |   28 --------------------
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    1 -
 4 files changed, 31 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/dma.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c0f99ab..403c211 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -37,7 +37,6 @@
 #include "mux.h"
 #include "control.h"
 #include "devices.h"
-#include "dma.h"
 
 #define L3_MODULES_MAX_LEN 12
 #define L3_MODULES 3
diff --git a/arch/arm/mach-omap2/dma.h b/arch/arm/mach-omap2/dma.h
deleted file mode 100644
index aa735a4..0000000
--- a/arch/arm/mach-omap2/dma.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  OMAP2PLUS DMA channel definitions
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
-#ifndef __OMAP2PLUS_DMA_CHANNEL_H
-#define __OMAP2PLUS_DMA_CHANNEL_H
-
-
-/* DMA channels for 24xx */
-
-
-/* Only for AM35xx */
-
-#endif /* __OMAP2PLUS_DMA_CHANNEL_H */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index ef56897..5da7a42 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -17,7 +17,6 @@
 #include "hdq1w.h"
 
 #include "omap_hwmod_common_data.h"
-#include "dma.h"
 
 /* UART */
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 33d5620..fa99154 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -35,7 +35,6 @@
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
 
-#include "dma.h"
 #include "i2c.h"
 #include "mmc.h"
 #include "wd_timer.h"
-- 
1.7.10.4

