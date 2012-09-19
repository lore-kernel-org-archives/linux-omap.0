From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 21/29] ARM: OMAP2+: Make gpmc-smc91x.h local
Date: Wed, 19 Sep 2012 14:06:24 -0700
Message-ID: <20120919210624.28074.38568.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:25 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c           |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c  |    2 +-
 arch/arm/mach-omap2/gpmc-smc91x.c             |    2 +-
 arch/arm/mach-omap2/gpmc-smc91x.h             |    0 
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/{plat-omap/include/plat/gpmc-smc91x.h => mach-omap2/gpmc-smc91x.h} (100%)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 0900eac..95b384d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -36,7 +36,7 @@
 #include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
-#include <plat/gpmc-smc91x.h>
+#include "gpmc-smc91x.h"
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5453173..fe354dc 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -37,7 +37,7 @@
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
 
-#include <plat/gpmc-smc91x.h>
+#include "gpmc-smc91x.h"
 
 #include "board-flash.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index c7d6ea2..f1df601 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -17,7 +17,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include <plat/gpmc-smc91x.h>
+#include "gpmc-smc91x.h"
 #include <plat/usb.h>
 
 #include "board-zoom.h"
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bf78ad4..93bb5b8 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,7 +32,7 @@
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
-#include <plat/gpmc-smc91x.h>
+#include "gpmc-smc91x.h"
 #include <plat/omap-pm.h>
 
 #include "board-rx51.h"
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 245839d..5654753 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -18,7 +18,7 @@
 #include <linux/smc91x.h>
 
 #include <plat/gpmc.h>
-#include <plat/gpmc-smc91x.h>
+#include "gpmc-smc91x.h"
 
 #include "soc.h"
 
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smc91x.h b/arch/arm/mach-omap2/gpmc-smc91x.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/gpmc-smc91x.h
rename to arch/arm/mach-omap2/gpmc-smc91x.h

