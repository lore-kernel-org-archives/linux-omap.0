From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/14] ARM: OMAP: Change __REG access to omap/read write for traffic controller
Date: Tue, 27 May 2008 21:20:08 -0700
Message-ID: <1211948418-16455-5-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64544 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbYE1EU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:26 -0400
In-Reply-To: <1211948418-16455-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Change __REG access to omap/read write for traffic controller

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c |   11 ++++++++---
 drivers/mtd/maps/omap_nor.c     |   15 +++++++++++----
 drivers/pcmcia/omap_cf.c        |    6 +++---
 include/asm-arm/arch-omap/tc.h  |   10 ++++------
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index f2c47b9..845c663 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -267,13 +267,17 @@ static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 
 static void __init osk_init_smc91x(void)
 {
+	u32 l;
+
 	if ((gpio_request(0, "smc_irq")) < 0) {
 		printk("Error requesting gpio 0 for smc91x irq\n");
 		return;
 	}
 
 	/* Check EMIFS wait states to fix errors with SMC_GET_PKT_HDR */
-	EMIFS_CCS(1) |= 0x3;
+	l = omap_readl(EMIFS_CCS(1));
+	l |= 0x3;
+	omap_writel(l, EMIFS_CCS(1));
 }
 
 static void __init osk_init_cf(void)
@@ -533,8 +537,9 @@ static void __init osk_init(void)
 	 * wrong CS3 memory timings. This mainly leads to CRC
 	 * or similar errors if you use NOR flash (e.g. with JFFS2)
 	 */
-	if (EMIFS_CCS(3) != EMIFS_CS3_VAL)
-		EMIFS_CCS(3) = EMIFS_CS3_VAL;
+	l = omap_readl(EMIFS_CCS(3));
+	if (l != EMIFS_CS3_VAL)
+		omap_writel(EMIFS_CS3_VAL, EMIFS_CCS(3));
 
 	osk_flash_resource.end = osk_flash_resource.start = omap_cs3_phys();
 	osk_flash_resource.end += SZ_32M - 1;
diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
index dca13a7..2e0a277 100644
--- a/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -60,14 +60,21 @@ struct omapflash_info {
 static void omap_set_vpp(struct map_info *map, int enable)
 {
 	static int	count;
+	u32 l;
 
 	if (cpu_class_is_omap1()) {
 		if (enable) {
-			if (count++ == 0)
-				OMAP_EMIFS_CONFIG_REG |= OMAP_EMIFS_CONFIG_WP;
+			if (count++ == 0) {
+				l = omap_readl(EMIFS_CONFIG);
+				l |= OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
 		} else {
-			if (count && (--count == 0))
-				OMAP_EMIFS_CONFIG_REG &= ~OMAP_EMIFS_CONFIG_WP;
+			if (count && (--count == 0)) {
+				l = omap_readl(EMIFS_CONFIG);
+				l &= ~OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
 		}
 	}
 }
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index a7d9e4b..569b746 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -279,9 +279,9 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	 * CF/PCMCIA variants...
 	 */
 	pr_debug("%s: cs%d, previous ccs %08x acs %08x\n", driver_name,
-			seg, EMIFS_CCS(seg), EMIFS_ACS(seg));
-	EMIFS_CCS(seg) = 0x0004a1b3;	/* synch mode 4 etc */
-	EMIFS_ACS(seg) = 0x00000000;	/* OE hold/setup */
+		seg, omap_readl(EMIFS_CCS(seg)), omap_readl(EMIFS_ACS(seg)));
+	omap_writel(0x0004a1b3, EMIFS_CCS(seg));	/* synch mode 4 etc */
+	omap_writel(0x00000000, EMIFS_ACS(seg));	/* OE hold/setup */
 
 	/* CF uses armxor_ck, which is "always" available */
 
diff --git a/include/asm-arm/arch-omap/tc.h b/include/asm-arm/arch-omap/tc.h
index 8ded218..65a9c82 100644
--- a/include/asm-arm/arch-omap/tc.h
+++ b/include/asm-arm/arch-omap/tc.h
@@ -75,16 +75,14 @@
 #ifndef	__ASSEMBLER__
 
 /* EMIF Slow Interface Configuration Register */
-#define	OMAP_EMIFS_CONFIG_REG	__REG32(EMIFS_CONFIG)
-
 #define OMAP_EMIFS_CONFIG_FR		(1 << 4)
 #define OMAP_EMIFS_CONFIG_PDE		(1 << 3)
 #define OMAP_EMIFS_CONFIG_PWD_EN	(1 << 2)
 #define OMAP_EMIFS_CONFIG_BM		(1 << 1)
 #define OMAP_EMIFS_CONFIG_WP		(1 << 0)
 
-#define EMIFS_CCS(n)		__REG32(EMIFS_CS0_CONFIG + (4 * (n)))
-#define EMIFS_ACS(n)		__REG32(EMIFS_ACS0 + (4 * (n)))
+#define EMIFS_CCS(n)		(EMIFS_CS0_CONFIG + (4 * (n)))
+#define EMIFS_ACS(n)		(EMIFS_ACS0 + (4 * (n)))
 
 /* Almost all documentation for chip and board memory maps assumes
  * BM is clear.  Most devel boards have a switch to control booting
@@ -93,13 +91,13 @@
  */
 static inline u32 omap_cs0_phys(void)
 {
-	return (OMAP_EMIFS_CONFIG_REG & OMAP_EMIFS_CONFIG_BM)
+	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
 			?  OMAP_CS3_PHYS : 0;
 }
 
 static inline u32 omap_cs3_phys(void)
 {
-	return (OMAP_EMIFS_CONFIG_REG & OMAP_EMIFS_CONFIG_BM)
+	return (omap_readl(EMIFS_CONFIG) & OMAP_EMIFS_CONFIG_BM)
 			? 0 : OMAP_CS3_PHYS;
 }
 
-- 
1.5.3.6

