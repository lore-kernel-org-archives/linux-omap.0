From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2] arm: omap2plus: move NAND_BLOCK_SIZE out of boards
Date: Sun, 15 May 2011 14:38:19 +0300
Message-ID: <1305459499-30114-1-git-send-email-grinberg@compulab.co.il>
References: <4DCA4AC4.10002@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:46321
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759869Ab1EOLic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 May 2011 07:38:32 -0400
In-Reply-To: <4DCA4AC4.10002@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Several boards defining mtd partitions also defined NAND_BLOCK_SIZE as
SZ_128K. Move the define to common-board-devices.h

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2:	fix compile for cm-t3517

Another idea is to replace the mtd partitions definition by using a macro
and it generates a very nice diff stat. I'm working on it right now.
It does not intervent with this patch,
so here it is again regardless of what I've said in previous email.

 arch/arm/mach-omap2/board-cm-t35.c         |    2 --
 arch/arm/mach-omap2/board-cm-t3517.c       |    3 +--
 arch/arm/mach-omap2/board-devkit8000.c     |    2 --
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 --
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 --
 arch/arm/mach-omap2/board-omap3touchbook.c |    2 --
 arch/arm/mach-omap2/board-overo.c          |    2 --
 arch/arm/mach-omap2/common-board-devices.h |    2 ++
 8 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 6063be8..b6d3a11 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -63,8 +63,6 @@
 #define SB_T35_SMSC911X_CS	4
 #define SB_T35_SMSC911X_GPIO	65
 
-#define NAND_BLOCK_SIZE		SZ_128K
-
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
 #include <plat/gpmc-smsc911x.h>
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 08f08e8..f8b417b 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -48,6 +48,7 @@
 
 #include "mux.h"
 #include "control.h"
+#include "common-board-devices.h"
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led cm_t3517_leds[] = {
@@ -203,8 +204,6 @@ static inline int cm_t3517_init_usbh(void)
 #endif
 
 #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-#define NAND_BLOCK_SIZE		SZ_128K
-
 static struct mtd_partition cm_t3517_nand_partitions[] = {
 	{
 		.name           = "xloader",
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 3bd344a..a8dfde6 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -61,8 +61,6 @@
 #include "timer-gp.h"
 #include "common-board-devices.h"
 
-#define NAND_BLOCK_SIZE		SZ_128K
-
 #define OMAP_DM9000_GPIO_IRQ	25
 #define OMAP3_DEVKIT_TS_GPIO	27
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ff3a2c..e6c3289 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -54,8 +54,6 @@
 #include "pm.h"
 #include "common-board-devices.h"
 
-#define NAND_BLOCK_SIZE		SZ_128K
-
 /*
  * OMAP3 Beagle revision
  * Run time detection of Beagle revision is done by reading GPIO.
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 78dd2a7..44eda7c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -57,8 +57,6 @@
 #define PANDORA_WIFI_NRESET_GPIO	23
 #define OMAP3_PANDORA_TS_GPIO		94
 
-#define NAND_BLOCK_SIZE			SZ_128K
-
 static struct mtd_partition omap3pandora_nand_partitions[] = {
 	{
 		.name           = "xloader",
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 82872d7..5f649fa 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -56,8 +56,6 @@
 
 #include <asm/setup.h>
 
-#define NAND_BLOCK_SIZE		SZ_128K
-
 #define OMAP3_AC_GPIO		136
 #define OMAP3_TS_GPIO		162
 #define TB_BL_PWM_TIMER		9
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index c03f92b..2abc2c4 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -65,8 +65,6 @@
 #define OVERO_GPIO_USBH_CPEN	168
 #define OVERO_GPIO_USBH_NRESET	183
 
-#define NAND_BLOCK_SIZE SZ_128K
-
 #define OVERO_SMSC911X_CS      5
 #define OVERO_SMSC911X_GPIO    176
 #define OVERO_SMSC911X2_CS     4
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index eb80b3b..6797190 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -1,6 +1,8 @@
 #ifndef __OMAP_COMMON_BOARD_DEVICES__
 #define __OMAP_COMMON_BOARD_DEVICES__
 
+#define NAND_BLOCK_SIZE	SZ_128K
+
 struct twl4030_platform_data;
 struct mtd_partition;
 
-- 
1.7.3.4

