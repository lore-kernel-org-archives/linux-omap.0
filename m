From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 IRQ: add some missing IRQs for secure peripherals
Date: Tue, 16 Sep 2008 02:27:35 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809160226410.21341@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45399 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbYIPI1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 04:27:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Add in some missing IRQs for secure peripherals, defined in
OMAP34xx Multimedia High Security Device Silicon Revision 3.0 Security
Addendum Version B (SWPU119B)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/mach/irqs.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index e51e5e6..18cb99c 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -299,7 +299,9 @@
 
 #define INT_34XX_ST_MCBSP2_IRQ	4
 #define INT_34XX_ST_MCBSP3_IRQ	5
+#define INT_34XX_SSM_ABORT_IRQ	6
 #define INT_34XX_SYS_NIRQ	7
+#define INT_34XX_D2D_FW_IRQ	8
 #define INT_34XX_PRCM_MPU_IRQ	11
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
@@ -316,11 +318,17 @@
 #define INT_34XX_USIM_IRQ	35
 #define INT_34XX_WDT3_IRQ	36
 #define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_SHA1MD52_IRQ	49
+#define INT_34XX_FPKA_READY_IRQ	50
+#define INT_34XX_SHA1MD51_IRQ	51
+#define INT_34XX_RNG_IRQ	52
 #define INT_34XX_I2C3_IRQ	61
+#define INT_34XX_FPKA_ERROR_IRQ	64
 #define INT_34XX_PBIAS_IRQ	75
 #define INT_34XX_OHCI_IRQ	76
 #define INT_34XX_EHCI_IRQ	77
 #define INT_34XX_TLL_IRQ	78
+#define INT_34XX_PARTHASH_IRQ	79
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95
 
