From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 8/9] ARM: OMAP: move debug_card_init() function
Date: Wed, 29 Aug 2012 02:18:56 +0300
Message-ID: <1346195937-6383-9-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36776 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab2H1XTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:21 -0400
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

debug_card_init() function resides in the plat/board.h file.
Move it to a separate header file under plat/ so the board.h file can be
removed.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-h4.c                  |    2 +-
 arch/arm/plat-omap/include/plat/board.h         |    5 -----
 arch/arm/plat-omap/include/plat/debug-devices.h |    9 +++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/debug-devices.h

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index ace2048..5be30e6 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -32,11 +32,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board.h>
 #include "common.h"
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
+#include <plat/debug-devices.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 2ddc198..d92f1b5 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -10,9 +10,4 @@
 #ifndef _OMAP_BOARD_H
 #define _OMAP_BOARD_H
 
-#include <linux/types.h>
-
-/* for TI reference platforms sharing the same debug card */
-extern int debug_card_init(u32 addr, unsigned gpio);
-
 #endif
diff --git a/arch/arm/plat-omap/include/plat/debug-devices.h b/arch/arm/plat-omap/include/plat/debug-devices.h
new file mode 100644
index 0000000..a4edbd2
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/debug-devices.h
@@ -0,0 +1,9 @@
+#ifndef _OMAP_DEBUG_DEVICES_H
+#define _OMAP_DEBUG_DEVICES_H
+
+#include <linux/types.h>
+
+/* for TI reference platforms sharing the same debug card */
+extern int debug_card_init(u32 addr, unsigned gpio);
+
+#endif
-- 
1.7.8.6

