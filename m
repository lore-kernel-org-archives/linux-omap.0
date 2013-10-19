From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v10 10/10] mtd: nand: omap: remove selection of BCH ecc-scheme via KConfig
Date: Sat, 19 Oct 2013 14:14:14 +0530
Message-ID: <1382172254-12448-11-git-send-email-pekon@ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36457 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab3JSIp4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Oct 2013 04:45:56 -0400
In-Reply-To: <1382172254-12448-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

With OMAP NAND driver updates, selection of ecc-scheme:
*DT enabled kernel*
 	depends on ti,nand-ecc-opt and ti,elm-id DT bindings.
*Non DT enabled kernel*
	depends on elm_dev and ecc-scheme passed along with platform-data
	from board file.

So, selection of ecc-scheme (BCH8 or BCH4) from KConfig can be removed

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/Kconfig | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index d885298..93ae6a6 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -96,43 +96,15 @@ config MTD_NAND_OMAP2
 
 config MTD_NAND_OMAP_BCH
 	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
-	tristate "Enable support for hardware BCH error correction"
+	tristate "Support hardware based BCH error correction"
 	default n
 	select BCH
-	select BCH_CONST_PARAMS
 	help
-	 Support for hardware BCH error correction.
-
-choice
-	prompt "BCH error correction capability"
-	depends on MTD_NAND_OMAP_BCH
-
-config MTD_NAND_OMAP_BCH8
-	bool "8 bits / 512 bytes (recommended)"
-	help
-	 Support correcting up to 8 bitflips per 512-byte block.
-	 This will use 13 bytes of spare area per 512 bytes of page data.
-	 This is the recommended mode, as 4-bit mode does not work
-	 on some OMAP3 revisions, due to a hardware bug.
-
-config MTD_NAND_OMAP_BCH4
-	bool "4 bits / 512 bytes"
-	help
-	 Support correcting up to 4 bitflips per 512-byte block.
-	 This will use 7 bytes of spare area per 512 bytes of page data.
-	 Note that this mode does not work on some OMAP3 revisions, due to a
-	 hardware bug. Please check your OMAP datasheet before selecting this
-	 mode.
-
-endchoice
-
-if MTD_NAND_OMAP_BCH
-config BCH_CONST_M
-	default 13
-config BCH_CONST_T
-	default 4 if MTD_NAND_OMAP_BCH4
-	default 8 if MTD_NAND_OMAP_BCH8
-endif
+	  This config enables the ELM hardware engine, which can be used to
+	  locate and correct errors when using BCH ECC scheme. This offloads
+	  the cpu from doing ECC error searching and correction. However some
+	  legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
+	  so they should not enable this config symbol.
 
 config MTD_NAND_IDS
 	tristate
-- 
1.8.1

