From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init() visible to board code
Date: Wed,  4 Apr 2012 20:36:25 +0200
Message-ID: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51447 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2DDShN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 14:37:13 -0400
Received: by wgbds11 with SMTP id ds11so744276wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 11:37:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Enric=20Balletb=C3=B2=20i=20Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, Javier Martinez Canillas <javier@dowhile0.org>

board_onenand_init() and board_nand_init() initialization functions are
used to initialize OneNAND and NAND memories respectively. But only
board_nand_init() was visible to be used from board code. This patch makes
possible to initialize a OneNAND flash memory within platform code.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/mach-omap2/board-flash.c |    4 ++--
 arch/arm/mach-omap2/board-flash.h |   11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 0349fd2..70a81f9 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -87,7 +87,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 	.dma_channel	= -1,   /* disable DMA in OMAP OneNAND driver */
 };
 
-static void
+void
 __init board_onenand_init(struct mtd_partition *onenand_parts,
 				u8 nr_parts, u8 cs)
 {
@@ -98,7 +98,7 @@ __init board_onenand_init(struct mtd_partition *onenand_parts,
 	gpmc_onenand_init(&board_onenand_data);
 }
 #else
-static void
+void
 __init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
 {
 }
diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
index d25503a..c44b70d 100644
--- a/arch/arm/mach-omap2/board-flash.h
+++ b/arch/arm/mach-omap2/board-flash.h
@@ -47,3 +47,14 @@ static inline void board_nand_init(struct mtd_partition *nand_parts,
 {
 }
 #endif
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+extern void board_onenand_init(struct mtd_partition *nand_parts,
+					u8 nr_parts, u8 cs);
+#else
+static inline void board_onenand_init(struct mtd_partition *nand_parts,
+					u8 nr_parts, u8 cs)
+{
+}
+#endif
-- 
1.7.7.6

