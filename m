From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 22/29] ARM: OMAP2+: Make gpmc-smsc911x.h local
Date: Wed, 19 Sep 2012 14:06:26 -0700
Message-ID: <20120919210626.28074.18747.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26534 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:27 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-cm-t35.c              |    2 +-
 arch/arm/mach-omap2/board-igep0020.c            |    2 +-
 arch/arm/mach-omap2/board-ldp.c                 |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c            |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c          |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c        |    2 +-
 arch/arm/mach-omap2/board-overo.c               |    2 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c     |    2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c             |    2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.h             |    0 
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename arch/arm/{plat-omap/include/plat/gpmc-smsc911x.h => mach-omap2/gpmc-smsc911x.h} (100%)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2cbb825..f3a9cec 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -64,7 +64,7 @@
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
 	.id		= 0,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 1b2e9a3..e2a94d8f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -192,7 +192,7 @@ static void __init igep_flash_init(void) {}
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
 	.cs             = IGEP2_SMSC911X_CS,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d0372a6..5682147 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -38,7 +38,7 @@
 #include <plat/gpmc.h>
 #include "board-zoom.h"
 #include <plat/usb.h>
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6a1c849..9d54178 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -119,7 +119,7 @@ static void __init omap3_evm_get_revision(void)
 }
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
 	.cs             = OMAP3EVM_SMSC911X_CS,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index b5e56fa..7bd8253 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index b8756f0..a083f81 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -60,7 +60,7 @@
 #include "common-board-devices.h"
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 #define OMAP3STALKER_ETHR_START	0x2c000000
 #define OMAP3STALKER_ETHR_SIZE	1024
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 90d57fb..e34a1ea 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -113,7 +113,7 @@ static inline void __init overo_ads7846_init(void) { return; }
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
 	.id		= 0,
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 42c97c2..36c8767 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -18,7 +18,7 @@
 #include <linux/regulator/machine.h>
 
 #include <plat/gpmc.h>
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 #include "board-zoom.h"
 
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index a3a2887..249a0b4 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -21,7 +21,7 @@
 #include <linux/smsc911x.h>
 
 #include <plat/gpmc.h>
-#include <plat/gpmc-smsc911x.h>
+#include "gpmc-smsc911x.h"
 
 static struct resource gpmc_smsc911x_resources[] = {
 	[0] = {
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/arm/mach-omap2/gpmc-smsc911x.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
rename to arch/arm/mach-omap2/gpmc-smsc911x.h

