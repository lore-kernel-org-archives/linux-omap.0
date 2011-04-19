From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Tue, 19 Apr 2011 17:16:55 +0300
Message-ID: <1303222615.32281.91.camel@deskari>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	 <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
	 <20110416130929.GL4423@n2100.arm.linux.org.uk>
	 <20110418064838.GE12272@atomide.com> <1303110011.2062.7.camel@deskari>
	 <20110418081743.GH12272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37848 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677Ab1DSORG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 10:17:06 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so7336301wwb.15
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 07:17:00 -0700 (PDT)
In-Reply-To: <20110418081743.GH12272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony and Russell,

On Mon, 2011-04-18 at 11:17 +0300, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [110418 09:57]:

> > So, I can make a patch that removes the SRAM support from omapfb, and
> > queue it up for the next merge window.
> 
> OK. That patch should probably go into Russell's tree along with
> other SRAM related patches to avoid conflicts.

Here's a simple patch to remove SRAM support from omapfb. Or more
precisely, this just disables it.

I started to remove the SRAM support from the drivers, but the patches
got quite big and will probably cause conflicts if they reside in
somebody else's tree than mine. So I believe it's easiest to divide SRAM
FB removal into this patch, handled by Russell (?), and then the rest,
handled by me.

Is there something else related to OMAP FB than the code removed in this
patch that is hindering the SRAM work?

 Tomi


>From 8a32eb1762d9ecead1aee08cbe955748d67999fd Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 19 Apr 2011 16:58:51 +0300
Subject: [PATCH] OMAP: Remove reserve_sram calls to omapfb

This patch removes calls from arch/arm/plat-omap/sram.c to
omapfb_reserve_sram() and omap_vram_reserve_sram(), effectively
disabling SRAM support for the old and new display drivers.

SRAM code in the display drivers will be removed in separate patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/sram.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..e10eeed 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/omapfb.h>
 
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
@@ -32,7 +31,6 @@
 #include <plat/vram.h>
 
 #include "sram.h"
-#include "fb.h"
 
 /* XXX These "sideways" includes are a sign that something is wrong */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
@@ -170,17 +168,6 @@ static void __init omap_detect_sram(void)
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
-- 
1.7.1



