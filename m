From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/10] ARM: OMAP3: Add SRAM support for 3430
Date: Wed, 12 Mar 2008 12:45:44 +0200
Message-ID: <1205318750-9596-5-git-send-email-tony@atomide.com>
References: 34xx-2008-03-12
 <1205318750-9596-1-git-send-email-tony@atomide.com>
 <1205318750-9596-2-git-send-email-tony@atomide.com>
 <1205318750-9596-3-git-send-email-tony@atomide.com>
 <1205318750-9596-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49225 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYCLKqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 06:46:09 -0400
In-Reply-To: <1205318750-9596-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Dasu, Karthik P" <karthik-dp@ti.com>, Tony Lindgren <tony@atomide.com>

From: Dasu, Karthik P <karthik-dp@ti.com>

Add SRAM support for 3430

Patch modified by Tony to leave out new functions,
they will be added later in a separate patch.

Signed-off-by: Karthik Dasu<karthik-dp@ti.com>
Acked-by: Richard Woodruff <r-woodruff2@ti.com>
Acked-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |   56 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 6b1ce47..1186d2b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -39,6 +39,10 @@
 #define OMAP2_SRAM_PUB_PA	0x4020f800
 #define OMAP2_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
+#define OMAP3_SRAM_PA           0x40200000
+#define OMAP3_SRAM_VA           0xd7000000
+#define OMAP3_SRAM_PUB_PA       0x40208000
+#define OMAP3_SRAM_PUB_VA       0xd7008000
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -49,6 +53,14 @@
 #define OMAP24XX_VA_REQINFOPERM0	IO_ADDRESS(0x68005048)
 #define OMAP24XX_VA_READPERM0		IO_ADDRESS(0x68005050)
 #define OMAP24XX_VA_WRITEPERM0		IO_ADDRESS(0x68005058)
+
+#define OMAP34XX_VA_REQINFOPERM0	IO_ADDRESS(0x68012848)
+#define OMAP34XX_VA_READPERM0		IO_ADDRESS(0x68012850)
+#define OMAP34XX_VA_WRITEPERM0		IO_ADDRESS(0x68012858)
+#define OMAP34XX_VA_ADDR_MATCH2		IO_ADDRESS(0x68012880)
+#define OMAP34XX_VA_SMS_RG_ATT0		IO_ADDRESS(0x6C000048)
+#define OMAP34XX_VA_CONTROL_STAT	IO_ADDRESS(0x480022F0)
+
 #define GP_DEVICE		0x300
 
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
@@ -102,6 +114,13 @@ static int is_sram_locked(void)
 			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
 		}
+		if (cpu_is_omap34xx()) {
+			__raw_writel(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
+			__raw_writel(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
+			__raw_writel(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
+			__raw_writel(0x0, OMAP34XX_VA_ADDR_MATCH2);
+			__raw_writel(0xFFFFFFFF, OMAP34XX_VA_SMS_RG_ATT0);
+		}
 		return 0;
 	} else
 		return 1; /* assume locked with no PPA or security driver */
@@ -119,16 +138,28 @@ void __init omap_detect_sram(void)
 
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
-			omap_sram_base = OMAP2_SRAM_PUB_VA;
-			omap_sram_start = OMAP2_SRAM_PUB_PA;
-			omap_sram_size = 0x800; /* 2K */
+			if (cpu_is_omap34xx()) {
+				omap_sram_base = OMAP3_SRAM_PUB_VA;
+				omap_sram_start = OMAP3_SRAM_PUB_PA;
+				omap_sram_size = 0x8000; /* 32K */
+			} else {
+				omap_sram_base = OMAP2_SRAM_PUB_VA;
+				omap_sram_start = OMAP2_SRAM_PUB_PA;
+				omap_sram_size = 0x800; /* 2K */
+			}
 		} else {
-			omap_sram_base = OMAP2_SRAM_VA;
-			omap_sram_start = OMAP2_SRAM_PA;
-			if (cpu_is_omap242x())
-				omap_sram_size = 0xa0000; /* 640K */
-			else if (cpu_is_omap243x() || cpu_is_omap34xx())
+			if (cpu_is_omap34xx()) {
+				omap_sram_base = OMAP3_SRAM_VA;
+				omap_sram_start = OMAP3_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
+			} else {
+				omap_sram_base = OMAP2_SRAM_VA;
+				omap_sram_start = OMAP2_SRAM_PA;
+				if (cpu_is_omap242x())
+					omap_sram_size = 0xa0000; /* 640K */
+				else if (cpu_is_omap243x())
+					omap_sram_size = 0x10000; /* 64K */
+			}
 		}
 	} else {
 		omap_sram_base = OMAP1_SRAM_VA;
@@ -174,7 +205,7 @@ void __init omap_map_sram(void)
 	if (omap_sram_size == 0)
 		return;
 
-	if (cpu_class_is_omap2()) {
+	if (cpu_is_omap24xx()) {
 		omap_sram_io_desc[0].virtual = OMAP2_SRAM_VA;
 
 		base = OMAP2_SRAM_PA;
@@ -182,6 +213,13 @@ void __init omap_map_sram(void)
 		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
 	}
 
+	if (cpu_is_omap34xx()) {
+		omap_sram_io_desc[0].virtual = OMAP3_SRAM_VA;
+		base = OMAP3_SRAM_PA;
+		base = ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+	}
+
 	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
-- 
1.5.3.6

