From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: MUSB HOST support on 2430SDP
Date: Mon, 21 May 2007 12:58:57 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08002FF6A9A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Fix Mentor controller DMA for OMAP2430/3430

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>

---
 musb_gadget.c |   24 +++
 musb_host.c   |   39 ------
 musbdefs.h    |    3
 musbhsdma.c   |  377 +++++++++++++++---------------
 omap2430.c    |  124 ++++++++++++++-----
 omap2430.h    |   42 +++++-
 6 files changed, 363 insertions(+), 246 deletions(-)
---
diff -purN -X ./dontdiff a/drivers/usb/musb/musbdefs.h
b/drivers/usb/musb/musbdefs.h
--- a/drivers/usb/musb/musbdefs.h	2007-05-21 12:32:53.000000000
+0530
+++ b/drivers/usb/musb/musbdefs.h	2007-05-21 11:37:51.000000000
+0530
@@ -206,7 +206,8 @@ enum musb_g_ep0_state {
  * directly with the "flat" model, or after setting up an index
register.
  */
=20
-#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430)
+#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430) || \
+				     defined(CONFIG_ARCH_OMAP3430)
 /* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
  */
diff -purN -X ./dontdiff a/drivers/usb/musb/musb_gadget.c
b/drivers/usb/musb/musb_gadget.c
--- a/drivers/usb/musb/musb_gadget.c	2007-05-21 12:32:53.000000000
+0530
+++ b/drivers/usb/musb/musb_gadget.c	2007-05-21 11:37:51.000000000
+0530
@@ -159,12 +159,24 @@ __acquires(ep->musb->Lock)
 static void nuke(struct musb_ep *ep, const int status)
 {
 	struct musb_request	*req =3D NULL;
+	void __iomem *epio =3D ep->pThis->aLocalEnd[ep->bEndNumber].regs;
=20
 	ep->busy =3D 1;
=20
 	if (is_dma_capable() && ep->dma) {
 		struct dma_controller	*c =3D ep->pThis->pDmaController;
 		int value;
+		if (ep->is_in) {
+			musb_writew(epio, MGC_O_HDRC_TXCSR,
+					0 | MGC_M_TXCSR_FLUSHFIFO);
+			musb_writew(epio, MGC_O_HDRC_TXCSR,
+					0 | MGC_M_TXCSR_FLUSHFIFO);
+		} else {
+			musb_writew(epio, MGC_O_HDRC_RXCSR,
+					0 | MGC_M_RXCSR_FLUSHFIFO);
+			musb_writew(epio, MGC_O_HDRC_RXCSR,
+					0 | MGC_M_RXCSR_FLUSHFIFO);
+		}
=20
 		value =3D c->channel_abort(ep->dma);
 		DBG(value ? 1 : 6, "%s: abort DMA --> %d\n", ep->name,
value);
@@ -454,12 +466,12 @@ void musb_g_tx(struct musb *musb, u8 bEn
 				musb_writew(epio, MGC_O_HDRC_TXCSR,
wCsrVal);
 				/* ensure writebuffer is empty */
 				wCsrVal =3D musb_readw(epio,
MGC_O_HDRC_TXCSR);
+				pRequest->actual +=3D
pEnd->dma->dwActualLength;
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
 					bEnd, wCsrVal,
 					pEnd->dma->dwActualLength,
 					pRequest);
-				pRequest->actual +=3D
pEnd->dma->dwActualLength;
 			}
=20
 			if (is_dma || pRequest->actual =3D=3D
pRequest->length) {
@@ -475,8 +487,9 @@ void musb_g_tx(struct musb *musb, u8 bEn
 							=3D=3D 0)
 #ifdef CONFIG_USB_INVENTRA_DMA
 					|| (is_dma &&
-						(pRequest->actual
-							<
pEnd->wPacketSize))
+						((!dma->bDesiredMode) ||

+						    (pRequest->actual &=20
+						    (pEnd->wPacketSize -
1))))
 #endif
 				) {
 					/* on dma completion, fifo may
not
@@ -489,6 +502,7 @@ void musb_g_tx(struct musb *musb, u8 bEn
 					musb_writew(epio,
MGC_O_HDRC_TXCSR,
 							MGC_M_TXCSR_MODE
 							|
MGC_M_TXCSR_TXPKTRDY);
+					pRequest->zero =3D 0;
 				}
=20
 				/* ... or if not, then complete it */
@@ -1143,6 +1157,8 @@ static int musb_gadget_queue(struct usb_
=20
 	if (!ep || !req)
 		return -EINVAL;
+	if (!req->buf)
+		return -ENODATA;
=20
 	pEnd =3D to_musb_ep(ep);
 	musb =3D pEnd->pThis;
@@ -1275,6 +1291,8 @@ int musb_gadget_set_halt(struct usb_ep *
 	struct musb_request	*pRequest =3D NULL;
 	int			status =3D 0;
=20
+	if (!ep)
+		return -EINVAL;
 	pBase =3D musb->pRegs;
=20
 	spin_lock_irqsave(&musb->Lock, flags);
diff -purN -X ./dontdiff a/drivers/usb/musb/musb_host.c
b/drivers/usb/musb/musb_host.c
--- a/drivers/usb/musb/musb_host.c	2007-05-21 12:32:53.000000000
+0530
+++ b/drivers/usb/musb/musb_host.c	2007-05-21 11:37:51.000000000
+0530
@@ -435,21 +435,6 @@ musb_advance_schedule(struct musb *pThis
 		qh =3D pEnd->out_qh;
 	qh =3D musb_giveback(qh, urb, 0);
=20
-#ifdef CONFIG_USB_INVENTRA_DMA
-	/* REVISIT udelay reportedly works around issues in unmodified
-	 * Mentor RTL before v1.5, where it doesn't disable the pull-up
-	 * resisters in high speed mode.  That causes signal reflection
-	 * and errors because inter packet IDLE time vanishes.
-	 *
-	 * Yes, this delay makes DMA-OUT a bit slower than PIO.  But
-	 * without it, some devices are unusable.  But there seem to be
-	 * other issues too, at least on DaVinci; the delay improves
-	 * some full speed cases, and being DMA-coupled is strange...
-	 */
-	if (is_dma_capable() && !is_in && pEnd->tx_channel)
-		udelay(15);	/* 10 usec ~=3D 1x 512byte packet */
-#endif
-
 	if (qh && qh->is_ready && !list_empty(&qh->hep->urb_list)) {
 		DBG(4, "... next ep%d %cX urb %p\n",
 				pEnd->bLocalEnd, is_in ? 'R' : 'T',
@@ -498,6 +483,9 @@ static u8 musb_host_packet_rx(struct mus
=20
 	// MGC_SelectEnd(pBase, bEnd);
 	wRxCount =3D musb_readw(epio, MGC_O_HDRC_RXCOUNT);
+	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", bEnd, wRxCount,
+			pUrb->transfer_buffer, qh->offset,
+			pUrb->transfer_buffer_length);
=20
 	/* unload FIFO */
 	if (usb_pipeisoc(nPipe)) {
@@ -1271,20 +1259,6 @@ void musb_host_tx(struct musb *pThis, u8
=20
 	/* REVISIT this looks wrong... */
 	if (!status || dma || usb_pipeisoc(nPipe)) {
-
-#ifdef CONFIG_USB_INVENTRA_DMA
-		/* mode 0 or last short packet)
-		 * REVISIT how about ZLP?
-		 */
-		if ((dma->bDesiredMode =3D=3D 0)
-				|| (dma->dwActualLength
-					& (qh->maxpacket - 1))) {
-			/* Send out the packet first ... */
-			MGC_SelectEnd(pBase, bEnd);
-			musb_writew(epio, MGC_O_HDRC_TXCSR,
-					MGC_M_TXCSR_TXPKTRDY);
-		}
-#endif
 		if (dma)
 			wLength =3D dma->dwActualLength;
 		else
@@ -1542,11 +1516,9 @@ void musb_host_rx(struct musb *pThis, u8
 		musb_writew(pEnd->regs, MGC_O_HDRC_RXCSR, wVal);
=20
 #ifdef CONFIG_USB_INVENTRA_DMA
-		pUrb->actual_length +=3D xfer_len;
-		qh->offset +=3D xfer_len;
-
 		/* bDone if pUrb buffer is full or short packet is recd
*/
-		bDone =3D (pUrb->actual_length >=3D
pUrb->transfer_buffer_length)
+		bDone =3D ((pUrb->actual_length + xfer_len) >=3D
+				pUrb->transfer_buffer_length)
 			|| (dma->dwActualLength & (qh->maxpacket - 1));
=20
 		/* send IN token for next packet, without AUTOREQ */
@@ -1969,6 +1941,7 @@ static int musb_cleanup_urb(struct urb *
 			| MGC_M_TXCSR_H_RXSTALL
 			| MGC_M_TXCSR_H_NAKTIMEOUT
 			| MGC_M_TXCSR_H_ERROR
+			| MGC_M_TXCSR_TXPKTRDY
 			);
 		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 		/* REVISIT may need to clear FLUSHFIFO ... */
diff -purN -X ./dontdiff a/drivers/usb/musb/musbhsdma.c
b/drivers/usb/musb/musbhsdma.c
--- a/drivers/usb/musb/musbhsdma.c	2007-05-21 12:32:53.000000000
+0530
+++ b/drivers/usb/musb/musbhsdma.c	2007-05-21 11:37:51.000000000
+0530
@@ -1,6 +1,6 @@
 /******************************************************************
  * Copyright 2005 Mentor Graphics Corporation
- * Copyright (C) 2005-2006 by Texas Instruments
+ * Copyright (C) 2005-2007 by Texas Instruments
  *
  * This file is part of the Inventra Controller Driver for Linux.
  *
@@ -32,88 +32,108 @@
  ******************************************************************/
=20
 /*
- * Interface to Mentor's DMA engine
+ * Implementation for the DMA controller within the MUSBMHDRC.
  */
=20
+#include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
-
 #include "musbdefs.h"
=20
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#include "omap2430.h"
+#endif
=20
-/****************************** CONSTANTS
********************************/
-
-#define MGC_O_HSDMA_BASE    0x200
-#define MGC_O_HSDMA_INTR    0x200
-
-#define MGC_O_HSDMA_CONTROL 4
-#define MGC_O_HSDMA_ADDRESS 8
-#define MGC_O_HSDMA_COUNT   0xc
+#define MGC_O_HSDMA_BASE		0x200
+#define MGC_O_HSDMA_INTR		(MGC_O_HSDMA_BASE + 0)
+#define MGC_O_HSDMA_CONTROL		0x4
+#define MGC_O_HSDMA_ADDRESS		0x8
+#define MGC_O_HSDMA_COUNT		0xc
=20
 #define MGC_HSDMA_CHANNEL_OFFSET(_bChannel, _bOffset)		\
 		(MGC_O_HSDMA_BASE + (_bChannel << 4) + _bOffset)
=20
 /* control register (16-bit): */
-#define MGC_S_HSDMA_ENABLE	0
-#define MGC_S_HSDMA_TRANSMIT	1
-#define MGC_S_HSDMA_MODE1	2
-#define MGC_S_HSDMA_IRQENABLE	3
-#define MGC_S_HSDMA_ENDPOINT	4
-#define MGC_S_HSDMA_BUSERROR	8
-#define MGC_S_HSDMA_BURSTMODE	9
-#define MGC_M_HSDMA_BURSTMODE	(3 << MGC_S_HSDMA_BURSTMODE)
-#define MGC_HSDMA_BURSTMODE_UNSPEC  0
-#define MGC_HSDMA_BURSTMODE_INCR4   1
-#define MGC_HSDMA_BURSTMODE_INCR8   2
-#define MGC_HSDMA_BURSTMODE_INCR16  3
-
-#define MGC_HSDMA_CHANNELS 8
-
-/******************************* Types
********************************/
-
-struct hsdma_channel {
-	struct dma_channel Channel;
-	struct hsdma *pController;
-	u32 dwStartAddress;
-	u32 dwCount;
-	u8 bIndex;
-	u8 bEnd;
-	u8 bTransmit;
+#define MGC_S_HSDMA_ENABLE		0
+#define MGC_S_HSDMA_TRANSMIT		1
+#define MGC_S_HSDMA_MODE1		2
+#define MGC_S_HSDMA_IRQENABLE		3
+#define MGC_S_HSDMA_ENDPOINT		4
+#define MGC_S_HSDMA_BUSERROR		8
+#define MGC_S_HSDMA_BURSTMODE		9
+#define MGC_M_HSDMA_BURSTMODE		(3 << MGC_S_HSDMA_BURSTMODE)
+#define MGC_HSDMA_BURSTMODE_UNSPEC	0
+#define MGC_HSDMA_BURSTMODE_INCR4	1
+#define MGC_HSDMA_BURSTMODE_INCR8	2
+#define MGC_HSDMA_BURSTMODE_INCR16	3
+
+#define MGC_HSDMA_CHANNELS		8
+
+struct musb_dma_controller;
+
+struct musb_dma_channel {
+	struct dma_channel		Channel;
+	struct musb_dma_controller	*pController;
+	u32				dwStartAddress;
+	u32				dwCount;
+	u16				wMaxPacketSize;
+	u8				bIndex;
+	u8				bEnd;
+	u8				bTransmit;
 };
=20
-struct hsdma {
-	struct dma_controller Controller;
-	struct hsdma_channel aChannel[MGC_HSDMA_CHANNELS];
-	void *pDmaPrivate;
-	void __iomem *pCoreBase;
-	u8 bChannelCount;
-	u8 bmUsedChannels;
+struct musb_dma_controller {
+	struct dma_controller		Controller;
+	struct musb_dma_channel		aChannel[MGC_HSDMA_CHANNELS];
+	void 				*pDmaPrivate;
+	void __iomem 			*pCoreBase;
+	u8 				bChannelCount;
+	u8 				bmUsedChannels;
+	u8				irq;
 };
=20
-/****************************** FUNCTIONS
********************************/
-
-static int hsdma_start(struct dma_controller *c)
+static int dma_controller_start(struct dma_controller *c)
 {
 	/* nothing to do */
 	return 0;
 }
=20
-static int hsdma_stop(struct dma_controller *c)
+static void dma_channel_release(struct dma_channel *pChannel);
+
+static int dma_controller_stop(struct dma_controller *c)
 {
-	/* nothing to do */
+	struct musb_dma_controller *pController =3D
+		container_of(c, struct musb_dma_controller, Controller);
+	struct musb *pThis =3D (struct musb *) pController->pDmaPrivate;
+	struct dma_channel *pChannel;
+	u8 bBit;
+
+	if (pController->bmUsedChannels !=3D 0) {
+		dev_err(pThis->controller,
+			"Stopping DMA controller while channel
active\n");
+
+		for (bBit =3D 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
+			if (pController->bmUsedChannels & (1 << bBit)) {
+				pChannel =3D
&(pController->aChannel[bBit].Channel);
+				dma_channel_release(pChannel);
+
+				if (!pController->bmUsedChannels)
+					break;
+			}
+		}
+	}
 	return 0;
 }
=20
-static struct dma_channel *
-hsdma_channel_alloc(struct dma_controller *c,
-		struct musb_hw_ep *hw_ep,
-		u8 bTransmit)
+static struct dma_channel* dma_channel_allocate(struct dma_controller
*c,
+				struct musb_hw_ep *hw_ep, u8 bTransmit)
 {
 	u8 bBit;
 	struct dma_channel *pChannel =3D NULL;
-	struct hsdma_channel *pImplChannel =3D NULL;
-	struct hsdma *pController;
+	struct musb_dma_channel *pImplChannel =3D NULL;
+	struct musb_dma_controller *pController =3D
+			container_of(c, struct musb_dma_controller,
Controller);
=20
-	pController =3D container_of(c, struct hsdma, Controller);
 	for (bBit =3D 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
 		if (!(pController->bmUsedChannels & (1 << bBit))) {
 			pController->bmUsedChannels |=3D (1 << bBit);
@@ -135,48 +155,33 @@ hsdma_channel_alloc(struct dma_controlle
 	return pChannel;
 }
=20
-static void hsdma_channel_release(struct dma_channel *pChannel)
+static void dma_channel_release(struct dma_channel *pChannel)
 {
-	struct hsdma_channel *pImplChannel =3D pChannel->pPrivateData;
+	struct musb_dma_channel *pImplChannel =3D
+		(struct musb_dma_channel *) pChannel->pPrivateData;
=20
-	pImplChannel->pController->bmUsedChannels &=3D
-	    ~(1 << pImplChannel->bIndex);
-	pChannel->bStatus =3D MGC_DMA_STATUS_FREE;
-}
-
-static void clear_state(struct dma_channel *pChannel)
-{
-	struct hsdma_channel *pImplChannel =3D pChannel->pPrivateData;
-	struct hsdma *pController =3D pImplChannel->pController;
-	u8 *pBase =3D pController->pCoreBase;
-	u8 bChannel =3D pImplChannel->bIndex;
-
-	musb_writew(pBase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_CONTROL),
-		    0);
-	musb_writel(pBase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_ADDRESS),
-		    0);
-	musb_writel(pBase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_COUNT),
-		    0);
-
-	pChannel->dwActualLength =3D 0L;
+	pChannel->dwActualLength =3D 0;
 	pImplChannel->dwStartAddress =3D 0;
 	pImplChannel->dwCount =3D 0;
+
+	pImplChannel->pController->bmUsedChannels &=3D
+		~(1 << pImplChannel->bIndex);
+
+	pChannel->bStatus =3D MGC_DMA_STATUS_UNKNOWN;
 }
=20
-static u8 configure_channel(struct dma_channel *pChannel,
-				  u16 wPacketSize, u8 bMode,
-				  dma_addr_t dma_addr, u32 dwLength)
+static void configure_channel(struct dma_channel *pChannel,
+				u16 wPacketSize, u8 bMode,
+				dma_addr_t dma_addr, u32 dwLength)
 {
-	struct hsdma_channel *pImplChannel =3D pChannel->pPrivateData;
-	struct hsdma *pController =3D pImplChannel->pController;
+	struct musb_dma_channel *pImplChannel =3D
+		(struct musb_dma_channel *) pChannel->pPrivateData;
+	struct musb_dma_controller *pController =3D
pImplChannel->pController;
 	u8 *pBase =3D pController->pCoreBase;
 	u8 bChannel =3D pImplChannel->bIndex;
 	u16 wCsr =3D 0;
=20
-	DBG(2, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
+	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
 	    pChannel, wPacketSize, dma_addr, dwLength, bMode);
=20
 	if (bMode) {
@@ -213,45 +218,32 @@ static u8 configure_channel(struct dma_c
 	musb_writew(pBase,
 		    MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_CONTROL),
 		    wCsr);
-
-	return TRUE;
 }
=20
-static int hsdma_channel_program(struct dma_channel * pChannel,
-				  u16 wPacketSize, u8 bMode,
-				  dma_addr_t dma_addr, u32 dwLength)
-{
-	struct hsdma_channel *pImplChannel =3D pChannel->pPrivateData;
-
-	DBG(2, "pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
-	       wPacketSize, dma_addr, dwLength, bMode);
+static int dma_channel_program(struct dma_channel * pChannel,
+				u16 wPacketSize, u8 bMode,
+				dma_addr_t dma_addr, u32 dwLength)
+{
+	struct musb_dma_channel *pImplChannel =3D
+			(struct musb_dma_channel *)
pChannel->pPrivateData;
+
+	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
+		pImplChannel->bEnd,
+		pImplChannel->bTransmit ? "Tx" : "Rx",
+		wPacketSize, dma_addr, dwLength, bMode);
=20
-	BUG_ON(pChannel->bStatus !=3D MGC_DMA_STATUS_FREE);
+	BUG_ON(pChannel->bStatus =3D=3D MGC_DMA_STATUS_UNKNOWN ||
+		pChannel->bStatus =3D=3D MGC_DMA_STATUS_BUSY);
=20
-	pChannel->dwActualLength =3D 0L;
+	pChannel->dwActualLength =3D 0;
 	pImplChannel->dwStartAddress =3D dma_addr;
 	pImplChannel->dwCount =3D dwLength;
-
+	pImplChannel->wMaxPacketSize =3D wPacketSize;
 	pChannel->bStatus =3D MGC_DMA_STATUS_BUSY;
=20
 	if ((bMode =3D=3D 1) && (dwLength >=3D wPacketSize)) {
-
-#if 0
-		/* mode 1 sends an extra IN token at the end of
-		 * full packet transfer in host Rx
-		 */
-		if (dwLength % wPacketSize =3D=3D 0)
-			dwLength -=3D wPacketSize;
-
-		/* mode 1 doesn't give an interrupt on short packet */
-		configure_channel(pChannel, wPacketSize, 1, dma_addr,
-				  dwLength & ~(wPacketSize - 1));
-		/* the rest (<=3D pkt_size) will be transferred in mode 0
*/
-#endif
-
 		configure_channel(pChannel, wPacketSize, 1, dma_addr,
 				  dwLength);
-
 	} else
 		configure_channel(pChannel, wPacketSize, 0, dma_addr,
 				  dwLength);
@@ -259,32 +251,70 @@ static int hsdma_channel_program(struct=20
 	return TRUE;
 }
=20
-// REVISIT...
-static int hsdma_channel_abort(struct dma_channel *pChannel)
+static int dma_channel_abort(struct dma_channel *pChannel)
 {
-	clear_state(pChannel);
-	pChannel->bStatus =3D MGC_DMA_STATUS_FREE;
+	struct musb_dma_channel *pImplChannel =3D
+		(struct musb_dma_channel *) pChannel->pPrivateData;
+	u8 bChannel =3D pImplChannel->bIndex;
+	u8 *pBase =3D pImplChannel->pController->pCoreBase;
+	u16 csr;
+
+	if (pChannel->bStatus =3D=3D MGC_DMA_STATUS_BUSY) {
+		if (pImplChannel->bTransmit) {
+
+			csr =3D musb_readw(pBase,=20
+
MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_TXCSR));
+			csr &=3D ~(MGC_M_TXCSR_AUTOSET |
+				 MGC_M_TXCSR_DMAENAB |
+				 MGC_M_TXCSR_DMAMODE);
+			musb_writew(pBase,=20
+
MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_TXCSR),=20
+					csr);
+		}
+		else {
+			csr =3D musb_readw(pBase,=20
+
MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_RXCSR));
+			csr &=3D ~(MGC_M_RXCSR_AUTOCLEAR |
+				 MGC_M_RXCSR_DMAENAB |
+				 MGC_M_RXCSR_DMAMODE);
+			musb_writew(pBase,=20
+
MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_RXCSR),=20
+					csr);
+		}
+
+		musb_writew(pBase,
+		   MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_CONTROL), 0);
+		musb_writel(pBase,
+		   MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_ADDRESS), 0);
+		musb_writel(pBase,
+		   MGC_HSDMA_CHANNEL_OFFSET(bChannel,
MGC_O_HSDMA_COUNT), 0);
+
+		pChannel->bStatus =3D MGC_DMA_STATUS_FREE;
+	}
 	return 0;
 }
=20
-static irqreturn_t hsdma_irq(int irq, void *pPrivateData)
+static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 {
+	struct musb_dma_controller *pController =3D
+		(struct musb_dma_controller *)pPrivateData;
+	struct musb_dma_channel *pImplChannel;
+	u8 *pBase =3D pController->pCoreBase;
+	struct dma_channel *pChannel;
 	u8 bChannel;
 	u16 wCsr;
 	u32 dwAddress;
-	struct hsdma_channel *pImplChannel;
-	struct hsdma *pController =3D pPrivateData;
-	u8 *pBase =3D pController->pCoreBase;
-	struct dma_channel *pChannel;
-	u8 bIntr =3D musb_readb(pBase, MGC_O_HSDMA_INTR);
+	u8 bIntr;
+	irqreturn_t retval =3D IRQ_NONE;
=20
+	bIntr =3D musb_readb(pBase, MGC_O_HSDMA_INTR);
 	if (!bIntr)
-		return IRQ_NONE;
+		goto done;
=20
 	for (bChannel =3D 0; bChannel < MGC_HSDMA_CHANNELS; bChannel++) {
 		if (bIntr & (1 << bChannel)) {
-
-			pImplChannel =3D &pController->aChannel[bChannel];
+			pImplChannel =3D (struct musb_dma_channel *)
+
&(pController->aChannel[bChannel]);
 			pChannel =3D &pImplChannel->Channel;
=20
 			wCsr =3D musb_readw(pBase,
@@ -296,8 +326,8 @@ static irqreturn_t hsdma_irq(int irq, vo
 				    MGC_DMA_STATUS_BUS_ABORT;
 			} else {
 				dwAddress =3D musb_readl(pBase,
-
MGC_HSDMA_CHANNEL_OFFSET
-						       (bChannel,
+
MGC_HSDMA_CHANNEL_OFFSET(
+							bChannel,
=20
MGC_O_HSDMA_ADDRESS));
 				pChannel->dwActualLength =3D
 				    dwAddress -
pImplChannel->dwStartAddress;
@@ -309,55 +339,57 @@ static irqreturn_t hsdma_irq(int irq, vo
 				    (pChannel->dwActualLength <
 					pImplChannel->dwCount) ?
 					"=3D> reconfig 0": "=3D> complete");
-#if 0
-				if (pChannel->dwActualLength <
-				    pImplChannel->dwCount) {
-					/* mode 1 sends an extra IN
request if
-					the last packet is a complete
packet */
-					u16 newcsr =3D
MGC_ReadCsr16(pBase,
-
MGC_O_HDRC_RXCSR,
-
pImplChannel->bEnd);
-					newcsr &=3D
~(MGC_M_RXCSR_H_AUTOREQ |
-
MGC_M_RXCSR_H_REQPKT);
-					MGC_WriteCsr16(pBase,
MGC_O_HDRC_RXCSR,
-
pImplChannel->bEnd,
-
MGC_M_RXCSR_H_WZC_BITS |
-								newcsr);
-
-					configure_channel(pChannel,
-
pImplChannel->wMaxPacketSize,
-						0, dwAddress,
-						pImplChannel->dwCount -
-
pChannel->dwActualLength);
-				}
-				else
-#endif
-				{
-					pChannel->bStatus =3D
MGC_DMA_STATUS_FREE;
-					/* completed */
+
+				u8 devctl =3D musb_readb(pBase,
+						MGC_O_HDRC_DEVCTL);
+
+				pChannel->bStatus =3D MGC_DMA_STATUS_FREE;
+
+				/* completed */
+				if ((devctl & MGC_M_DEVCTL_HM)
+				    && (pImplChannel->bTransmit)
+				    && ((pChannel->bDesiredMode =3D=3D 0)
+					|| (pChannel->dwActualLength &
+
(pImplChannel->wMaxPacketSize - 1)))
+				   ) {
+					/* Send out the packet */
+					MGC_SelectEnd(pBase,
+						pImplChannel->bEnd);
+					musb_writew(pBase,=20
+
MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_TXCSR),=20
+						MGC_M_TXCSR_TXPKTRDY);
+				} else
 					musb_dma_completion(
=20
pController->pDmaPrivate,
 						pImplChannel->bEnd,
=20
pImplChannel->bTransmit);
-				}
 			}
 		}
 	}
-	return IRQ_HANDLED;
+	retval =3D IRQ_HANDLED;
+done:
+	return retval;
 }
=20
-void dma_controller_destroy(struct dma_controller *pController)
+void dma_controller_destroy(struct dma_controller *c)
 {
-	struct hsdma *pHsController =3D pController->pPrivateData;
+	struct musb_dma_controller *pController =3D
+		(struct musb_dma_controller *) c->pPrivateData;
=20
-	pHsController->Controller.pPrivateData =3D NULL;
-	kfree(pHsController);
+	if (!pController)
+		return;
+
+	if (pController->irq)
+		free_irq(pController->irq, c);
+
+	kfree(pController);
+	c->pPrivateData =3D NULL;
 }
=20
 struct dma_controller *__init
 dma_controller_create(struct musb *pThis, void __iomem *pCoreBase)
 {
-	struct hsdma *pController;
+	struct musb_dma_controller *pController;
 	struct device *dev =3D pThis->controller;
 	struct platform_device *pdev =3D to_platform_device(dev);
 	int irq =3D platform_get_irq(pdev, 1);
@@ -367,7 +399,8 @@ dma_controller_create(struct musb *pThis
 		return NULL;
 	}
=20
-	if (!(pController =3D kzalloc(sizeof *pController, GFP_KERNEL)))
+	if (!(pController =3D kzalloc(sizeof(struct musb_dma_controller),
+				GFP_KERNEL)))
 		return NULL;
=20
 	pController->bChannelCount =3D MGC_HSDMA_CHANNELS;
@@ -375,19 +408,21 @@ dma_controller_create(struct musb *pThis
 	pController->pCoreBase =3D pCoreBase;
=20
 	pController->Controller.pPrivateData =3D pController;
-	pController->Controller.start =3D hsdma_start;
-	pController->Controller.stop =3D hsdma_stop;
-	pController->Controller.channel_alloc =3D hsdma_channel_alloc;
-	pController->Controller.channel_release =3D hsdma_channel_release;
-	pController->Controller.channel_program =3D hsdma_channel_program;
-	pController->Controller.channel_abort =3D hsdma_channel_abort;
+	pController->Controller.start =3D dma_controller_start;
+	pController->Controller.stop =3D dma_controller_stop;
+	pController->Controller.channel_alloc =3D dma_channel_allocate;
+	pController->Controller.channel_release =3D dma_channel_release;
+	pController->Controller.channel_program =3D dma_channel_program;
+	pController->Controller.channel_abort =3D dma_channel_abort;
=20
-	if (request_irq(irq, hsdma_irq, IRQF_DISABLED,
+	if (request_irq(irq, dma_controller_irq, IRQF_DISABLED,
 			pThis->controller->bus_id,
&pController->Controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
-		kfree(pController);
+		dma_controller_destroy(&pController->Controller);
 		return NULL;
 	}
=20
+	pController->irq =3D irq;
+
 	return &pController->Controller;
 }
diff -purN -X ./dontdiff a/drivers/usb/musb/omap2430.c
b/drivers/usb/musb/omap2430.c
--- a/drivers/usb/musb/omap2430.c	2007-05-21 12:32:53.000000000
+0530
+++ b/drivers/usb/musb/omap2430.c	2007-05-21 11:37:51.000000000
+0530
@@ -36,68 +36,134 @@
 #include "musbdefs.h"
 #include "omap2430.h"
=20
+#ifdef CONFIG_ARCH_OMAP3430
+#define	get_cpu_rev()	2
+#endif
=20
-static int dma_off;
=20
 void musb_platform_enable(struct musb *musb)
 {
-	if (is_dma_capable() && dma_off)
-		printk(KERN_WARNING "%s %s: dma not reactivated\n",
-				__FILE__, __FUNCTION__);
-	else
-		dma_off =3D 1;
 }
-
 void musb_platform_disable(struct musb *musb)
 {
-	if (is_dma_capable()) {
-		printk(KERN_WARNING "%s %s: dma still active\n",
-				__FILE__, __FUNCTION__);
-		dma_off =3D 1;
-	}
 }
-
 static void omap_vbus_power(struct musb *musb, int is_on, int sleeping)
 {
 }
=20
 static void omap_set_vbus(struct musb *musb, int is_on)
 {
-	WARN_ON(is_on && is_peripheral_active(musb));
-	return omap_vbus_power(musb, is_on, 0);
+	u8		devctl;
+	/* HDRC controls CPEN, but beware current surges during device
+	 * connect.  They can trigger transient overcurrent conditions
+	 * that must be ignored.
+	 */
+
+	devctl =3D musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+
+	if (is_on) {
+		musb->is_active =3D 1;
+		musb->xceiv.default_a =3D 1;
+		musb->xceiv.state =3D OTG_STATE_A_WAIT_VRISE;
+		devctl |=3D MGC_M_DEVCTL_SESSION;
+
+		MUSB_HST_MODE(musb);
+	} else {
+		musb->is_active =3D 0;
+
+		/* NOTE:  we're skipping A_WAIT_VFALL -> A_IDLE and
+		 * jumping right to B_IDLE...
+		 */
+
+		musb->xceiv.default_a =3D 0;
+		musb->xceiv.state =3D OTG_STATE_B_IDLE;
+		devctl &=3D ~MGC_M_DEVCTL_SESSION;
+
+		MUSB_DEV_MODE(musb);
+	}
+	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, devctl);
+
+	DBG(1, "VBUS %s, devctl %02x "
+		/* otg %3x conf %08x prcm %08x */ "\n",
+		otg_state_string(musb),
+		musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL));
+}
+static int omap_set_power(struct otg_transceiver *x, unsigned mA)
+{
+	return 0;
 }
=20
+int musb_platform_resume(struct musb *musb);
+
 int __init musb_platform_init(struct musb *musb)
 {
-	/* Erratum - reset value of STP has pull-down.
-	   Change it to pull-up. */
+#if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
-
-	/* start clock */
+	/* get the clock */
 	musb->clock =3D clk_get((struct device *)musb->controller,
"usbhs_ick");
-	clk_enable(musb->clock);
+#else
+	musb->clock =3D clk_get((struct device *)musb->controller,
"hsusb_ick");
+#endif
+	if(IS_ERR(musb->clock))
+        	return PTR_ERR(musb->clock);
+
+	musb_platform_resume(musb);
=20
-	omap_writel(omap_readl(OTG_INTERFSEL) | (1<<0), OTG_INTERFSEL);
-	omap_writel(omap_readl(OTG_SYSCONFIG) |
-		    ((1 << 12) | (1 << 3) | (1 << 2)),
-		    OTG_SYSCONFIG);
+	OTG_INTERFSEL_REG |=3D ULPI_12PIN;
=20
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable
0x%x\n",
-			omap_readl(OTG_REVISION),
omap_readl(OTG_SYSCONFIG),
-			omap_readl(OTG_SYSSTATUS),
omap_readl(OTG_INTERFSEL),
-			omap_readl(OTG_SIMENABLE));
+			OTG_REVISION_REG, OTG_SYSCONFIG_REG,
OTG_SYSSTATUS_REG,
+			OTG_INTERFSEL_REG, OTG_SIMENABLE_REG);
=20
-	musb->board_set_vbus =3D omap_set_vbus;
 	omap_vbus_power(musb, musb->board_mode =3D=3D MUSB_HOST, 1);
=20
+
+	if (is_host_enabled(musb))
+		musb->board_set_vbus =3D omap_set_vbus;
+	if (is_peripheral_enabled(musb))
+		musb->xceiv.set_power =3D omap_set_power;
+
 	return 0;
 }
=20
+int musb_platform_suspend(struct musb *musb)
+{
+	/* in any role */
+	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
+	OTG_SYSCONFIG_REG &=3D FORCESTDBY;	/* enable force standby
*/
+	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
+	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
+	OTG_FORCESTDBY_REG |=3D ENABLEFORCE; /* enable MSTANDBY */
+	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
+
+	clk_disable(musb->clock);
+	return 0;
+}
+
+int musb_platform_resume(struct musb *musb)
+{
+	clk_enable(musb->clock);
+
+	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
+	OTG_SYSCONFIG_REG |=3D SMARTSTDBY;	/* enable smart standby
*/
+	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
+	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
+	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
+
+	return 0;
+}
+
+
 int musb_platform_exit(struct musb *musb)
 {
+
 	omap_vbus_power(musb, 0 /*off*/, 1);
-	clk_disable(musb->clock);
+
+	musb_platform_suspend(musb);
+
+	clk_put(musb->clock);
+	musb->clock =3D 0;
=20
 	return 0;
 }
diff -purN -X ./dontdiff a/drivers/usb/musb/omap2430.h
b/drivers/usb/musb/omap2430.h
--- a/drivers/usb/musb/omap2430.h	2007-05-21 12:32:53.000000000
+0530
+++ b/drivers/usb/musb/omap2430.h	2007-05-21 11:37:51.000000000
+0530
@@ -10,21 +10,45 @@
 #ifndef __MUSB_OMAP243X_H__
 #define __MUSB_OMAP243X_H__
=20
-#ifdef CONFIG_ARCH_OMAP2430
-
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#include <asm/arch/hardware.h>
 #include <asm/arch/usb.h>
-
 /*
  * OMAP2430-specific definitions
  */
=20
 #define MENTOR_BASE_OFFSET	0
-#define HS_OTG(offset)		(OMAP243X_HS_BASE + (offset))
-#define OTG_REVISION		HS_OTG(0x400)
-#define OTG_SYSCONFIG		HS_OTG(0x404)
-#define OTG_SYSSTATUS		HS_OTG(0x408)
-#define OTG_INTERFSEL		HS_OTG(0x40c)
-#define OTG_SIMENABLE		HS_OTG(0x410)
+#if	defined(CONFIG_ARCH_OMAP2430)
+#define	OMAP_HSOTG_BASE		(OMAP243X_HS_BASE)
+#elif	defined(CONFIG_ARCH_OMAP3430)
+#define	OMAP_HSOTG_BASE		(HS_BASE)
+#endif
+#define OMAP_HSOTG(offset)	__REG32(OMAP_HSOTG_BASE + 0x400 +
(offset))
+#define OTG_REVISION_REG	OMAP_HSOTG(0x0)
+#define OTG_SYSCONFIG_REG	OMAP_HSOTG(0x4)
+#	define	MIDLEMODE	12	/* bit position */
+#	define	FORCESTDBY		(0 << MIDLEMODE)
+#	define	NOSTDBY			(1 << MIDLEMODE)
+#	define	SMARTSTDBY		(2 << MIDLEMODE)
+#	define	SIDLEMODE		3	/* bit position */
+#	define	FORCEIDLE		(0 << SIDLEMODE)
+#	define	NOIDLE			(1 << SIDLEMODE)
+#	define	SMARTIDLE		(2 << SIDLEMODE)
+#	define	ENABLEWAKEUP		(1 << 2)
+#	define	SOFTRST			(1 << 1)
+#	define	AUTOIDLE		(1 << 0)
+#define OTG_SYSSTATUS_REG	OMAP_HSOTG(0x8)
+#	define	RESETDONE		(1 << 0)
+#define OTG_INTERFSEL_REG	OMAP_HSOTG(0xc)
+#	define	EXTCP			(1 << 2)
+#	define	PHYSEL		0	/* bit position */
+#	define	UTMI_8BIT		(0 << PHYSEL)
+#	define	ULPI_12PIN		(1 << PHYSEL)
+#	define	ULPI_8PIN		(2 << PHYSEL)
+#define OTG_SIMENABLE_REG     	OMAP_HSOTG(0x10)
+#	define	TM1			(1 << 0)
+#define OTG_FORCESTDBY_REG	OMAP_HSOTG(0x14)
+#	define	ENABLEFORCE		(1 << 0)
=20
 #endif	/* CONFIG_ARCH_OMAP2430 */
