From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 02/23] OMAP3 SRAM: mark OCM RAM as Non-cacheable Normal memory
Date: Thu, 11 Dec 2008 17:52:21 +0200
Message-ID: <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53900 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbYLKP6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:58:48 -0500
In-Reply-To: <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Mark the SRAM (aka OCM RAM) as Non-cacheable Normal memory[1].  This
is to prevent the ARM from evicting existing cache lines to SDRAM
while code is executing from the SRAM.  Necessary since one of the
primary uses for the SRAM is to hold the code and data for the CORE
DPLL M2 divider reprogramming code, which must execute while the SDRC
is idled.  If the ARM attempts to write cache lines back to the while
the SRAM code is running, the ARM will stall[2].

TI deals with this problem in the CDP kernel by marking the SRAM as
Strongly-ordered memory.

Tero Kristo <tero.kristo@nokia.com> caught a bug in an earlier version of
this patch - thanks Tero.

...

1. ARMv7 ARM (DDI 0406A) pp. A3-30, A3-31, B3-32.

2. Private communication with Richard Woodruff <r-woodruff2@ti.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/plat-omap/sram.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm/plat-omap/sram.c

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
old mode 100755
new mode 100644
index abcc05b..04214e1
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -207,6 +207,15 @@ void __init omap_map_sram(void)
 		base = OMAP3_SRAM_PA;
 		base = ROUND_DOWN(base, PAGE_SIZE);
 		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+
+		/*
+		 * SRAM must be marked as non-cached on OMAP3 since the
+		 * CORE DPLL M2 divider change code (in SRAM) runs with the
+		 * SDRAM controller disabled, and if it is marked cached,
+		 * the ARM may attempt to write cache lines back to SDRAM
+		 * which will cause the system to hang.
+		 */
+		omap_sram_io_desc[0].type = MT_MEMORY_NONCACHED;
 	}
 
 	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
-- 
1.5.4.3

