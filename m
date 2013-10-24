From: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v11 10/10] mtd: nand: omap: remove selection of BCH ecc-scheme via KConfig
Date: Thu, 24 Oct 2013 18:20:26 +0530
Message-ID: <1382619026-4182-11-git-send-email-pekon@ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382619026-4182-1-git-send-email-pekon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mark.rutland-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pawel.Moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jp.francois-JOfcSVQZ0GHQT0dZR+AlfA@public.gmane.org, ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org, Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With OMAP NAND driver updates, selection of ecc-scheme:
*DT enabled kernel*
 	depends on ti,nand-ecc-opt and ti,elm-id DT bindings.
*Non DT enabled kernel*
	depends on elm_dev and ecc-scheme passed along with platform-data
	from board file.

So, selection of ecc-scheme (BCH8 or BCH4) from KConfig can be removed

Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
