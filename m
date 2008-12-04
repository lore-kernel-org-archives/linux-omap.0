From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH] [OMAPZOOM]  OMAP : DMA: Spurious interrupt fix
Date: Thu, 4 Dec 2008 11:51:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB029392DE99@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44881 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbYLDGVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 01:21:39 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB46LWXs032640
	for <linux-omap@vger.kernel.org>; Thu, 4 Dec 2008 00:21:38 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mB46LUWE015672
	for <linux-omap@vger.kernel.org>; Thu, 4 Dec 2008 11:51:31 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This fixes the spurious interrupt issue on a DMA channel. 

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked By: Nishant Kamat <nskamat@ti.com>
Acked By: Gopinath Thara <thara@ti.com>
---
--- omapkernel.orig/arch/arm/plat-omap/include/mach/dma.h	2008-12-04 10:29:08.949018434 +0530
+++ omapkernel/arch/arm/plat-omap/include/mach/dma.h	2008-12-04 11:14:25.359087775 +0530
@@ -67,7 +67,11 @@
 #define OMAP_DMA4_CAPS_4		0x74
 
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
+#ifdef CONFIG_OMAP_DMA_LIBRARY_CHANNELS
+#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	CONFIG_OMAP_DMA_LIBRARY_CHANNELS
+#else
 #define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
+#endif
 
 /* Common channel specific registers for omap1 */
 #define OMAP1_DMA_CH_BASE(n)		(0x40 * (n) + 0x00)
Index: omapkernel/arch/arm/plat-omap/Kconfig
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/Kconfig	2008-12-04 10:29:08.949018434 +0530
+++ omapkernel/arch/arm/plat-omap/Kconfig	2008-12-04 10:38:21.883850512 +0530
@@ -256,6 +256,18 @@ config OMAP_SERIAL_WAKE
 	  to data on the serial RX line. This allows you to wake the
 	  system from serial console.
 
+
+config OMAP_DMA_LIBRARY_CHANNELS
+        int "DMA channels controlled by the kernel DMA library"
+        range 24 32
+        depends on ARCH_OMAP3
+        default "32"
+        help
+          Some of the OMAP System DMA channels may need to be
+          reserved for software that don't use the DMA library, such as
+          security drivers. Use this option to limit the number of channels
+          controlled by the kernel DMA library.
+
 endmenu
 
 endif
Index: omapkernel/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- omapkernel.orig/arch/arm/configs/omap_3430sdp_defconfig	2008-12-04 10:29:08.949018434 +0530
+++ omapkernel/arch/arm/configs/omap_3430sdp_defconfig	2008-12-04 10:38:21.884850481 +0530
@@ -177,7 +177,7 @@ CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 # CONFIG_ARCH_OMAP2 is not set
 CONFIG_ARCH_OMAP3=y
-
+CONFIG_OMAP_DMA_LIBRARY_CHANNELS=24
 #
 # OMAP Feature Selections
 #
Index: omapkernel/arch/arm/plat-omap/dma.c
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/dma.c	2008-12-04 10:38:16.732010840 +0530
+++ omapkernel/arch/arm/plat-omap/dma.c	2008-12-04 11:11:07.671274902 +0530
@@ -1946,7 +1946,7 @@ static int omap2_dma_handle_ch(int ch)
 /* STATUS register count is from 1-32 while our is 0-31 */
 static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 {
-	u32 val;
+	u32 val, enable_reg;
 	int i;
 
 	val = dma_read(IRQSTATUS_L0);
@@ -1955,6 +1955,8 @@ static irqreturn_t omap2_dma_irq_handler
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
+	enable_reg = dma_read(IRQENABLE_L0);
+	val &= enable_reg; /* Dispatch only relevant interrupts */
 	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
 			omap2_dma_handle_ch(i);
Index: omapkernel/arch/arm/configs/omap_ldp_defconfig
===================================================================
--- omapkernel.orig/arch/arm/configs/omap_ldp_defconfig	2008-12-04 11:18:54.000000000 +0530
+++ omapkernel/arch/arm/configs/omap_ldp_defconfig	2008-12-04 11:19:33.507466484 +0530
@@ -177,6 +177,7 @@ CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 # CONFIG_ARCH_OMAP2 is not set
 CONFIG_ARCH_OMAP3=y
+CONFIG_OMAP_DMA_LIBRARY_CHANNELS=32
 #
 # OMAP Feature Selections
 #

