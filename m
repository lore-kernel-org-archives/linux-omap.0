From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: make board header file local to mach-omap1
Date: Tue,  6 Nov 2018 00:11:26 +0100
Message-ID: <20181105231126.12674-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Now as the board header file is no longer included by drivers, move it
to the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v4:
- rebased on top of v4.20-rc1
- resubmitted as a standalone patch, other patches of the series it
  depended on have been already applied

v3:
- rebased on top of v4.19-rc1
- submitted as PATCH v3 3/3

v2:
- resent as PATCH v2 3/3

Initially submitted in series as PATCH 6/6


 arch/arm/mach-omap1/ams-delta-fiq-handler.S              | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                      | 3 +--
 arch/arm/mach-omap1/board-ams-delta.c                    | 2 +-
 arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (97%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index e3faa0274b56..7c9fb7fe0070 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -18,9 +18,9 @@
 #include <linux/platform_data/gpio-omap.h>
 
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
index 3d191fd52910..b8acc9912a58 100644
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
similarity index 97%
rename from arch/arm/mach-omap1/include/mach/board-ams-delta.h
rename to arch/arm/mach-omap1/board-ams-delta.h
index 3b2d8019238a..a74a306d7e77 100644
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
