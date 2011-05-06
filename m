From: Matthias Scheer <scheer@in.tum.de>
Subject: [PATCH] OMAP2: =?utf-8?b?Q09ORklHX1RPVUNIU0NSRUVOX0FEUzc4NDY=?= XOR =?utf-8?b?Q09ORklHX01URF9OQU5EX09NQVAy?= breaks build
Date: Fri, 6 May 2011 19:12:56 +0000 (UTC)
Message-ID: <loom.20110506T210326-622@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51474 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755125Ab1EFTNM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 15:13:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QIQSc-0005tI-6K
	for linux-omap@vger.kernel.org; Fri, 06 May 2011 21:13:10 +0200
Received: from ppp-93-104-17-21.dynamic.mnet-online.de ([93.104.17.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 21:13:10 +0200
Received: from scheer by ppp-93-104-17-21.dynamic.mnet-online.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 06 May 2011 21:13:10 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

#ifdef clauses in arch/arm/mach-omap2/common-board-devices.h header file broke
kernel build when configured with CONFIG_TOUCHSCREEN_ADS7846 (XOR)
CONFIG_MTD_NAND_OMAP2

quick and dirty fix by using #ifdef clauses in the code file, too

---
 arch/arm/mach-omap2/common-board-devices.c |    7 +++++++
 arch/arm/mach-omap2/common-board-devices.h |    3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c
b/arch/arm/mach-omap2/common-board-devices.c
index d57c71d..4f290e9 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -50,6 +50,9 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
@@ -105,7 +108,9 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown,
int gpio_debounce,
 
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
+#endif
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 static struct omap_nand_platform_data nand_data = {
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
 };
@@ -146,3 +151,5 @@ void __init omap_nand_flash_init(int options, struct
mtd_partition *parts,
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
+#endif
+
diff --git a/arch/arm/mach-omap2/common-board-devices.h
b/arch/arm/mach-omap2/common-board-devices.h
index ca03abf..eb4a07a 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -3,6 +3,7 @@
 
 struct twl4030_platform_data;
 struct mtd_partition;
+struct ads7846_platform_data;
 
 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
 		    struct twl4030_platform_data *pmic_data);
@@ -28,8 +29,6 @@ static inline void omap4_pmic_init(const char *pmic_type,
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-struct ads7846_platform_data;
-
 void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
 #else
-- 
1.7.1



