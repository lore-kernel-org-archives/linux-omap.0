From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.20-rc5-omap] partial omap2430 fixes for musb_hdrc
Date: Thu, 18 Jan 2007 04:01:09 -0800
Message-ID: <20070118120109.E76D820F0DC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Partial build fixes for musb_hdrc on OMAP 2430; plus typedef and CaMeLcAsE
removal in the support for Mentor's DMA engine.

Also re-order the mach-omap2 Kconfig to restore the option hierachy that
was destroyed when the 2430SDP patch was merged into the wrong place.

Someone still needs to provide <asm/arch/hdrc_cnf.h> corresponding to
how the Mentor core is configured on that platform; add some register
and pin mux declarations; and create and register the platform_device.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: o26/arch/arm/mach-omap2/Kconfig
===================================================================
--- o26.orig/arch/arm/mach-omap2/Kconfig	2006-11-14 19:25:20.000000000 -0800
+++ o26/arch/arm/mach-omap2/Kconfig	2007-01-18 03:04:56.000000000 -0800
@@ -32,10 +32,6 @@ config MACH_OMAP_H4
 	select OMAP_DEBUG_DEVICES
 	select GPIOEXPANDER_OMAP
 
-config MACH_OMAP_2430SDP
-	bool "OMAP 2430 SDP board"
-	depends on ARCH_OMAP2 && ARCH_OMAP24XX
-
 config MACH_OMAP_H4_TUSB
 	bool "TUSB 6010 EVM board"
 	depends on MACH_OMAP_H4
@@ -73,3 +69,8 @@ config MACH_OMAP2_H4_USB1
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+
+config MACH_OMAP_2430SDP
+	bool "OMAP 2430 SDP board"
+	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+
Index: o26/drivers/usb/musb/Kconfig
===================================================================
--- o26.orig/drivers/usb/musb/Kconfig	2006-11-14 19:25:50.000000000 -0800
+++ o26/drivers/usb/musb/Kconfig	2007-01-18 02:51:28.000000000 -0800
@@ -29,7 +29,7 @@ config USB_MUSB_SOC
 	boolean
 	depends on USB_MUSB_HDRC
 	default y if ARCH_DAVINCI
-	default y if ARCH_OMAP243X
+	default y if ARCH_OMAP2430
 	default y if ARCH_OMAP343X
 	help
 	  Use a static <asm/arch/hdrc_cnf.h> file to describe how the
@@ -40,7 +40,7 @@ comment "DaVinci 644x USB support"
 	depends on USB_MUSB_HDRC && ARCH_DAVINCI
 
 comment "OMAP 243x high speed USB support"
-	depends on USB_MUSB_HDRC && ARCH_OMAP243X
+	depends on USB_MUSB_HDRC && ARCH_OMAP2430
 
 comment "OMAP 343x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP343X
@@ -145,7 +145,7 @@ config USB_INVENTRA_FIFO
 config USB_INVENTRA_DMA
 	bool
 	depends on USB_MUSB_HDRC && !USB_INVENTRA_FIFO
-	default ARCH_OMAP243X || ARCH_OMAP343X
+	default ARCH_OMAP2430 || ARCH_OMAP343X
 	help
 	  Enable DMA transfers using Mentor's engine.
 
Index: o26/drivers/usb/musb/Makefile
===================================================================
--- o26.orig/drivers/usb/musb/Makefile	2006-11-14 19:25:50.000000000 -0800
+++ o26/drivers/usb/musb/Makefile	2007-01-18 02:51:28.000000000 -0800
@@ -14,7 +14,7 @@ ifeq ($(CONFIG_USB_TUSB6010),y)
 	musb_hdrc-objs	+= tusb6010.o
 endif
 
-ifeq ($(CONFIG_ARCH_OMAP243X),y)
+ifeq ($(CONFIG_ARCH_OMAP2430),y)
 	musb_hdrc-objs	+= omap2430.o
 endif
 
Index: o26/drivers/usb/musb/omap2430.h
===================================================================
--- o26.orig/drivers/usb/musb/omap2430.h	2006-11-14 19:25:50.000000000 -0800
+++ o26/drivers/usb/musb/omap2430.h	2007-01-18 02:51:28.000000000 -0800
@@ -10,7 +10,7 @@
 #ifndef __MUSB_OMAP243X_H__
 #define __MUSB_OMAP243X_H__
 
-#ifdef CONFIG_ARCH_OMAP243X
+#ifdef CONFIG_ARCH_OMAP2430
 /*
  * OMAP2430-specific definitions
  */
Index: o26/drivers/usb/musb/musb_host.c
===================================================================
--- o26.orig/drivers/usb/musb/musb_host.c	2006-11-14 19:25:50.000000000 -0800
+++ o26/drivers/usb/musb/musb_host.c	2007-01-18 02:51:28.000000000 -0800
@@ -803,7 +803,11 @@ static void musb_ep_program(struct musb 
 				wLoadCount = 0;
 			} else {
 				pDmaController->channel_release(pDmaChannel);
-				pDmaChannel = pEnd->pDmaChannel = NULL;
+				if (is_out)
+					pEnd->tx_channel = NULL;
+				else
+					pEnd->rx_channel = NULL;
+				pDmaChannel = NULL;
 			}
 		}
 #endif
Index: o26/drivers/usb/musb/omap2430.c
===================================================================
--- o26.orig/drivers/usb/musb/omap2430.c	2007-01-17 22:59:06.000000000 -0800
+++ o26/drivers/usb/musb/omap2430.c	2007-01-18 02:51:28.000000000 -0800
@@ -65,11 +65,11 @@ int __init musb_platform_init(struct mus
 {
 	/* Erratum - reset value of STP has pull-down.
 	   Change it to pull-up. */
-	omap2_cfg_reg(AE5_2430_USB0HS_STP);
+	omap_cfg_reg(AE5_2430_USB0HS_STP);
 
 	/* start clock */
 	musb->clock = clk_get((struct device *)musb->controller, "usbhs_ick");
-	clk_use(musb->clock);
+	clk_enable(musb->clock);
 
 	omap_writel(omap_readl(OTG_INTERFSEL) | (1<<0), OTG_INTERFSEL);
 	omap_writel(omap_readl(OTG_SYSCONFIG) |
@@ -90,11 +90,7 @@ int __init musb_platform_init(struct mus
 int __exit musb_platform_exit(struct musb *musb)
 {
 	omap_vbus_power(musb, 0 /*off*/, 1);
-
-	/* REVISIT older omap trees need "unuse", more current
-	 * ones just have disable()
-	 */
-	clk_unuse(musb->clock);
+	clk_disable(musb->clock);
 
 	return 0;
 }
Index: o26/drivers/usb/musb/musbhsdma.c
===================================================================
--- o26.orig/drivers/usb/musb/musbhsdma.c	2006-11-14 19:25:50.000000000 -0800
+++ o26/drivers/usb/musb/musbhsdma.c	2007-01-18 03:04:25.000000000 -0800
@@ -32,9 +32,11 @@
  ******************************************************************/
 
 /*
- * DMA implementation for high-speed controllers.
+ * Interface to Mentor's DMA engine
  */
 
+#include <linux/platform_device.h>
+
 #include "musbdefs.h"
 
 
@@ -68,55 +70,50 @@
 
 /******************************* Types ********************************/
 
-struct _MGC_HsDmaController;
-
-typedef struct {
+struct hsdma_channel {
 	struct dma_channel Channel;
-	struct _MGC_HsDmaController *pController;
+	struct hsdma *pController;
 	u32 dwStartAddress;
 	u32 dwCount;
 	u8 bIndex;
 	u8 bEnd;
 	u8 bTransmit;
-} MGC_HsDmaChannel;
+};
 
 struct hsdma {
 	struct dma_controller Controller;
-	MGC_HsDmaChannel aChannel[MGC_HSDMA_CHANNELS];
+	struct hsdma_channel aChannel[MGC_HSDMA_CHANNELS];
 	void *pDmaPrivate;
 	void __iomem *pCoreBase;
 	u8 bChannelCount;
 	u8 bmUsedChannels;
 };
 
-/* FIXME remove typedef noise */
-typedef struct hsdma MGC_HsDmaController;
-
 /****************************** FUNCTIONS ********************************/
 
-static int MGC_HsDmaStartController(struct dma_controller *c)
+static int hsdma_start(struct dma_controller *c)
 {
 	/* nothing to do */
 	return 0;
 }
 
-static int MGC_HsDmaStopController(struct dma_controller *c)
+static int hsdma_stop(struct dma_controller *c)
 {
 	/* nothing to do */
 	return 0;
 }
 
-static struct dma_channel *MGC_HsDmaAllocateChannel(
-		struct dma_controller *c,
+static struct dma_channel *
+hsdma_channel_alloc(struct dma_controller *c,
 		struct musb_hw_ep *hw_ep,
 		u8 bTransmit)
 {
 	u8 bBit;
 	struct dma_channel *pChannel = NULL;
-	MGC_HsDmaChannel *pImplChannel = NULL;
-	MGC_HsDmaController *pController;
+	struct hsdma_channel *pImplChannel = NULL;
+	struct hsdma *pController;
 
-	pcontroller = container_of(c, struct hsdma, Controller);
+	pController = container_of(c, struct hsdma, Controller);
 	for (bBit = 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
 		if (!(pController->bmUsedChannels & (1 << bBit))) {
 			pController->bmUsedChannels |= (1 << bBit);
@@ -138,10 +135,9 @@ static struct dma_channel *MGC_HsDmaAllo
 	return pChannel;
 }
 
-static void MGC_HsDmaReleaseChannel(struct dma_channel *pChannel)
+static void hsdma_channel_release(struct dma_channel *pChannel)
 {
-	MGC_HsDmaChannel *pImplChannel =
-	    (MGC_HsDmaChannel *) pChannel->pPrivateData;
+	struct hsdma_channel *pImplChannel = pChannel->pPrivateData;
 
 	pImplChannel->pController->bmUsedChannels &=
 	    ~(1 << pImplChannel->bIndex);
@@ -150,9 +146,8 @@ static void MGC_HsDmaReleaseChannel(stru
 
 static void clear_state(struct dma_channel *pChannel)
 {
-	MGC_HsDmaChannel *pImplChannel =
-	    (MGC_HsDmaChannel *) pChannel->pPrivateData;
-	MGC_HsDmaController *pController = pImplChannel->pController;
+	struct hsdma_channel *pImplChannel = pChannel->pPrivateData;
+	struct hsdma *pController = pImplChannel->pController;
 	u8 *pBase = pController->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
 
@@ -175,9 +170,8 @@ static u8 configure_channel(struct dma_c
 				  u16 wPacketSize, u8 bMode,
 				  dma_addr_t dma_addr, u32 dwLength)
 {
-	MGC_HsDmaChannel *pImplChannel =
-	    (MGC_HsDmaChannel *) pChannel->pPrivateData;
-	MGC_HsDmaController *pController = pImplChannel->pController;
+	struct hsdma_channel *pImplChannel = pChannel->pPrivateData;
+	struct hsdma *pController = pImplChannel->pController;
 	u8 *pBase = pController->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
 	u16 wCsr = 0;
@@ -223,12 +217,11 @@ static u8 configure_channel(struct dma_c
 	return TRUE;
 }
 
-static int MGC_HsDmaProgramChannel(struct dma_channel * pChannel,
+static int hsdma_channel_program(struct dma_channel * pChannel,
 				  u16 wPacketSize, u8 bMode,
 				  dma_addr_t dma_addr, u32 dwLength)
 {
-	MGC_HsDmaChannel *pImplChannel =
-	    (MGC_HsDmaChannel *) pChannel->pPrivateData;
+	struct hsdma_channel *pImplChannel = pChannel->pPrivateData;
 
 	DBG(2, "pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 	       wPacketSize, dma_addr, dwLength, bMode);
@@ -267,7 +260,7 @@ static int MGC_HsDmaProgramChannel(struc
 }
 
 // REVISIT...
-static int MGC_HsDmaAbortChannel(struct dma_channel *pChannel)
+static int hsdma_channel_abort(struct dma_channel *pChannel)
 {
 	clear_state(pChannel);
 	pChannel->bStatus = MGC_DMA_STATUS_FREE;
@@ -279,8 +272,8 @@ static irqreturn_t hsdma_irq(int irq, vo
 	u8 bChannel;
 	u16 wCsr;
 	u32 dwAddress;
-	MGC_HsDmaChannel *pImplChannel;
-	MGC_HsDmaController *pController = pPrivateData;
+	struct hsdma_channel *pImplChannel;
+	struct hsdma *pController = pPrivateData;
 	u8 *pBase = pController->pCoreBase;
 	struct dma_channel *pChannel;
 	u8 bIntr = musb_readb(pBase, MGC_O_HSDMA_INTR);
@@ -291,8 +284,7 @@ static irqreturn_t hsdma_irq(int irq, vo
 	for (bChannel = 0; bChannel < MGC_HSDMA_CHANNELS; bChannel++) {
 		if (bIntr & (1 << bChannel)) {
 
-			pImplChannel = (MGC_HsDmaChannel *)
-					&(pController->aChannel[bChannel]);
+			pImplChannel = &pController->aChannel[bChannel];
 			pChannel = &pImplChannel->Channel;
 
 			wCsr = musb_readw(pBase,
@@ -356,7 +348,7 @@ static irqreturn_t hsdma_irq(int irq, vo
 
 static void hsdma_controller_destroy(struct dma_controller *pController)
 {
-	MGC_HsDmaController *pHsController = pController->pPrivateData;
+	struct hsdma *pHsController = pController->pPrivateData;
 
 	if (pHsController) {
 		pHsController->Controller.pPrivateData = NULL;
@@ -367,7 +359,7 @@ static void hsdma_controller_destroy(str
 static struct dma_controller *
 hsdma_controller_new(struct musb *pThis, void __iomem *pCoreBase)
 {
-	MGC_HsDmaController *pController;
+	struct hsdma *pController;
 	struct device *dev = pThis->controller;
 	struct platform_device *pdev = to_platform_device(dev);
 	int irq = platform_get_irq(pdev, 1);
@@ -377,7 +369,7 @@ hsdma_controller_new(struct musb *pThis,
 		return NULL;
 	}
 
-	if (!(pController = kzalloc(sizeof(MGC_HsDmaController), GFP_KERNEL)))
+	if (!(pController = kzalloc(sizeof *pController, GFP_KERNEL)))
 		return NULL;
 
 	pController->bChannelCount = MGC_HSDMA_CHANNELS;
@@ -385,12 +377,12 @@ hsdma_controller_new(struct musb *pThis,
 	pController->pCoreBase = pCoreBase;
 
 	pController->Controller.pPrivateData = pController;
-	pController->Controller.start = MGC_HsDmaStartController;
-	pController->Controller.stop = MGC_HsDmaStopController;
-	pController->Controller.channel_alloc = MGC_HsDmaAllocateChannel;
-	pController->Controller.channel_release = MGC_HsDmaReleaseChannel;
-	pController->Controller.channel_program = MGC_HsDmaProgramChannel;
-	pController->Controller.channel_abort = MGC_HsDmaAbortChannel;
+	pController->Controller.start = hsdma_start;
+	pController->Controller.stop = hsdma_stop;
+	pController->Controller.channel_alloc = hsdma_channel_alloc;
+	pController->Controller.channel_release = hsdma_channel_release;
+	pController->Controller.channel_program = hsdma_channel_program;
+	pController->Controller.channel_abort = hsdma_channel_abort;
 
 	if (request_irq(irq, hsdma_irq, SA_INTERRUPT,
 			pThis->controller->bus_id, &pController->Controller)) {
