From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH 5/5] am3505/3517: Various platform defines for UART4
Date: Mon, 04 Jul 2011 15:36:01 -0400
Message-ID: <4E121621.10702@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:41729 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1GDTgC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 15:36:02 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Qdow5-0001OM-6I
	for linux-omap@vger.kernel.org; Mon, 04 Jul 2011 15:36:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add missing definitions for the AM3505/3517 UART4 such
as DMAs, INTs and base address.

Signed-of-by: Raphael Assenat

diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index d1c916f..dc562a5 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -195,6 +195,11 @@
 
 #define OMAP36XX_DMA_UART4_TX		81	/* S_DMA_80 */
 #define OMAP36XX_DMA_UART4_RX		82	/* S_DMA_81 */
+
+/* Only for AM35xx */
+#define AM35XX_DMA_UART4_TX		54
+#define AM35XX_DMA_UART4_RX		55
+
 /*----------------------------------------------------------------------------*/
 
 #define OMAP1_DMA_TOUT_IRQ		(1 << 0)
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 8ba86aa..8919a8d 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -357,6 +357,7 @@
 #define INT_35XX_EMAC_C0_TX_PULSE_IRQ	69
 #define INT_35XX_EMAC_C0_MISC_PULSE_IRQ	70
 #define INT_35XX_USBOTG_IRQ		71
+#define INT_35XX_UART4			84
 #define INT_35XX_CCDC_VD0_IRQ		88
 #define INT_35XX_CCDC_VD1_IRQ		92
 #define INT_35XX_CCDC_VD2_IRQ		93
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 2723f91..de3b10c 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -56,6 +56,9 @@
 #define TI816X_UART2_BASE	0x48022000
 #define TI816X_UART3_BASE	0x48024000
 
+/* AM3505/3517 UART4 */
+#define AM35XX_UART4_BASE	0x4809E000	/* Only on AM3505/3517 */
+
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
