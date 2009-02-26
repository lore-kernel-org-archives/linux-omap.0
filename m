From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/13] ARM: OMAP: No need to include board-innovator.h from
	hardware.h
Date: Thu, 26 Feb 2009 15:57:25 -0800
Message-ID: <20090226235725.20192.52656.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52410 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZBZX53 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 18:57:29 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the board file and remove the now unnecessary
header file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-innovator.c             |    3 +
 arch/arm/plat-omap/include/mach/board-innovator.h |   52 ---------------------
 arch/arm/plat-omap/include/mach/hardware.h        |    4 --
 3 files changed, 3 insertions(+), 56 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-innovator.h

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 071cd02..714a08f 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -39,6 +39,9 @@
 #include <mach/common.h>
 #include <mach/mmc.h>
 
+/* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
+#define INNOVATOR1610_ETHR_START	0x04000300
+
 static int innovator_keymap[] = {
 	KEY(0, 0, KEY_F1),
 	KEY(0, 3, KEY_DOWN),
diff --git a/arch/arm/plat-omap/include/mach/board-innovator.h b/arch/arm/plat-omap/include/mach/board-innovator.h
deleted file mode 100644
index 5ae3e79..0000000
--- a/arch/arm/plat-omap/include/mach/board-innovator.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-innovator.h
- *
- * Copyright (C) 2001 RidgeRun, Inc.
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
-#ifndef __ASM_ARCH_OMAP_INNOVATOR_H
-#define __ASM_ARCH_OMAP_INNOVATOR_H
-
-#if defined (CONFIG_ARCH_OMAP15XX)
-
-#ifndef OMAP_SDRAM_DEVICE
-#define OMAP_SDRAM_DEVICE			D256M_1X16_4B
-#endif
-
-#define OMAP1510P1_IMIF_PRI_VALUE		0x00
-#define OMAP1510P1_EMIFS_PRI_VALUE		0x00
-#define OMAP1510P1_EMIFF_PRI_VALUE		0x00
-
-#ifndef __ASSEMBLY__
-void fpga_write(unsigned char val, int reg);
-unsigned char fpga_read(int reg);
-#endif
-
-#endif /* CONFIG_ARCH_OMAP15XX */
-
-#if defined (CONFIG_ARCH_OMAP16XX)
-
-/* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
-#define INNOVATOR1610_ETHR_START	0x04000300
-
-#endif /* CONFIG_ARCH_OMAP1610 */
-#endif /* __ASM_ARCH_OMAP_INNOVATOR_H */
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 040244c..0b1b91f 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -294,10 +294,6 @@
  * ---------------------------------------------------------------------------
  */
 
-#ifdef CONFIG_MACH_OMAP_INNOVATOR
-#include "board-innovator.h"
-#endif
-
 #ifdef CONFIG_MACH_OMAP_H4
 #include "board-h4.h"
 #endif

