From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/13] ARM: OMAP: Remove remaining board-*.h includes from
	hardware.h
Date: Thu, 26 Feb 2009 16:08:57 -0800
Message-ID: <20090227000856.20192.42137.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61255 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445AbZB0AJA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:09:00 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Also remove board-omap3beagle.h that is not included anywhere,
and move protoype for voiceblue_reset() from board-voiceblue.h
to system.h.

After this patch there are still board-ams-delta.h, board-sx1.h
and board-voiceblue.h that export some functions. These could
be removed if the functions were moved under drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../arm/plat-omap/include/mach/board-omap3beagle.h |   33 --------------------
 arch/arm/plat-omap/include/mach/board-voiceblue.h  |    1 -
 arch/arm/plat-omap/include/mach/hardware.h         |   22 -------------
 arch/arm/plat-omap/include/mach/system.h           |    2 +
 4 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-omap3beagle.h

diff --git a/arch/arm/plat-omap/include/mach/board-omap3beagle.h b/arch/arm/plat-omap/include/mach/board-omap3beagle.h
deleted file mode 100644
index 3080d52..0000000
--- a/arch/arm/plat-omap/include/mach/board-omap3beagle.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-omap3beagle.h
- *
- * Hardware definitions for TI OMAP3 BEAGLE.
- *
- * Initial creation by Syed Mohammed Khasim <khasim@ti.com>
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
-#ifndef __ASM_ARCH_OMAP3_BEAGLE_H
-#define __ASM_ARCH_OMAP3_BEAGLE_H
-
-#endif /* __ASM_ARCH_OMAP3_BEAGLE_H */
-
diff --git a/arch/arm/plat-omap/include/mach/board-voiceblue.h b/arch/arm/plat-omap/include/mach/board-voiceblue.h
index ed6d346..27916b2 100644
--- a/arch/arm/plat-omap/include/mach/board-voiceblue.h
+++ b/arch/arm/plat-omap/include/mach/board-voiceblue.h
@@ -14,7 +14,6 @@
 extern void voiceblue_wdt_enable(void);
 extern void voiceblue_wdt_disable(void);
 extern void voiceblue_wdt_ping(void);
-extern void voiceblue_reset(void);
 
 #endif /*  __ASM_ARCH_VOICEBLUE_H */
 
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index bba9498..3dc423e 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -286,26 +286,4 @@
 #include "omap24xx.h"
 #include "omap34xx.h"
 
-#ifndef __ASSEMBLER__
-
-/*
- * ---------------------------------------------------------------------------
- * Board specific defines
- * ---------------------------------------------------------------------------
- */
-
-#ifdef CONFIG_MACH_OMAP3_BEAGLE
-#include "board-omap3beagle.h"
-#endif
-
-#ifdef CONFIG_MACH_VOICEBLUE
-#include "board-voiceblue.h"
-#endif
-
-#ifdef CONFIG_MACH_SX1
-#include "board-sx1.h"
-#endif
-
-#endif /* !__ASSEMBLER__ */
-
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index 06923f2..8422845 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -11,6 +11,8 @@
 
 #ifndef CONFIG_MACH_VOICEBLUE
 #define voiceblue_reset()		do {} while (0)
+#else
+extern void voiceblue_reset(void);
 #endif
 
 extern void omap_prcm_arch_reset(char mode);

