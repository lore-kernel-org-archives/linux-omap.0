From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/13] ARM: OMAP: No need to include board-ldp.h from
	hardware.h
Date: Thu, 26 Feb 2009 16:05:06 -0800
Message-ID: <20090227000506.20192.69112.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58318 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbZB0AFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:05:10 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header file. Also rename
OMAP34XX_ETHR_START to LDP_ETHR_START.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-ldp.c             |   10 ++++---
 arch/arm/plat-omap/include/mach/board-ldp.h |   39 ---------------------------
 arch/arm/plat-omap/include/mach/hardware.h  |    4 ---
 3 files changed, 6 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-ldp.h

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f6a1345..33112a2 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -28,7 +28,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ldp.h>
 #include <mach/mcspi.h>
 #include <mach/gpio.h>
 #include <mach/board.h>
@@ -41,12 +40,15 @@
 
 #include "mmc-twl4030.h"
 
-#define SDP3430_SMC91X_CS	3
+#define LDP_SMC911X_CS		1
+#define LDP_SMC911X_GPIO	152
+#define DEBUG_BASE		0x08000000
+#define LDP_ETHR_START		DEBUG_BASE
 
 static struct resource ldp_smc911x_resources[] = {
 	[0] = {
-		.start	= OMAP34XX_ETHR_START,
-		.end	= OMAP34XX_ETHR_START + SZ_4K,
+		.start	= LDP_ETHR_START,
+		.end	= LDP_ETHR_START + SZ_4K,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/plat-omap/include/mach/board-ldp.h b/arch/arm/plat-omap/include/mach/board-ldp.h
deleted file mode 100644
index f233996..0000000
--- a/arch/arm/plat-omap/include/mach/board-ldp.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-ldp.h
- *
- * Hardware definitions for TI OMAP3 LDP.
- *
- * Copyright (C) 2008 Texas Instruments Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __ASM_ARCH_OMAP_LDP_H
-#define __ASM_ARCH_OMAP_LDP_H
-
-extern void twl4030_bci_battery_init(void);
-
-#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
-#define LDP_SMC911X_CS         1
-#define LDP_SMC911X_GPIO       152
-#define DEBUG_BASE             0x08000000
-#define OMAP34XX_ETHR_START    DEBUG_BASE
-#endif /* __ASM_ARCH_OMAP_LDP_H */
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 85f02b6..bba9498 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -298,10 +298,6 @@
 #include "board-omap3beagle.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_LDP
-#include "board-ldp.h"
-#endif
-
 #ifdef CONFIG_MACH_VOICEBLUE
 #include "board-voiceblue.h"
 #endif

