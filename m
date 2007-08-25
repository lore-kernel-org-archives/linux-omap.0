From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc3-omap-git 1/2] musb_hdrc cleanup -- comments, dates
Date: Sat, 25 Aug 2007 14:41:49 -0700
Message-ID: <200708251441.49493.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Clarify dates in comments ... they are from 2006.  Drop reference
to the Mentor "2.2a" code base; it's not remotely relevant any more.

Also fix up a few comments, and remove a few "sparse" warnings,
mostly on DaVinci.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/musb/cppi_dma.c        |    8 ++++----
 drivers/usb/musb/cppi_dma.h        |   16 +++-------------
 drivers/usb/musb/davinci.c         |   27 ++++++++++++++-------------
 drivers/usb/musb/davinci.h         |    2 +-
 drivers/usb/musb/musb_core.c       |    2 +-
 drivers/usb/musb/musb_gadget.c     |   22 ++++++++++------------
 drivers/usb/musb/musb_gadget_ep0.c |    4 +---
 drivers/usb/musb/musb_host.c       |    6 +-----
 drivers/usb/musb/musb_host.h       |    3 +--
 drivers/usb/musb/musb_io.h         |    2 +-
 drivers/usb/musb/musb_procfs.c     |   13 ++++---------
 drivers/usb/musb/musb_virthub.c    |    2 +-
 drivers/usb/musb/musbhsdma.c       |    7 +------
 13 files changed, 43 insertions(+), 71 deletions(-)

--- o26.orig/drivers/usb/musb/cppi_dma.c	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/cppi_dma.c	2007-08-25 11:53:18.000000000 -0700
@@ -3,7 +3,7 @@
  *
  * This file implements a DMA  interface using TI's CPPI DMA.
  * For now it's DaVinci-only, but CPPI isn't specific to DaVinci or USB.
- * TUSB 6010 over VLYNQ has CPPI that looks much like DaVinci.
+ * The TUSB6020, using VLYNQ, has CPPI that looks much like DaVinci.
  */
 
 #include <linux/usb.h>
@@ -12,14 +12,14 @@
 #include "cppi_dma.h"
 
 
-/* CPPI DMA status 7-mar:
+/* CPPI DMA status 7-mar-2006:
  *
  * - See musb_{host,gadget}.c for more info
  *
  * - Correct RX DMA generally forces the engine into irq-per-packet mode,
  *   which can easily saturate the CPU under non-mass-storage loads.
  *
- * NOTES 24-aug (2.6.18-rc4):
+ * NOTES 24-aug-2006 (2.6.18-rc4):
  *
  * - peripheral RXDMA wedged in a test with packets of length 512/512/1.
  *   evidently after the 1 byte packet was received and acked, the queue
@@ -539,7 +539,7 @@ static inline int cppi_autoreq_update(st
  * ========
  * TX is a lot more reasonable than RX; it doesn't need to run in
  * irq-per-packet mode very often.  RNDIS mode seems to behave too
- * (other how it handles the exactly-N-packets case).  Building a
+ * (except how it handles the exactly-N-packets case).  Building a
  * txdma queue with multiple requests (urb or usb_request) looks
  * like it would work ... but fault handling would need much testing.
  *
--- o26.orig/drivers/usb/musb/musb_core.c	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/musb_core.c	2007-08-25 11:53:18.000000000 -0700
@@ -135,7 +135,7 @@ const char *otg_state_string(struct musb
 #define DRIVER_AUTHOR "Mentor Graphics, Texas Instruments, Nokia"
 #define DRIVER_DESC "Inventra Dual-Role USB Controller Driver"
 
-#define MUSB_VERSION_BASE "2.2a/db-0.5.2"
+#define MUSB_VERSION_BASE "6.0"
 
 #ifndef MUSB_VERSION_SUFFIX
 #define MUSB_VERSION_SUFFIX	""
--- o26.orig/drivers/usb/musb/musb_gadget.c	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/musb_gadget.c	2007-08-25 11:53:18.000000000 -0700
@@ -46,7 +46,7 @@
 #include "musb_core.h"
 
 
-/* MUSB PERIPHERAL status 3-mar:
+/* MUSB PERIPHERAL status 3-mar-2006:
  *
  * - EP0 seems solid.  It passes both USBCV and usbtest control cases.
  *   Minor glitches:
@@ -88,9 +88,7 @@
  *     + TUSB 6010, platform-specific dma in the works
  */
 
-/**************************************************************************
-Handling completion
-**************************************************************************/
+/* ----------------------------------------------------------------------- */
 
 /*
  * Immediately complete a request.
@@ -192,9 +190,9 @@ static void nuke(struct musb_ep *ep, con
 	}
 }
 
-/**************************************************************************
- * TX/IN and RX/OUT Data transfers
- **************************************************************************/
+/* ----------------------------------------------------------------------- */
+
+/* Data transfers - pure PIO, pure DMA, or mixed mode */
 
 /*
  * This assumes the separate CPPI engine is responding to DMA requests
@@ -1377,7 +1375,7 @@ static const struct usb_ep_ops musb_ep_o
 	.fifo_flush	= musb_gadget_fifo_flush
 };
 
-/***********************************************************************/
+/* ----------------------------------------------------------------------- */
 
 static int musb_gadget_get_frame(struct usb_gadget *gadget)
 {
@@ -1532,9 +1530,9 @@ static const struct usb_gadget_ops musb_
 	.pullup			= musb_gadget_pullup,
 };
 
-/****************************************************************
- * Registration operations
- ****************************************************************/
+/* ----------------------------------------------------------------------- */
+
+/* Registration */
 
 /* Only this registration code "knows" the rule (from USB standards)
  * about there being only one external upstream port.  It assumes
@@ -1869,7 +1867,7 @@ int usb_gadget_unregister_driver(struct 
 EXPORT_SYMBOL(usb_gadget_unregister_driver);
 
 
-/***********************************************************************/
+/* ----------------------------------------------------------------------- */
 
 /* lifecycle operations called through plat_uds.c */
 
--- o26.orig/drivers/usb/musb/musb_host.c	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/musb_host.c	2007-08-25 11:53:18.000000000 -0700
@@ -72,7 +72,7 @@
  *
  * - Not tested with HNP, but some SRP paths seem to behave.
  *
- * NOTE 24-August:
+ * NOTE 24-August-2006:
  *
  * - Bulk traffic finally uses both sides of hardware ep1, freeing up an
  *   extra endpoint for periodic use enabling hub + keybd + mouse.  That
@@ -101,8 +101,6 @@
  */
 
 
-/*************************** Forwards ***************************/
-
 static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, unsigned int nOut,
 			u8 * buf, u32 len);
@@ -685,8 +683,6 @@ static void musb_ep_program(struct musb 
 
 		/* general endpoint setup */
 		if (epnum) {
-			u16	csr = csr;
-
 			/* ASSERT:  TXCSR_DMAENAB was already cleared */
 
 			/* flush all old state, set default */
--- o26.orig/drivers/usb/musb/cppi_dma.h	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/cppi_dma.h	2007-08-25 11:53:18.000000000 -0700
@@ -48,19 +48,14 @@ struct cppi_descriptor {
 
 struct cppi;
 
-/**
- *  Channel Control Structure
- *
- * CPPI  Channel Control structure. Using he same for Tx/Rx. If need be
- * derive out of this later.
- */
+/* CPPI  Channel Control structure */
 struct cppi_channel {
 	/* First field must be dma_channel for easy type casting
 	 * FIXME just use container_of() and be typesafe instead!
 	 */
 	struct dma_channel Channel;
 
-	/* back pointer to the Dma Controller structure */
+	/* back pointer to the DMA Controller structure */
 	struct cppi		*controller;
 
 	/* which direction of which endpoint? */
@@ -92,12 +87,7 @@ struct cppi_channel {
 	struct list_head	tx_complete;
 };
 
-/**
- *  CPPI Dma Controller Object
- *
- *  CPPI Dma controller object.Encapsulates all bookeeping and Data
- *  structures pertaining to the CPPI Dma Controller.
- */
+/* CPPI DMA controller object */
 struct cppi {
 	struct dma_controller		Controller;
 	struct musb			*musb;
--- o26.orig/drivers/usb/musb/davinci.c	2007-08-21 16:52:00.000000000 -0700
+++ o26/drivers/usb/musb/davinci.c	2007-08-25 11:53:18.000000000 -0700
@@ -57,8 +57,9 @@ static inline void phy_on(void)
 {
 	/* start the on-chip PHY and its PLL */
 	__raw_writel(USBPHY_SESNDEN | USBPHY_VBDTCTEN | USBPHY_PHYPLLON,
-			IO_ADDRESS(USBPHY_CTL_PADDR));
-	while ((__raw_readl(IO_ADDRESS(USBPHY_CTL_PADDR))
+			(void __force __iomem *) IO_ADDRESS(USBPHY_CTL_PADDR));
+	while ((__raw_readl((void __force __iomem *)
+				IO_ADDRESS(USBPHY_CTL_PADDR))
 			& USBPHY_PHYCLKGD) == 0)
 		cpu_relax();
 }
@@ -66,7 +67,7 @@ static inline void phy_on(void)
 static inline void phy_off(void)
 {
 	/* powerdown the on-chip PHY and its oscillator */
-	__raw_writel(USBPHY_OSCPDWN | USBPHY_PHYPDWN,
+	__raw_writel(USBPHY_OSCPDWN | USBPHY_PHYPDWN, (void __force __iomem *)
 			IO_ADDRESS(USBPHY_CTL_PADDR));
 }
 
@@ -149,7 +150,7 @@ static void evm_deferred_drvvbus(struct 
 	davinci_i2c_expander_op(0x3a, USB_DRVVBUS, vbus_state);
 	vbus_state = !vbus_state;
 }
-DECLARE_WORK(evm_vbus_work, evm_deferred_drvvbus);
+static DECLARE_WORK(evm_vbus_work, evm_deferred_drvvbus);
 
 #endif	/* modified board */
 #endif	/* EVM */
@@ -189,7 +190,7 @@ static void davinci_source_power(struct 
 static void davinci_set_vbus(struct musb *musb, int is_on)
 {
 	WARN_ON(is_on && is_peripheral_active(musb));
-	return davinci_source_power(musb, is_on, 0);
+	davinci_source_power(musb, is_on, 0);
 }
 
 
@@ -200,7 +201,7 @@ static struct timer_list otg_workaround;
 static void otg_timer(unsigned long _musb)
 {
 	struct musb		*musb = (void *)_musb;
-	void	*__iomem	mregs = musb->mregs;
+	void __iomem		*mregs = musb->mregs;
 	u8			devctl;
 	unsigned long		flags;
 
@@ -260,7 +261,7 @@ static irqreturn_t davinci_interrupt(int
 	unsigned long	flags;
 	irqreturn_t	retval = IRQ_NONE;
 	struct musb	*musb = __hci;
-	void		*__iomem tibase = musb->ctrl_base;
+	void __iomem	*tibase = musb->ctrl_base;
 	u32		tmp;
 
 	spin_lock_irqsave(&musb->lock, flags);
@@ -309,7 +310,7 @@ static irqreturn_t davinci_interrupt(int
 	 */
 	if (tmp & (DAVINCI_INTR_DRVVBUS << DAVINCI_USB_USBINT_SHIFT)) {
 		int	drvvbus = musb_readl(tibase, DAVINCI_USB_STAT_REG);
-		void	*__iomem mregs = musb->mregs;
+		void __iomem *mregs = musb->mregs;
 		u8	devctl = musb_readb(mregs, MUSB_DEVCTL);
 		int	err = musb->int_usb & MUSB_INTR_VBUSERROR;
 
@@ -322,7 +323,7 @@ static irqreturn_t davinci_interrupt(int
 			 * to get VBUS errors during enumeration.
 			 *
 			 * This is a workaround, but newer RTL from Mentor
-			 * seems to lalow a better one: "re"starting sessions
+			 * seems to allow a better one: "re"starting sessions
 			 * without waiting (on EVM, a **long** time) for VBUS
 			 * to stop registering in devctl.
 			 */
@@ -378,8 +379,8 @@ static irqreturn_t davinci_interrupt(int
 
 int __init musb_platform_init(struct musb *musb)
 {
-	void	*__iomem tibase = musb->ctrl_base;
-	u32	revision;
+	void __iomem	*tibase = musb->ctrl_base;
+	u32		revision;
 
 	musb->mregs += DAVINCI_BASE_OFFSET;
 #if 0
@@ -416,8 +417,8 @@ int __init musb_platform_init(struct mus
 
 	/* NOTE:  irqs are in mixed mode, not bypass to pure-musb */
 	pr_debug("DaVinci OTG revision %08x phy %03x control %02x\n",
-		revision,
-		__raw_readl((void *__iomem) IO_ADDRESS(USBPHY_CTL_PADDR)),
+		revision, __raw_readl((void __force __iomem *)
+				IO_ADDRESS(USBPHY_CTL_PADDR)),
 		musb_readb(tibase, DAVINCI_USB_CTRL_REG));
 
 	musb->isr = davinci_interrupt;
--- o26.orig/drivers/usb/musb/davinci.h	2007-08-20 11:00:09.000000000 -0700
+++ o26/drivers/usb/musb/davinci.h	2007-08-25 11:53:18.000000000 -0700
@@ -76,7 +76,7 @@
 #define DAVINCI_DMA_ALL_CHANNELS_ENABLE	0xF
 #define DAVINCI_DMA_ALL_CHANNELS_DISABLE 0xF
 
-/* REVISIT relying on "volatile" here is wrong ... */
+/* FIXME relying on "volatile" here is wrong ... */
 
 /* define structures of Rx/Tx stateRam entries */
 struct cppi_tx_stateram {
--- o26.orig/drivers/usb/musb/musb_gadget_ep0.c	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/musb_gadget_ep0.c	2007-08-25 11:53:18.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * MUSB OTG driver ep0 handling
+ * MUSB OTG peripheral driver ep0 handling
  *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
@@ -978,6 +978,4 @@ const struct usb_ep_ops musb_g_ep0_ops =
 	.queue		= musb_g_ep0_queue,
 	.dequeue	= musb_g_ep0_dequeue,
 	.set_halt	= musb_g_ep0_halt,
-	.fifo_status	= NULL,
-	.fifo_flush	= NULL,
 };
--- o26.orig/drivers/usb/musb/musb_host.h	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/musb_host.h	2007-08-25 11:53:18.000000000 -0700
@@ -46,8 +46,7 @@ static inline struct musb *hcd_to_musb(s
 	return (void *) hcd->hcd_priv;
 }
 
-/* stored in "usb_host_endpoint.hcpriv" for scheduled endpoints
- */
+/* stored in "usb_host_endpoint.hcpriv" for scheduled endpoints */
 struct musb_qh {
 	struct usb_host_endpoint *hep;		/* usbcore info */
 	struct usb_device	*dev;
--- o26.orig/drivers/usb/musb/musb_io.h	2007-08-21 16:52:00.000000000 -0700
+++ o26/drivers/usb/musb/musb_io.h	2007-08-25 11:53:18.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * MUSB OTG driver Linux-specific architecture defines
+ * MUSB OTG driver register I/O
  *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
--- o26.orig/drivers/usb/musb/musb_procfs.c	2007-08-25 11:49:23.000000000 -0700
+++ o26/drivers/usb/musb/musb_procfs.c	2007-08-25 11:53:18.000000000 -0700
@@ -32,12 +32,6 @@
  *
  */
 
-/*
- * Inventra Controller Driver (ICD) for Linux.
- *
- * The code managing debug files (currently in procfs).
- */
-
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -478,7 +472,7 @@ dump_end_info(struct musb *musb, u8 epnu
 	return buf - aBuffer;
 }
 
-/** Dump the current status and compile options.
+/* Dump the current status and compile options.
  * @param musb the device driver instance
  * @param buffer where to dump the status; it must be big enough hold the
  * result otherwise "BAD THINGS HAPPENS(TM)".
@@ -537,7 +531,7 @@ static int dump_header_stats(struct musb
 
 #ifdef	CONFIG_USB_GADGET_MUSB_HDRC
 	code = sprintf(buffer, "Peripheral address: %02x\n",
-			musb_readb(musb, MUSB_FADDR));
+			musb_readb(musb->ctrl_base, MUSB_FADDR));
 	if (code <= 0)
 		goto done;
 	buffer += code;
@@ -560,7 +554,8 @@ static int dump_header_stats(struct musb
 			"\n",
 			musb_readl(musb->ctrl_base, DAVINCI_USB_CTRL_REG),
 			musb_readl(musb->ctrl_base, DAVINCI_USB_STAT_REG),
-			__raw_readl(IO_ADDRESS(USBPHY_CTL_PADDR)),
+			__raw_readl((void __force __iomem *)
+					IO_ADDRESS(USBPHY_CTL_PADDR)),
 			musb_readl(musb->ctrl_base, DAVINCI_RNDIS_REG),
 			musb_readl(musb->ctrl_base, DAVINCI_AUTOREQ_REG),
 			musb_readl(musb->ctrl_base,
--- o26.orig/drivers/usb/musb/musb_virthub.c	2007-08-23 11:54:40.000000000 -0700
+++ o26/drivers/usb/musb/musb_virthub.c	2007-08-25 11:53:18.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * MUSB OTG driver virtual hub support
+ * MUSB OTG driver virtual root hub support
  *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
--- o26.orig/drivers/usb/musb/musbhsdma.c	2007-08-23 11:54:40.000000000 -0700
+++ o26/drivers/usb/musb/musbhsdma.c	2007-08-25 11:53:18.000000000 -0700
@@ -1,5 +1,5 @@
 /*
- * MUSB OTG driver internal DMA controller support
+ * MUSB OTG driver - support for Mentor's DMA controller
  *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2007 by Texas Instruments
@@ -30,11 +30,6 @@
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  */
-
-/*
- * Implementation for the DMA controller within the MUSBMHDRC.
- */
-
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
