From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/21] ARM: OMAP: Clean up interrupt lines to fix warnings for multi-omap
Date: Fri,  6 Jun 2008 18:30:46 -0700
Message-ID: <1212802253-17797-15-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53403 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639AbYFGBb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:26 -0400
In-Reply-To: <1212802253-17797-14-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

If boards with different NR_IRQS are compiled together, tons of
compiler warnings are emitted about redefining NR_IRQS.

This patch fixes the problem by adding up NR_IRQS in a common place.

Patch also removes quite a bit of now unnecessary code.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 30e1881..0cf62ef 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -32,7 +32,7 @@
 
 static void fpga_mask_irq(unsigned int irq)
 {
-	irq -= OMAP1510_IH_FPGA_BASE;
+	irq -= OMAP_FPGA_IRQ_BASE;
 
 	if (irq < 8)
 		__raw_writeb((__raw_readb(OMAP1510_FPGA_IMR_LO)
@@ -65,7 +65,7 @@ static void fpga_ack_irq(unsigned int irq)
 
 static void fpga_unmask_irq(unsigned int irq)
 {
-	irq -= OMAP1510_IH_FPGA_BASE;
+	irq -= OMAP_FPGA_IRQ_BASE;
 
 	if (irq < 8)
 		__raw_writeb((__raw_readb(OMAP1510_FPGA_IMR_LO) | (1 << irq)),
@@ -95,8 +95,8 @@ void innovator_fpga_IRQ_demux(unsigned int irq, struct irq_desc *desc)
 	if (!stat)
 		return;
 
-	for (fpga_irq = OMAP1510_IH_FPGA_BASE;
-	     (fpga_irq < (OMAP1510_IH_FPGA_BASE + NR_FPGA_IRQS)) && stat;
+	for (fpga_irq = OMAP_FPGA_IRQ_BASE;
+	     (fpga_irq < OMAP_FPGA_IRQ_END) && stat;
 	     fpga_irq++, stat >>= 1) {
 		if (stat & 1) {
 			d = irq_desc + fpga_irq;
@@ -151,7 +151,7 @@ void omap1510_fpga_init_irq(void)
 	__raw_writeb(0, OMAP1510_FPGA_IMR_HI);
 	__raw_writeb(0, INNOVATOR_FPGA_IMR2);
 
-	for (i = OMAP1510_IH_FPGA_BASE; i < (OMAP1510_IH_FPGA_BASE + NR_FPGA_IRQS); i++) {
+	for (i = OMAP_FPGA_IRQ_BASE; i < OMAP_FPGA_IRQ_END; i++) {
 
 		if (i == OMAP1510_INT_FPGA_TS) {
 			/*
diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
index e9c65ce..c7db900 100644
--- a/include/asm-arm/arch-omap/board-2430sdp.h
+++ b/include/asm-arm/arch-omap/board-2430sdp.h
@@ -36,9 +36,4 @@
 
 #define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
 
-/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
-#define IH_TWL4030_BASE			IH_BOARD_BASE
-#define IH_TWL4030_END			(IH_TWL4030_BASE+8)
-#define NR_IRQS				(IH_TWL4030_END)
-
 #endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff --git a/include/asm-arm/arch-omap/board-h3.h b/include/asm-arm/arch-omap/board-h3.h
index 0f64044..c5d0f32 100644
--- a/include/asm-arm/arch-omap/board-h3.h
+++ b/include/asm-arm/arch-omap/board-h3.h
@@ -30,12 +30,6 @@
 /* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
 #define OMAP1710_ETHR_START		0x04000300
 
-#define MAXIRQNUM			(IH_BOARD_BASE)
-#define MAXFIQNUM			MAXIRQNUM
-#define MAXSWINUM			MAXIRQNUM
-
-#define NR_IRQS				(MAXIRQNUM + 1)
-
 extern void h3_mmc_init(void);
 extern void h3_mmc_slot_cover_handler(void *arg, int state);
 
diff --git a/include/asm-arm/arch-omap/board-innovator.h b/include/asm-arm/arch-omap/board-innovator.h
index 56d2c98..9ca03de 100644
--- a/include/asm-arm/arch-omap/board-innovator.h
+++ b/include/asm-arm/arch-omap/board-innovator.h
@@ -36,9 +36,6 @@
 #define OMAP1510P1_EMIFS_PRI_VALUE		0x00
 #define OMAP1510P1_EMIFF_PRI_VALUE		0x00
 
-#define NR_FPGA_IRQS		24
-#define NR_IRQS                 (IH_BOARD_BASE + NR_FPGA_IRQS)
-
 #ifndef __ASSEMBLY__
 void fpga_write(unsigned char val, int reg);
 unsigned char fpga_read(int reg);
diff --git a/include/asm-arm/arch-omap/board-perseus2.h b/include/asm-arm/arch-omap/board-perseus2.h
index eb74420..d7429cb 100644
--- a/include/asm-arm/arch-omap/board-perseus2.h
+++ b/include/asm-arm/arch-omap/board-perseus2.h
@@ -36,10 +36,4 @@
 #define OMAP_SDRAM_DEVICE		D256M_1X16_4B
 #endif
 
-#define MAXIRQNUM		IH_BOARD_BASE
-#define MAXFIQNUM		MAXIRQNUM
-#define MAXSWINUM		MAXIRQNUM
-
-#define NR_IRQS			(MAXIRQNUM + 1)
-
 #endif
diff --git a/include/asm-arm/arch-omap/fpga.h b/include/asm-arm/arch-omap/fpga.h
index 6a883e0..f420881 100644
--- a/include/asm-arm/arch-omap/fpga.h
+++ b/include/asm-arm/arch-omap/fpga.h
@@ -169,30 +169,29 @@ struct h2p2_dbg_fpga {
 #define OMAP1510_INT_FPGA		(IH_GPIO_BASE + 13)
 
 /* IRQ Numbers for interrupts muxed through the FPGA */
-#define OMAP1510_IH_FPGA_BASE		IH_BOARD_BASE
-#define OMAP1510_INT_FPGA_ATN		(OMAP1510_IH_FPGA_BASE + 0)
-#define OMAP1510_INT_FPGA_ACK		(OMAP1510_IH_FPGA_BASE + 1)
-#define OMAP1510_INT_FPGA2		(OMAP1510_IH_FPGA_BASE + 2)
-#define OMAP1510_INT_FPGA3		(OMAP1510_IH_FPGA_BASE + 3)
-#define OMAP1510_INT_FPGA4		(OMAP1510_IH_FPGA_BASE + 4)
-#define OMAP1510_INT_FPGA5		(OMAP1510_IH_FPGA_BASE + 5)
-#define OMAP1510_INT_FPGA6		(OMAP1510_IH_FPGA_BASE + 6)
-#define OMAP1510_INT_FPGA7		(OMAP1510_IH_FPGA_BASE + 7)
-#define OMAP1510_INT_FPGA8		(OMAP1510_IH_FPGA_BASE + 8)
-#define OMAP1510_INT_FPGA9		(OMAP1510_IH_FPGA_BASE + 9)
-#define OMAP1510_INT_FPGA10		(OMAP1510_IH_FPGA_BASE + 10)
-#define OMAP1510_INT_FPGA11		(OMAP1510_IH_FPGA_BASE + 11)
-#define OMAP1510_INT_FPGA12		(OMAP1510_IH_FPGA_BASE + 12)
-#define OMAP1510_INT_ETHER		(OMAP1510_IH_FPGA_BASE + 13)
-#define OMAP1510_INT_FPGAUART1		(OMAP1510_IH_FPGA_BASE + 14)
-#define OMAP1510_INT_FPGAUART2		(OMAP1510_IH_FPGA_BASE + 15)
-#define OMAP1510_INT_FPGA_TS		(OMAP1510_IH_FPGA_BASE + 16)
-#define OMAP1510_INT_FPGA17		(OMAP1510_IH_FPGA_BASE + 17)
-#define OMAP1510_INT_FPGA_CAM		(OMAP1510_IH_FPGA_BASE + 18)
-#define OMAP1510_INT_FPGA_RTC_A		(OMAP1510_IH_FPGA_BASE + 19)
-#define OMAP1510_INT_FPGA_RTC_B		(OMAP1510_IH_FPGA_BASE + 20)
-#define OMAP1510_INT_FPGA_CD		(OMAP1510_IH_FPGA_BASE + 21)
-#define OMAP1510_INT_FPGA22		(OMAP1510_IH_FPGA_BASE + 22)
-#define OMAP1510_INT_FPGA23		(OMAP1510_IH_FPGA_BASE + 23)
+#define OMAP1510_INT_FPGA_ATN		(OMAP_FPGA_IRQ_BASE + 0)
+#define OMAP1510_INT_FPGA_ACK		(OMAP_FPGA_IRQ_BASE + 1)
+#define OMAP1510_INT_FPGA2		(OMAP_FPGA_IRQ_BASE + 2)
+#define OMAP1510_INT_FPGA3		(OMAP_FPGA_IRQ_BASE + 3)
+#define OMAP1510_INT_FPGA4		(OMAP_FPGA_IRQ_BASE + 4)
+#define OMAP1510_INT_FPGA5		(OMAP_FPGA_IRQ_BASE + 5)
+#define OMAP1510_INT_FPGA6		(OMAP_FPGA_IRQ_BASE + 6)
+#define OMAP1510_INT_FPGA7		(OMAP_FPGA_IRQ_BASE + 7)
+#define OMAP1510_INT_FPGA8		(OMAP_FPGA_IRQ_BASE + 8)
+#define OMAP1510_INT_FPGA9		(OMAP_FPGA_IRQ_BASE + 9)
+#define OMAP1510_INT_FPGA10		(OMAP_FPGA_IRQ_BASE + 10)
+#define OMAP1510_INT_FPGA11		(OMAP_FPGA_IRQ_BASE + 11)
+#define OMAP1510_INT_FPGA12		(OMAP_FPGA_IRQ_BASE + 12)
+#define OMAP1510_INT_ETHER		(OMAP_FPGA_IRQ_BASE + 13)
+#define OMAP1510_INT_FPGAUART1		(OMAP_FPGA_IRQ_BASE + 14)
+#define OMAP1510_INT_FPGAUART2		(OMAP_FPGA_IRQ_BASE + 15)
+#define OMAP1510_INT_FPGA_TS		(OMAP_FPGA_IRQ_BASE + 16)
+#define OMAP1510_INT_FPGA17		(OMAP_FPGA_IRQ_BASE + 17)
+#define OMAP1510_INT_FPGA_CAM		(OMAP_FPGA_IRQ_BASE + 18)
+#define OMAP1510_INT_FPGA_RTC_A		(OMAP_FPGA_IRQ_BASE + 19)
+#define OMAP1510_INT_FPGA_RTC_B		(OMAP_FPGA_IRQ_BASE + 20)
+#define OMAP1510_INT_FPGA_CD		(OMAP_FPGA_IRQ_BASE + 21)
+#define OMAP1510_INT_FPGA22		(OMAP_FPGA_IRQ_BASE + 22)
+#define OMAP1510_INT_FPGA23		(OMAP_FPGA_IRQ_BASE + 23)
 
 #endif
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index 8797365..7464c69 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -285,7 +285,41 @@
 #define OMAP_MAX_GPIO_LINES	192
 #define IH_GPIO_BASE		(128 + IH2_BASE)
 #define IH_MPUIO_BASE		(OMAP_MAX_GPIO_LINES + IH_GPIO_BASE)
-#define IH_BOARD_BASE		(16 + IH_MPUIO_BASE)
+#define OMAP_IRQ_END		(IH_MPUIO_BASE + 16)
+
+/* External FPGA handles interrupts on Innovator boards */
+#define	OMAP_FPGA_IRQ_BASE	(OMAP_IRQ_END)
+#ifdef	CONFIG_MACH_OMAP_INNOVATOR
+#define OMAP_FPGA_NR_IRQS	24
+#else
+#define OMAP_FPGA_NR_IRQS	0
+#endif
+#define OMAP_FPGA_IRQ_END	(OMAP_FPGA_IRQ_BASE + OMAP_FPGA_NR_IRQS)
+
+/* External TWL4030 can handle interrupts on 2430 and 34xx boards */
+#define	TWL4030_IRQ_BASE	(OMAP_FPGA_IRQ_END)
+#ifdef	CONFIG_TWL4030_CORE
+#define	TWL4030_BASE_NR_IRQS	8
+#define	TWL4030_PWR_NR_IRQS	8
+#else
+#define	TWL4030_BASE_NR_IRQS	0
+#define	TWL4030_PWR_NR_IRQS	0
+#endif
+#define TWL4030_IRQ_END		(TWL4030_IRQ_BASE + TWL4030_BASE_NR_IRQS)
+#define TWL4030_PWR_IRQ_BASE	TWL4030_IRQ_END
+#define	TWL4030_PWR_IRQ_END	(TWL4030_PWR_IRQ_BASE + TWL4030_PWR_NR_IRQS)
+
+/* External TWL4030 gpio interrupts are optional */
+#define TWL4030_GPIO_IRQ_BASE	TWL4030_PWR_IRQ_END
+#ifdef	CONFIG_TWL4030_GPIO
+#define TWL4030_GPIO_NR_IRQS	18
+#else
+#define	TWL4030_GPIO_NR_IRQS	0
+#endif
+#define TWL4030_GPIO_IRQ_END	(TWL4030_GPIO_IRQ_BASE + TWL4030_GPIO_NR_IRQS)
+
+/* Total number of interrupts depends on the enabled blocks above */
+#define NR_IRQS			TWL4030_GPIO_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
@@ -293,14 +327,6 @@
 extern void omap_init_irq(void);
 #endif
 
-/*
- * The definition of NR_IRQS is in board-specific header file, which is
- * included via hardware.h
- */
 #include <asm/hardware.h>
 
-#ifndef NR_IRQS
-#define NR_IRQS                 IH_BOARD_BASE
-#endif
-
 #endif
