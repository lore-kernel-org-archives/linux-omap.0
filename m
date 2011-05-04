From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] omap: fix build when MTD_NAND_OMAP2 and TOUCHSCREEN_ADS7846 are disabled
Date: Wed,  4 May 2011 16:27:02 +0300
Message-ID: <1304515622-25113-1-git-send-email-mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:59640
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752128Ab1EDN1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 09:27:19 -0400
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
17 more lines are gone ;-)

 arch/arm/mach-omap2/common-board-devices.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

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

