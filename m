From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/13] ARM: OMAP: No need to include board-omap2430sdp.h from
	hardware.h
Date: Thu, 26 Feb 2009 16:01:15 -0800
Message-ID: <20090227000115.20192.14200.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55002 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbZB0ABT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:01:19 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header file. Also rename
SDP2430_ETHR_GPIO_IRQ to SDP2430_ETHR_GPIO_IRQ.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c             |   13 ++++---
 arch/arm/plat-omap/include/mach/board-2430sdp.h |   41 -----------------------
 arch/arm/plat-omap/include/mach/hardware.h      |    4 --
 3 files changed, 8 insertions(+), 50 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-2430sdp.h

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 83fa372..c8abe6a 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,9 +38,12 @@
 
 #include "mmc-twl4030.h"
 
+#define SDP2430_CS0_BASE	0x04000000
 #define	SDP2430_FLASH_CS	0
 #define	SDP2430_SMC91X_CS	5
 
+#define SDP2430_ETHR_GPIO_IRQ		149
+
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -102,8 +105,8 @@ static struct resource sdp2430_smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(OMAP24XX_ETHR_GPIO_IRQ),
-		.end	= OMAP_GPIO_IRQ(OMAP24XX_ETHR_GPIO_IRQ),
+		.start	= OMAP_GPIO_IRQ(SDP2430_ETHR_GPIO_IRQ),
+		.end	= OMAP_GPIO_IRQ(SDP2430_ETHR_GPIO_IRQ),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -170,13 +173,13 @@ static inline void __init sdp2430_init_smc91x(void)
 	sdp2430_smc91x_resources[0].end = cs_mem_base + 0x30f;
 	udelay(100);
 
-	if (gpio_request(OMAP24XX_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
+	if (gpio_request(SDP2430_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			OMAP24XX_ETHR_GPIO_IRQ);
+			SDP2430_ETHR_GPIO_IRQ);
 		gpmc_cs_free(eth_cs);
 		goto out;
 	}
-	gpio_direction_input(OMAP24XX_ETHR_GPIO_IRQ);
+	gpio_direction_input(SDP2430_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
diff --git a/arch/arm/plat-omap/include/mach/board-2430sdp.h b/arch/arm/plat-omap/include/mach/board-2430sdp.h
deleted file mode 100644
index 10d449e..0000000
--- a/arch/arm/plat-omap/include/mach/board-2430sdp.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-2430sdp.h
- *
- * Hardware definitions for TI OMAP2430 SDP board.
- *
- * Based on board-h4.h by Dirk Behme <dirk.behme@de.bosch.com>
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
-#ifndef __ASM_ARCH_OMAP_2430SDP_H
-#define __ASM_ARCH_OMAP_2430SDP_H
-
-/* Placeholder for 2430SDP specific defines */
-#define OMAP24XX_ETHR_START		0x08000300
-#define OMAP24XX_ETHR_GPIO_IRQ		149
-#define SDP2430_CS0_BASE		0x04000000
-
-/* Function prototypes */
-extern void sdp2430_flash_init(void);
-extern void sdp2430_usb_init(void);
-
-#endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 194ed49..346a5c7 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -298,10 +298,6 @@
 #include "board-h4.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_2430SDP
-#include "board-2430sdp.h"
-#endif
-
 #ifdef CONFIG_MACH_OMAP3_BEAGLE
 #include "board-omap3beagle.h"
 #endif

