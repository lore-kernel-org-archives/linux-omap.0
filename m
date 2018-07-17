From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 3/3] ARM: OMAP1: ams-delta: make board header file local to mach-omap1
Date: Wed, 18 Jul 2018 01:14:48 +0200
Message-ID: <20180717231448.14958-4-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717231448.14958-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Shreeya Patel <shreeya.patel23498@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchen>
List-Id: linux-omap@vger.kernel.org

Now as board header file is no longer included by drivers, move it to
the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Depends on patches 1/3 and 2/3 of the series.

 arch/arm/mach-omap1/ams-delta-fiq-handler.S              | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                      | 3 +--
 arch/arm/mach-omap1/board-ams-delta.c                    | 2 +-
 arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (98%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index ddc27638ba2a..2e2a17364dc9 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -17,9 +17,9 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 
 #include <asm/assembler.h>
-#include <mach/board-ams-delta.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index b0dc7ddf5877..14c3d3f5255e 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -22,11 +22,10 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <asm/fiq.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd28d2614d7f..34cb63ff45b3 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ams-delta.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/mux.h>
 
@@ -45,6 +44,7 @@
 #include <mach/usb.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/include/mach/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
similarity index 98%
rename from arch/arm/mach-omap1/include/mach/board-ams-delta.h
rename to arch/arm/mach-omap1/board-ams-delta.h
index ad6f865d1f16..1fbada29431a 100644
--- a/arch/arm/mach-omap1/include/mach/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/board-ams-delta.h
+ * arch/arm/mach-omap1/board-ams-delta.h
  *
  * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
  *
-- 
2.16.4
