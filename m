From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/13] ARM: OMAP: No need to include board-h4.h from hardware.h
Date: Thu, 26 Feb 2009 16:03:49 -0800
Message-ID: <20090227000349.20192.48414.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57157 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbZB0ADx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:03:53 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header file. Also rename
OMAP24XX_ETHR_GPIO_IRQ to H4_ETHR_GPIO_IRQ.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c             |    4 ++-
 arch/arm/plat-omap/include/mach/board-h4.h |   38 ----------------------------
 arch/arm/plat-omap/include/mach/hardware.h |    4 ---
 3 files changed, 3 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-h4.h

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 5e9b146..7122697 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -47,6 +47,8 @@
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
 
+#define H4_ETHR_GPIO_IRQ		92
+
 static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
 static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };
 
@@ -341,7 +343,7 @@ static inline void __init h4_init_debug(void)
 	udelay(100);
 
 	omap_cfg_reg(M15_24XX_GPIO92);
-	if (debug_card_init(cs_mem_base, OMAP24XX_ETHR_GPIO_IRQ) < 0)
+	if (debug_card_init(cs_mem_base, H4_ETHR_GPIO_IRQ) < 0)
 		gpmc_cs_free(eth_cs);
 
 out:
diff --git a/arch/arm/plat-omap/include/mach/board-h4.h b/arch/arm/plat-omap/include/mach/board-h4.h
deleted file mode 100644
index 7c3fa0f..0000000
--- a/arch/arm/plat-omap/include/mach/board-h4.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-h4.h
- *
- * Hardware definitions for TI OMAP2420 H4 board.
- *
- * Initial creation by Dirk Behme <dirk.behme@de.bosch.com>
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
-#ifndef __ASM_ARCH_OMAP_H4_H
-#define __ASM_ARCH_OMAP_H4_H
-
-/* MMC Prototypes */
-extern void h4_mmc_init(void);
-
-/* Placeholder for H4 specific defines */
-#define OMAP24XX_ETHR_GPIO_IRQ		92
-#endif /*  __ASM_ARCH_OMAP_H4_H */
-
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 26f14f7..85f02b6 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -294,10 +294,6 @@
  * ---------------------------------------------------------------------------
  */
 
-#ifdef CONFIG_MACH_OMAP_H4
-#include "board-h4.h"
-#endif
-
 #ifdef CONFIG_MACH_OMAP3_BEAGLE
 #include "board-omap3beagle.h"
 #endif

