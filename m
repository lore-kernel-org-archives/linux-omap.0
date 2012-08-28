From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 4/9] ARM: OMAP1: remove the crystal type tag parsing
Date: Wed, 29 Aug 2012 02:18:52 +0300
Message-ID: <1346195937-6383-5-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:32998 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2H1XTQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:16 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

The omap1 crystal setting uses the OMAP custom tags.
Those tags are not used in upstream kernel and therefore the crystal
type is never set by the tag parsing code on upstream kernels.
Remove the crystal tag parsing code.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap1/clock_data.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index c007d80..6a32b9b 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -25,7 +25,6 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/clkdev_omap.h>
-#include <plat/board.h>
 #include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
 
 #include <mach/hardware.h>
@@ -788,7 +787,6 @@ u32 cpu_mask;
 int __init omap1_clk_init(void)
 {
 	struct omap_clk *c;
-	const struct omap_clock_config *info;
 	int crystal_type = 0; /* Default 12 MHz */
 	u32 reg;
 
@@ -837,12 +835,6 @@ int __init omap1_clk_init(void)
 	ck_dpll1_p = clk_get(NULL, "ck_dpll1");
 	ck_ref_p = clk_get(NULL, "ck_ref");
 
-	info = omap_get_config(OMAP_TAG_CLOCK, struct omap_clock_config);
-	if (info != NULL) {
-		if (!cpu_is_omap15xx())
-			crystal_type = info->system_clock_type;
-	}
-
 	if (cpu_is_omap7xx())
 		ck_ref.rate = 13000000;
 	if (cpu_is_omap16xx() && crystal_type == 2)
-- 
1.7.8.6

