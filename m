From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/21] ARM: OMAP: Change omap_cf.c and omap_nor.c to use omap_readw/writew instead of __REG
Date: Fri,  6 Jun 2008 18:30:48 -0700
Message-ID: <1212802253-17797-17-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
 <1212802253-17797-10-git-send-email-tony@atomide.com>
 <1212802253-17797-11-git-send-email-tony@atomide.com>
 <1212802253-17797-12-git-send-email-tony@atomide.com>
 <1212802253-17797-13-git-send-email-tony@atomide.com>
 <1212802253-17797-14-git-send-email-tony@atomide.com>
 <1212802253-17797-15-git-send-email-tony@atomide.com>
 <1212802253-17797-16-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55542 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933682AbYFGBbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:31 -0400
In-Reply-To: <1212802253-17797-16-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, linux-pcmcia@lists.infradead.org, linux-mtd@lists.infradead.org

Change omap_cf.c and omap_nor.c to use omap_readw/writew instead of __REG.
This is needed for multi-omap in the future.

Cc: David Brownell <david-b@pacbell.net>
Cc: linux-pcmcia@lists.infradead.org
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Tony Lindren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index a66505f..82ec34c 100644
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
@@ -526,13 +530,16 @@ static void __init osk_mistral_init(void) { }
 
 static void __init osk_init(void)
 {
+	u32 l;
+
 	/* Workaround for wrong CS3 (NOR flash) timing
 	 * There are some U-Boot versions out there which configure
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
index 240b0e2..fb7ba78 100644
--- a/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -60,13 +60,22 @@ struct omapflash_info {
 static void omap_set_vpp(struct map_info *map, int enable)
 {
 	static int	count;
-
-	if (enable) {
-		if (count++ == 0)
-			OMAP_EMIFS_CONFIG_REG |= OMAP_EMIFS_CONFIG_WP;
-	} else {
-		if (count && (--count == 0))
-			OMAP_EMIFS_CONFIG_REG &= ~OMAP_EMIFS_CONFIG_WP;
+	u32 l;
+
+	if (cpu_class_is_omap1()) {
+		if (enable) {
+			if (count++ == 0) {
+				l = omap_readl(EMIFS_CONFIG);
+				l |= OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
+		} else {
+			if (count && (--count == 0)) {
+				l = omap_readl(EMIFS_CONFIG);
+				l &= ~OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
+		}
 	}
 }
 
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 46314b4..569b746 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -38,19 +38,19 @@
 #define	CF_BASE	0xfffe2800
 
 /* status; read after IRQ */
-#define CF_STATUS_REG		__REG16(CF_BASE + 0x00)
+#define CF_STATUS			(CF_BASE + 0x00)
 #	define	CF_STATUS_BAD_READ	(1 << 2)
 #	define	CF_STATUS_BAD_WRITE	(1 << 1)
 #	define	CF_STATUS_CARD_DETECT	(1 << 0)
 
 /* which chipselect (CS0..CS3) is used for CF (active low) */
-#define CF_CFG_REG		__REG16(CF_BASE + 0x02)
+#define CF_CFG				(CF_BASE + 0x02)
 
 /* card reset */
-#define CF_CONTROL_REG		__REG16(CF_BASE + 0x04)
+#define CF_CONTROL			(CF_BASE + 0x04)
 #	define	CF_CONTROL_RESET	(1 << 0)
 
-#define omap_cf_present() (!(CF_STATUS_REG & CF_STATUS_CARD_DETECT))
+#define omap_cf_present() (!(omap_readw(CF_STATUS) & CF_STATUS_CARD_DETECT))
 
 /*--------------------------------------------------------------------------*/
 
@@ -139,11 +139,11 @@ omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 		return -EINVAL;
 	}
 
-	control = CF_CONTROL_REG;
+	control = omap_readw(CF_CONTROL);
 	if (s->flags & SS_RESET)
-		CF_CONTROL_REG = CF_CONTROL_RESET;
+		omap_writew(CF_CONTROL_RESET, CF_CONTROL);
 	else
-		CF_CONTROL_REG = 0;
+		omap_writew(0, CF_CONTROL);
 
 	pr_debug("%s: Vcc %d, io_irq %d, flags %04x csc %04x\n",
 		driver_name, s->Vcc, s->io_irq, s->flags, s->csc_mask);
@@ -270,7 +270,7 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	omap_cfg_reg(V10_1610_CF_IREQ);
 	omap_cfg_reg(W10_1610_CF_RESET);
 
-	CF_CFG_REG = ~(1 << seg);
+	omap_writew(~(1 << seg), CF_CFG);
 
 	pr_info("%s: cs%d on irq %d\n", driver_name, seg, irq);
 
@@ -279,14 +279,15 @@ static int __init omap_cf_probe(struct platform_device *pdev)
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
 
 	pr_debug("%s: sts %04x cfg %04x control %04x %s\n", driver_name,
-		CF_STATUS_REG, CF_CFG_REG, CF_CONTROL_REG,
+		omap_readw(CF_STATUS), omap_readw(CF_CFG),
+		omap_readw(CF_CONTROL),
 		omap_cf_present() ? "present" : "(not present)");
 
 	cf->socket.owner = THIS_MODULE;
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
 
