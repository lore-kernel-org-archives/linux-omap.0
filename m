From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 7/7] omap3 evm, beagle and overo use the generic twl4030 script
Date: Fri, 10 Oct 2008 19:56:16 +0300
Message-ID: <1223657776-16544-8-git-send-email-peter.de-schrijver@nokia.com>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-6-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-7-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42990 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822AbYJJQ4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 12:56:33 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9AGuRT8013211
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 19:56:30 +0300
In-Reply-To: <1223657776-16544-7-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Make omap3 evm, beagle and overo use the generic twl4030 script.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/Makefile            |    9 ++++++---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 arch/arm/mach-omap2/board-omap3evm.c    |    3 +++
 arch/arm/mach-omap2/board-overo.c       |    3 +++
 4 files changed, 15 insertions(+), 3 deletions(-)

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
index 19702c7..1579a5e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -51,6 +51,8 @@
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
+extern struct twl4030_power_data generic3430_t2scripts_data;
+
 static struct mtd_partition omap3beagle_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -149,6 +151,7 @@ static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
+	.power		= &generic3430_t2scripts_data,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3538067..dd7d1b7 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -42,6 +42,8 @@
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
+extern struct twl4030_power_data generic3430_t2scripts_data;
+
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start  = OMAP3EVM_ETHR_START,
@@ -139,6 +141,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.keypad		= &omap3evm_kp_data,
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
+	.power		= &generic3430_t2scripts_data,
 	.gpio		= &omap3evm_gpio_data,
 };
 
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4e2781a..4d2203f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -55,6 +55,8 @@
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
 
+extern struct twl4030_power_data generic3430_t2scripts_data;
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -160,6 +162,7 @@ static struct twl4030_platform_data overo_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
+	.power		= &generic3430_t2scripts_data,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
-- 
1.5.6.3

