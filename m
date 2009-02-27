From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/13] ARM: OMAP: No need to include board-apollon.h from
	hardware.h
Date: Thu, 26 Feb 2009 16:02:32 -0800
Message-ID: <20090227000232.20192.86136.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55924 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbZB0ACg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:02:36 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the associated board file and remove
the now unnecessary header file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-apollon.c             |    1 +
 arch/arm/plat-omap/include/mach/board-apollon.h |   46 -----------------------
 arch/arm/plat-omap/include/mach/hardware.h      |    4 --
 3 files changed, 1 insertions(+), 50 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-apollon.h

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 0a7b24b..6456124 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -51,6 +51,7 @@
 
 #define APOLLON_FLASH_CS	0
 #define APOLLON_ETH_CS		1
+#define APOLLON_ETHR_GPIO_IRQ	74
 
 static struct mtd_partition apollon_partitions[] = {
 	{
diff --git a/arch/arm/plat-omap/include/mach/board-apollon.h b/arch/arm/plat-omap/include/mach/board-apollon.h
deleted file mode 100644
index 61bd5e8..0000000
--- a/arch/arm/plat-omap/include/mach/board-apollon.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-apollon.h
- *
- * Hardware definitions for Samsung OMAP24XX Apollon board.
- *
- * Initial creation by Kyungmin Park <kyungmin.park@samsung.com>
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
-#ifndef __ASM_ARCH_OMAP_APOLLON_H
-#define __ASM_ARCH_OMAP_APOLLON_H
-
-#include <mach/cpu.h>
-
-extern void apollon_mmc_init(void);
-
-static inline int apollon_plus(void)
-{
-	/* The apollon plus has IDCODE revision 5 */
-	return omap_rev() & 0xc0;
-}
-
-/* Placeholder for APOLLON specific defines */
-#define APOLLON_ETHR_GPIO_IRQ		74
-
-#endif /*  __ASM_ARCH_OMAP_APOLLON_H */
-
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 346a5c7..26f14f7 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -306,10 +306,6 @@
 #include "board-ldp.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_APOLLON
-#include "board-apollon.h"
-#endif
-
 #ifdef CONFIG_MACH_VOICEBLUE
 #include "board-voiceblue.h"
 #endif

