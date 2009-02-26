From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/13] ARM: OMAP: No need to include board-osk.h from
	hardware.h
Date: Thu, 26 Feb 2009 15:58:42 -0800
Message-ID: <20090226235842.20192.21941.stgit@localhost>
References: <20090226235042.20192.38338.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53122 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbZBZX6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 18:58:45 -0500
In-Reply-To: <20090226235042.20192.38338.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Move the defines to the board file and remove the now unnecessary
header file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c             |   14 ++++++++
 arch/arm/plat-omap/include/mach/board-osk.h |   47 ---------------------------
 arch/arm/plat-omap/include/mach/hardware.h  |    4 --
 3 files changed, 14 insertions(+), 51 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/board-osk.h

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 1a16ecb..9c4cac2 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -52,6 +52,20 @@
 #include <mach/tc.h>
 #include <mach/common.h>
 
+/* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
+#define OMAP_OSK_ETHR_START		0x04800300
+
+/* TPS65010 has four GPIOs.  nPG and LED2 can be treated like GPIOs with
+ * alternate pin configurations for hardware-controlled blinking.
+ */
+#define OSK_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
+#	define OSK_TPS_GPIO_USB_PWR_EN	(OSK_TPS_GPIO_BASE + 0)
+#	define OSK_TPS_GPIO_LED_D3	(OSK_TPS_GPIO_BASE + 1)
+#	define OSK_TPS_GPIO_LAN_RESET	(OSK_TPS_GPIO_BASE + 2)
+#	define OSK_TPS_GPIO_DSP_PWR_EN	(OSK_TPS_GPIO_BASE + 3)
+#	define OSK_TPS_GPIO_LED_D9	(OSK_TPS_GPIO_BASE + 4)
+#	define OSK_TPS_GPIO_LED_D2	(OSK_TPS_GPIO_BASE + 5)
+
 static struct mtd_partition osk_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
diff --git a/arch/arm/plat-omap/include/mach/board-osk.h b/arch/arm/plat-omap/include/mach/board-osk.h
deleted file mode 100644
index 3850cb1..0000000
--- a/arch/arm/plat-omap/include/mach/board-osk.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/board-osk.h
- *
- * Hardware definitions for TI OMAP5912 OSK board.
- *
- * Written by Dirk Behme <dirk.behme@de.bosch.com>
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
-#ifndef __ASM_ARCH_OMAP_OSK_H
-#define __ASM_ARCH_OMAP_OSK_H
-
-/* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
-#define OMAP_OSK_ETHR_START		0x04800300
-
-/* TPS65010 has four GPIOs.  nPG and LED2 can be treated like GPIOs with
- * alternate pin configurations for hardware-controlled blinking.
- */
-#define OSK_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
-#	define OSK_TPS_GPIO_USB_PWR_EN	(OSK_TPS_GPIO_BASE + 0)
-#	define OSK_TPS_GPIO_LED_D3	(OSK_TPS_GPIO_BASE + 1)
-#	define OSK_TPS_GPIO_LAN_RESET	(OSK_TPS_GPIO_BASE + 2)
-#	define OSK_TPS_GPIO_DSP_PWR_EN	(OSK_TPS_GPIO_BASE + 3)
-#	define OSK_TPS_GPIO_LED_D9	(OSK_TPS_GPIO_BASE + 4)
-#	define OSK_TPS_GPIO_LED_D2	(OSK_TPS_GPIO_BASE + 5)
-
-#endif /*  __ASM_ARCH_OMAP_OSK_H */
-
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 0b1b91f..201a8fa 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -314,10 +314,6 @@
 #include "board-apollon.h"
 #endif
 
-#ifdef CONFIG_MACH_OMAP_OSK
-#include "board-osk.h"
-#endif
-
 #ifdef CONFIG_MACH_VOICEBLUE
 #include "board-voiceblue.h"
 #endif

