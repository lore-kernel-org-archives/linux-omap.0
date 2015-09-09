From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] ARM: omap2+: board-generic: Remove stale of_irq macros
Date: Wed, 9 Sep 2015 16:18:12 -0500
Message-ID: <1441833494-32450-3-git-send-email-nm@ti.com>
References: <1441833494-32450-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441833494-32450-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

When commit c4082d499fa2 ("ARM: omap2+: board-generic: clean up the
irq data from board file") cleaned up the direct usage of gic_of_init
and omap_intc_of_init, it failed to clean up the macros properly.

Since these macros are no longer used, lets just remove them.

Fixes: c4082d499fa2 ("ARM: omap2+: board-generic: clean up the irq data from board file")
Reported-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 24c9afc9e8a7..6133eaac685d 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -20,13 +20,6 @@
 
 #include "common.h"
 
-#if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
-#define intc_of_init	NULL
-#endif
-#ifndef CONFIG_ARCH_OMAP4
-#define gic_of_init		NULL
-#endif
-
 static const struct of_device_id omap_dt_match_table[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "ti,omap-infra", },
-- 
1.7.9.5
