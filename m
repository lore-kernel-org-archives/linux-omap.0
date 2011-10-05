From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP: Remove calls to SRAM allocations for
	framebuffer
Date: Tue, 04 Oct 2011 17:45:44 -0700
Message-ID: <20111005004544.26980.35612.stgit@kaulin.local>
References: <20111005004339.26980.31149.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19098 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753436Ab1JEApq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 20:45:46 -0400
In-Reply-To: <20111005004339.26980.31149.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

This assumes fixed mappings which will not work once we move
to use ioremap_exec(). It seems that these are currently
not in use, or in use for some out of tree corner cases.

If SRAM support for framebuffer is wanted, it should be done
with ioremap in the driver.

Note that further removal of the code can now be done,
but that can be done seprately by the driver maintainers.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 363c91e..3c8aa44 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/omapfb.h>
 
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
@@ -29,10 +28,8 @@
 #include <plat/sram.h>
 #include <plat/board.h>
 #include <plat/cpu.h>
-#include <plat/vram.h>
 
 #include "sram.h"
-#include "fb.h"
 
 /* XXX These "sideways" includes are a sign that something is wrong */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
@@ -112,8 +109,6 @@ static int is_sram_locked(void)
  */
 static void __init omap_detect_sram(void)
 {
-	unsigned long reserved;
-
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			if (cpu_is_omap34xx()) {
@@ -170,17 +165,6 @@ static void __init omap_detect_sram(void)
 			omap_sram_size = 0x4000;
 		}
 	}
-	reserved = omapfb_reserve_sram(omap_sram_start, omap_sram_base,
-				       omap_sram_size,
-				       omap_sram_start + SRAM_BOOTLOADER_SZ,
-				       omap_sram_size - SRAM_BOOTLOADER_SZ);
-	omap_sram_size -= reserved;
-
-	reserved = omap_vram_reserve_sram(omap_sram_start, omap_sram_base,
-			omap_sram_size,
-			omap_sram_start + SRAM_BOOTLOADER_SZ,
-			omap_sram_size - SRAM_BOOTLOADER_SZ);
-	omap_sram_size -= reserved;
 
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 }

