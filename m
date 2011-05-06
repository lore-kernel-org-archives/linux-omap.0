From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2] omap: fix build when MTD_NAND_OMAP2 and TOUCHSCREEN_ADS7846 are disabled
Date: Fri,  6 May 2011 22:58:13 +0300
Message-ID: <1304711893-24299-1-git-send-email-mike@compulab.co.il>
References: <20110506072523.GA25670@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:35942
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932160Ab1EFT6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 15:58:25 -0400
In-Reply-To: <20110506072523.GA25670@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>, Oleg Drokin <green@linuxhacker.ru>

Commits 5e6a64b36ce346b7a2d481ef9fa315290eb28e5e (omap: move detection of
NAND CS to common-board-devices) and 96974a249b0cf3537f49115a59be67e2c54f315c
(omap: consolidate touch screen initialization among different boards)
break compilation when CONFIG_MTD_NAND_OMAP2 and
CONFIG_TOUCHSCREEN_ADS7846 are not selected.
Removing ifdefs and stubs from common-board-devices.h fixes the problem.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Oleg Drokin <green@linuxhacker.ru>
---
Hope this one is better.

 arch/arm/mach-omap2/common-board-devices.c |   15 +++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h |   17 -----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index d57c71d..e94903b 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -50,6 +50,8 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
@@ -105,7 +107,14 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
+#else
+void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
+			      struct ads7846_platform_data *board_pdata)
+{
+}
+#endif
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 static struct omap_nand_platform_data nand_data = {
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
 };
@@ -146,3 +155,9 @@ void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
+#else
+void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
+				 int nr_parts)
+{
+}
+#endif
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index ca03abf..eb80b3b 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -26,27 +26,10 @@ static inline void omap4_pmic_init(const char *pmic_type,
 	omap_pmic_init(1, 400, pmic_type, OMAP44XX_IRQ_SYS_1N, pmic_data);
 }
 
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
-	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 struct ads7846_platform_data;
 
 void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
-#else
-static inline void omap_ads7846_init(int bus_num,
-				     int gpio_pendown, int gpio_debounce,
-				     struct ads7846_platform_data *board_data)
-{
-}
-#endif
-
-#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
-#else
-static inline void omap_nand_flash_init(int opts, struct mtd_partition *parts,
-					int nr_parts)
-{
-}
-#endif
 
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
-- 
1.7.3.1

