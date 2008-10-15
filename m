From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 6/6] omap3 evm, beagle and overo use the generic twl4030 script
Date: Wed, 15 Oct 2008 16:37:34 +0300
Message-ID: <1224077854-23481-7-git-send-email-peter.de-schrijver@nokia.com>
References: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com>
 <1224077854-23481-2-git-send-email-peter.de-schrijver@nokia.com>
 <1224077854-23481-3-git-send-email-peter.de-schrijver@nokia.com>
 <1224077854-23481-4-git-send-email-peter.de-schrijver@nokia.com>
 <1224077854-23481-5-git-send-email-peter.de-schrijver@nokia.com>
 <1224077854-23481-6-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20601 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbYJONia (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 09:38:30 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FDbrlY011734
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 08:38:28 -0500
In-Reply-To: <1224077854-23481-6-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Make omap3 evm, beagle and overo use the generic twl4030 script.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/Makefile            |    9 ++++++---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
 arch/arm/mach-omap2/board-omap3evm.c    |    4 ++--
 arch/arm/mach-omap2/board-overo.c       |    4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 33de217..ed0cd7a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -58,10 +58,12 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 					   hsmmc.o \
 					   usb-musb.o usb-ehci.o \
-					   board-omap3evm-flash.o
+					   board-omap3evm-flash.o \
+					   twl4030-generic-scripts.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   usb-musb.o usb-ehci.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   twl4030-generic-scripts.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 					   hsmmc.o \
 					   usb-musb.o
@@ -77,7 +79,8 @@ obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   hsmmc.o \
 					   usb-musb.o \
-					   usb-ehci.o
+					   usb-ehci.o \
+					   twl4030-generic-scripts.o
 
 # TUSB 6010 chips
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 19702c7..cc9506b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -24,8 +24,6 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
-#include <linux/i2c/twl4030.h>
-
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
@@ -45,6 +43,7 @@
 #include <mach/nand.h>
 #include <mach/mux.h>
 
+#include "twl4030-generic-scripts.h"
 
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
@@ -149,6 +148,7 @@ static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
+	.power		= &generic3430_t2scripts_data,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3538067..a72772f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -20,8 +20,6 @@
 #include <linux/clk.h>
 #include <linux/input.h>
 
-#include <linux/i2c/twl4030.h>
-
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
@@ -41,6 +39,7 @@
 #include <mach/mcspi.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
+#include "twl4030-generic-scripts.h"
 
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
@@ -139,6 +138,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.keypad		= &omap3evm_kp_data,
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
+	.power		= &generic3430_t2scripts_data,
 	.gpio		= &omap3evm_gpio_data,
 };
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4e2781a..b0e5cec 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -27,8 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/twl4030.h>
-
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
@@ -50,6 +48,7 @@
 #include <mach/usb-musb.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
+#include "twl4030-generic-scripts.h"
 
 #define NAND_BLOCK_SIZE SZ_128K
 #define GPMC_CS0_BASE  0x60
@@ -160,6 +159,7 @@ static struct twl4030_platform_data overo_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
+	.power		= &generic3430_t2scripts_data,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
-- 
1.5.6.3

