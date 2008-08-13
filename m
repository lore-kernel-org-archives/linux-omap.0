From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/3] usb: musb: pass configuration specifics via pdata
Date: Wed, 13 Aug 2008 20:36:16 +0300
Message-ID: <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com>
References: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com>
 <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16602 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYHMRgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 13:36:10 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7DHZwwu009183
	for <linux-omap@vger.kernel.org>; Wed, 13 Aug 2008 20:36:07 +0300
In-Reply-To: <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Use platform_data to pass musb configuration-specific
details to musb driver.

It's easier to maintain in the sense that neither board
will affect the other

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800-usb.c |   46 +++++++++-
 arch/arm/mach-omap2/usb-musb.c       |   51 +++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c   |    1 -
 drivers/usb/musb/musb_core.c         |   37 +++----
 drivers/usb/musb/musb_core.h         |   14 +---
 drivers/usb/musb/tusb6010.h          |  169 --------------------------------
 include/asm-arm/arch-omap/hdrc_cnf.h |  177 ----------------------------------
 include/linux/usb/musb.h             |   38 +++++++-
 8 files changed, 144 insertions(+), 389 deletions(-)
 delete mode 100644 include/asm-arm/arch-omap/hdrc_cnf.h

diff --git a/arch/arm/mach-omap2/board-n800-usb.c b/arch/arm/mach-omap2/board-n800-usb.c
index 7599f64..16ea8fc 100644
--- a/arch/arm/mach-omap2/board-n800-usb.c
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -35,14 +35,58 @@ static int tusb_set_clock(struct clk *osc_ck, int state);
 #	define BOARD_MODE	MUSB_HOST
 #endif
 
+static struct musb_hdrc_eps_bits musb_eps[] = {
+	{	"ep1_tx", 5,	},
+	{	"ep1_rx", 5,	},
+	{	"ep2_tx", 5,	},
+	{	"ep2_rx", 5,	},
+	{	"ep3_tx", 3,	},
+	{	"ep3_rx", 3,	},
+	{	"ep4_tx", 3,	},
+	{	"ep4_rx", 3,	},
+	{	"ep5_tx", 2,	},
+	{	"ep5_rx", 2,	},
+	{	"ep6_tx", 2,	},
+	{	"ep6_rx", 2,	},
+	{	"ep7_tx", 2,	},
+	{	"ep7_rx", 2,	},
+	{	"ep8_tx", 2,	},
+	{	"ep8_rx", 2,	},
+	{	"ep9_tx", 2,	},
+	{	"ep9_rx", 2,	},
+	{	"ep10_tx", 2,	},
+	{	"ep10_rx", 2,	},
+	{	"ep11_tx", 2,	},
+	{	"ep11_rx", 2,	},
+	{	"ep12_tx", 2,	},
+	{	"ep12_rx", 2,	},
+	{	"ep13_tx", 2,	},
+	{	"ep13_rx", 2,	},
+	{	"ep14_tx", 2,	},
+	{	"ep14_rx", 2,	},
+	{	"ep15_tx", 2,	},
+	{	"ep15_rx", 2,	},
+};
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= 1,
+	.dyn_fifo	= 1,
+	.soft_con	= 1,
+	.dma		= 1,
+	.num_eps	= 32,
+	.dma_channels	= 7,
+	.ram_bits	= 12,
+	.eps_bits	= musb_eps,
+};
+
 static struct musb_hdrc_platform_data tusb_data = {
 	.mode		= BOARD_MODE,
-	.multipoint	= 1,
 	.set_power	= tusb_set_power,
 	.set_clock	= tusb_set_clock,
 	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
 	.power		= 100,	/* Max 100 mA VBUS for host mode */
 	.clock		= "osc_ck",
+	.config		= &musb_config,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index cbd59f8..842edb3 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -37,7 +37,7 @@ static struct resource musb_resources[] = {
 			: OMAP243X_HS_BASE,
 		.end	= cpu_is_omap34xx()
 			? OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1
-			: OMAP243X_HS_BASE + SZ_8K -1,
+			: OMAP243X_HS_BASE + SZ_8K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {	/* general IRQ */
@@ -73,6 +73,51 @@ static int musb_set_clock(struct clk *clk, int state)
 	return 0;
 }
 
+static struct musb_hdrc_eps_bits musb_eps[] = {
+	{	"ep1_tx", 10,	},
+	{	"ep1_rx", 10,	},
+	{	"ep2_tx", 9,	},
+	{	"ep2_rx", 9,	},
+	{	"ep3_tx", 3,	},
+	{	"ep3_rx", 3,	},
+	{	"ep4_tx", 3,	},
+	{	"ep4_rx", 3,	},
+	{	"ep5_tx", 3,	},
+	{	"ep5_rx", 3,	},
+	{	"ep6_tx", 3,	},
+	{	"ep6_rx", 3,	},
+	{	"ep7_tx", 3,	},
+	{	"ep7_rx", 3,	},
+	{	"ep8_tx", 2,	},
+	{	"ep8_rx", 2,	},
+	{	"ep9_tx", 2,	},
+	{	"ep9_rx", 2,	},
+	{	"ep10_tx", 2,	},
+	{	"ep10_rx", 2,	},
+	{	"ep11_tx", 2,	},
+	{	"ep11_rx", 2,	},
+	{	"ep12_tx", 2,	},
+	{	"ep12_rx", 2,	},
+	{	"ep13_tx", 2,	},
+	{	"ep13_rx", 2,	},
+	{	"ep14_tx", 2,	},
+	{	"ep14_rx", 2,	},
+	{	"ep15_tx", 2,	},
+	{	"ep15_rx", 2,	},
+};
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= 1,
+	.dyn_fifo	= 1,
+	.soft_con	= 1,
+	.dma		= 1,
+	.num_eps	= 32,
+	.dma_channels	= 7,
+	.dma_req_chan	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
+	.ram_bits	= 12,
+	.eps_bits	= musb_eps,
+};
+
 static struct musb_hdrc_platform_data musb_plat = {
 #ifdef CONFIG_USB_MUSB_OTG
 	.mode		= MUSB_OTG,
@@ -81,18 +126,18 @@ static struct musb_hdrc_platform_data musb_plat = {
 #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode		= MUSB_PERIPHERAL,
 #endif
-	.multipoint	= 1,
 	.clock		= cpu_is_omap34xx()
 			? "hsotgusb_ick"
 			: "usbhs_ick",
 	.set_clock	= musb_set_clock,
+	.config		= &musb_config,
 };
 
 static u64 musb_dmamask = ~(u32)0;
 
 static struct platform_device musb_device = {
 	.name		= "musb_hdrc",
-	.id		= 0,
+	.id		= -1,
 	.dev = {
 		.dma_mask		= &musb_dmamask,
 		.coherent_dma_mask	= 0xffffffff,
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 9924300..75e2669 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -315,7 +315,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		printk(error, 6, status);
 		return -ENODEV;
 	}
-	data->multipoint = 1;
 	tusb_device.dev.platform_data = data;
 
 	/* REVISIT let the driver know what DMA channels work */
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 1404a10..4f8aa1d 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -990,12 +990,6 @@ static void musb_shutdown(struct platform_device *pdev)
  * We don't currently use dynamic fifo setup capability to do anything
  * more than selecting one of a bunch of predefined configurations.
  */
-#ifdef MUSB_C_DYNFIFO_DEF
-#define	can_dynfifo()	1
-#else
-#define	can_dynfifo()	0
-#endif
-
 #if defined(CONFIG_USB_TUSB6010) || \
 	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 static ushort __initdata fifo_mode = 4;
@@ -1008,8 +1002,6 @@ module_param(fifo_mode, ushort, 0);
 MODULE_PARM_DESC(fifo_mode, "initial endpoint configuration");
 
 
-#define DYN_FIFO_SIZE (1<<(MUSB_C_RAM_BITS+2))
-
 enum fifo_style { FIFO_RXTX, FIFO_TX, FIFO_RX } __attribute__ ((packed));
 enum buf_mode { BUF_SINGLE, BUF_DOUBLE } __attribute__ ((packed));
 
@@ -1119,11 +1111,12 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 
 	c_size = size - 3;
 	if (cfg->mode == BUF_DOUBLE) {
-		if ((offset + (maxpacket << 1)) > DYN_FIFO_SIZE)
+		if ((offset + (maxpacket << 1)) >
+				(1 << (musb->config->ram_bits + 2)))
 			return -EMSGSIZE;
 		c_size |= MUSB_FIFOSZ_DPB;
 	} else {
-		if ((offset + maxpacket) > DYN_FIFO_SIZE)
+		if ((offset + maxpacket) > (1 << (musb->config->ram_bits + 2)))
 			return -EMSGSIZE;
 	}
 
@@ -1219,13 +1212,13 @@ static int __init ep_config_from_table(struct musb *musb)
 	/* assert(offset > 0) */
 
 	/* NOTE:  for RTL versions >= 1.400 EPINFO and RAMINFO would
-	 * be better than static MUSB_C_NUM_EPS and DYN_FIFO_SIZE...
+	 * be better than static musb->config->num_eps and DYN_FIFO_SIZE...
 	 */
 
 	for (i = 0; i < n; i++) {
 		u8	epn = cfg->hw_ep_num;
 
-		if (epn >= MUSB_C_NUM_EPS) {
+		if (epn >= musb->config->num_eps) {
 			pr_debug("%s: invalid ep %d\n",
 					musb_driver_name, epn);
 			continue;
@@ -1242,8 +1235,8 @@ static int __init ep_config_from_table(struct musb *musb)
 
 	printk(KERN_DEBUG "%s: %d/%d max ep, %d/%d memory\n",
 			musb_driver_name,
-			n + 1, MUSB_C_NUM_EPS * 2 - 1,
-			offset, DYN_FIFO_SIZE);
+			n + 1, musb->config->num_eps * 2 - 1,
+			offset, (1 << (musb->config->ram_bits + 2)));
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (!musb->bulk_ep) {
@@ -1270,7 +1263,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 
 	/* FIXME pick up ep0 maxpacket size */
 
-	for (epnum = 1; epnum < MUSB_C_NUM_EPS; epnum++) {
+	for (epnum = 1; epnum < musb->config->num_eps; epnum++) {
 		musb_ep_select(mbase, epnum);
 		hw_ep = musb->endpoints + epnum;
 
@@ -1424,14 +1417,14 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	musb->epmask = 1;
 
 	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
-		if (can_dynfifo())
+		if (musb->config->dyn_fifo)
 			status = ep_config_from_table(musb);
 		else {
 			ERR("reconfigure software for Dynamic FIFOs\n");
 			status = -ENODEV;
 		}
 	} else {
-		if (!can_dynfifo())
+		if (!musb->config->dyn_fifo)
 			status = ep_config_from_hw(musb);
 		else {
 			ERR("reconfigure software for static FIFOs\n");
@@ -1788,7 +1781,8 @@ static void musb_irq_work(struct work_struct *data)
  */
 
 static struct musb *__init
-allocate_instance(struct device *dev, void __iomem *mbase)
+allocate_instance(struct device *dev,
+		struct musb_hdrc_config *config, void __iomem *mbase)
 {
 	struct musb		*musb;
 	struct musb_hw_ep	*ep;
@@ -1820,8 +1814,9 @@ allocate_instance(struct device *dev, void __iomem *mbase)
 	musb->mregs = mbase;
 	musb->ctrl_base = mbase;
 	musb->nIrq = -ENODEV;
+	musb->config = config;
 	for (epnum = 0, ep = musb->endpoints;
-			epnum < MUSB_C_NUM_EPS;
+			epnum < musb->config->num_eps;
 			epnum++, ep++) {
 
 		ep->musb = musb;
@@ -1932,7 +1927,7 @@ bad_config:
 	}
 
 	/* allocate */
-	musb = allocate_instance(dev, ctrl);
+	musb = allocate_instance(dev, plat->config, ctrl);
 	if (!musb)
 		return -ENOMEM;
 
@@ -1990,7 +1985,7 @@ bad_config:
 	musb_generic_disable(musb);
 
 	/* setup musb parts of the core (especially endpoints) */
-	status = musb_core_init(plat->multipoint
+	status = musb_core_init(plat->config->multipoint
 			? MUSB_CONTROLLER_MHDRC
 			: MUSB_CONTROLLER_HDRC, musb);
 	if (status < 0)
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index c2cd5a9..73a794a 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -56,18 +56,6 @@ struct musb_ep;
 #include "musb_debug.h"
 #include "musb_dma.h"
 
-#ifdef CONFIG_USB_MUSB_SOC
-/*
- * Get core configuration from a header converted (by cfg_conv)
- * from the Verilog config file generated by the core config utility
- *
- * For now we assume that header is provided along with other
- * arch-specific files.  Discrete chips will need a build tweak.
- * So will using AHB IDs from silicon that provides them.
- */
-#include <asm/arch/hdrc_cnf.h>
-#endif
-
 #include "musb_io.h"
 #include "musb_regs.h"
 
@@ -439,6 +427,8 @@ struct musb {
 	struct usb_gadget_driver *gadget_driver;	/* its driver */
 #endif
 
+	struct musb_hdrc_config	*config;
+
 #ifdef MUSB_CONFIG_PROC_FS
 	struct proc_dir_entry *proc_entry;
 #endif
diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
index db6dad0..ab8c962 100644
--- a/drivers/usb/musb/tusb6010.h
+++ b/drivers/usb/musb/tusb6010.h
@@ -230,173 +230,4 @@ extern u8 tusb_get_revision(struct musb *musb);
 #define TUSB_REV_30	0x30
 #define TUSB_REV_31	0x31
 
-/*----------------------------------------------------------------------------*/
-
-#ifdef CONFIG_USB_TUSB6010
-
-/* configuration parameters specific to this silicon */
-
-/* Number of Tx endpoints. Legal values are 1 - 16 (this value includes EP0) */
-#define MUSB_C_NUM_EPT 16
-
-/* Number of Rx endpoints. Legal values are 1 - 16 (this value includes EP0) */
-#define MUSB_C_NUM_EPR 16
-
-/* Endpoint 1 to 15 direction types. C_EP1_DEF is defined if either Tx endpoint
- * 1 or Rx endpoint 1 are used.
- */
-#define MUSB_C_EP1_DEF
-
-/* C_EP1_TX_DEF is defined if Tx endpoint 1 is used */
-#define MUSB_C_EP1_TX_DEF
-
-/* C_EP1_RX_DEF is defined if Rx endpoint 1 is used */
-#define MUSB_C_EP1_RX_DEF
-
-/* C_EP1_TOR_DEF is defined if Tx endpoint 1 and Rx endpoint 1 share a FIFO */
-/* #define C_EP1_TOR_DEF */
-
-/* C_EP1_TAR_DEF is defined if both Tx endpoint 1 and Rx endpoint 1 are used
- * and do not share a FIFO.
- */
-#define MUSB_C_EP1_TAR_DEF
-
-/* Similarly for all other used endpoints */
-#define MUSB_C_EP2_DEF
-#define MUSB_C_EP2_TX_DEF
-#define MUSB_C_EP2_RX_DEF
-#define MUSB_C_EP2_TAR_DEF
-#define MUSB_C_EP3_DEF
-#define MUSB_C_EP3_TX_DEF
-#define MUSB_C_EP3_RX_DEF
-#define MUSB_C_EP3_TAR_DEF
-#define MUSB_C_EP4_DEF
-#define MUSB_C_EP4_TX_DEF
-#define MUSB_C_EP4_RX_DEF
-#define MUSB_C_EP4_TAR_DEF
-
-/* Endpoint 1 to 15 FIFO address bits. Legal values are 3 to 13 - corresponding
- * to FIFO sizes of 8 to 8192 bytes. If an Tx endpoint shares a FIFO with an Rx
- * endpoint then the Rx FIFO size must be the same as the Tx FIFO size. All
- * endpoints 1 to 15 must be defined, unused endpoints should be set to 2.
- */
-#define MUSB_C_EP1T_BITS 5
-#define MUSB_C_EP1R_BITS 5
-#define MUSB_C_EP2T_BITS 5
-#define MUSB_C_EP2R_BITS 5
-#define MUSB_C_EP3T_BITS 3
-#define MUSB_C_EP3R_BITS 3
-#define MUSB_C_EP4T_BITS 3
-#define MUSB_C_EP4R_BITS 3
-
-#define MUSB_C_EP5T_BITS 2
-#define MUSB_C_EP5R_BITS 2
-#define MUSB_C_EP6T_BITS 2
-#define MUSB_C_EP6R_BITS 2
-#define MUSB_C_EP7T_BITS 2
-#define MUSB_C_EP7R_BITS 2
-#define MUSB_C_EP8T_BITS 2
-#define MUSB_C_EP8R_BITS 2
-#define MUSB_C_EP9T_BITS 2
-#define MUSB_C_EP9R_BITS 2
-#define MUSB_C_EP10T_BITS 2
-#define MUSB_C_EP10R_BITS 2
-#define MUSB_C_EP11T_BITS 2
-#define MUSB_C_EP11R_BITS 2
-#define MUSB_C_EP12T_BITS 2
-#define MUSB_C_EP12R_BITS 2
-#define MUSB_C_EP13T_BITS 2
-#define MUSB_C_EP13R_BITS 2
-#define MUSB_C_EP14T_BITS 2
-#define MUSB_C_EP14R_BITS 2
-#define MUSB_C_EP15T_BITS 2
-#define MUSB_C_EP15R_BITS 2
-
-/* Define the following constant if the USB2.0 Transceiver Macrocell data width
- * is 16-bits.
- */
-/* #define C_UTM_16 */
-
-/* Define this constant if the CPU uses big-endian byte ordering. */
-/* #define C_BIGEND */
-
-/* Define the following constant if any Tx endpoint is required to support
- * multiple bulk packets.
- */
-/* #define C_MP_TX */
-
-/* Define the following constant if any Rx endpoint is required to support
- * multiple bulk packets.
- */
-/* #define C_MP_RX */
-
-/* Define the following constant if any Tx endpoint is required to support high
- * bandwidth ISO.
- */
-/* #define C_HB_TX */
-
-/* Define the following constant if any Rx endpoint is required to support high
- * bandwidth ISO.
- */
-/* #define C_HB_RX */
-
-/* Define the following constant if software connect/disconnect control is
- * required.
- */
-#define MUSB_C_SOFT_CON
-
-/* Define the following constant if Vendor Control Registers are required. */
-/* #define C_VEND_REG */
-
-/* Vendor control register widths. */
-#define MUSB_C_VCTL_BITS 4
-#define MUSB_C_VSTAT_BITS 8
-
-/* Define the following constant to include a DMA controller. */
-/* #define C_DMA */
-
-/* Define the following constant if 2 or more DMA channels are required. */
-/* #define C_DMA2 */
-
-/* Define the following constant if 3 or more DMA channels are required. */
-/* #define C_DMA3 */
-
-/* Define the following constant if 4 or more DMA channels are required. */
-/* #define C_DMA4 */
-
-/* Define the following constant if 5 or more DMA channels are required. */
-/* #define C_DMA5 */
-
-/* Define the following constant if 6 or more DMA channels are required. */
-/* #define C_DMA6 */
-
-/* Define the following constant if 7 or more DMA channels are required. */
-/* #define C_DMA7 */
-
-/* Define the following constant if 8 or more DMA channels are required. */
-/* #define C_DMA8 */
-
-/* Enable Dynamic FIFO Sizing */
-#define MUSB_C_DYNFIFO_DEF
-
-/* Derived constants. The following constants are derived from the previous
- * configuration constants
- */
-
-/* Total number of endpoints. Legal values are 2 - 16. This must be equal to
- * the larger of C_NUM_EPT, C_NUM_EPR
- */
-/* #define MUSB_C_NUM_EPS 5 */
-
-/* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits */
-#define MUSB_C_EPMAX_BITS 11
-
-/* C_RAM_BITS is the number of address bits required to address the RAM (32-bit
- * addresses).  It is defined as log2 of the sum of 2** of all the endpoint FIFO
- * dword address bits (rounded up).
- */
-#define MUSB_C_RAM_BITS 12
-
-#endif /* CONFIG_USB_TUSB6010 */
-
 #endif /* __TUSB6010_H__ */
diff --git a/include/asm-arm/arch-omap/hdrc_cnf.h b/include/asm-arm/arch-omap/hdrc_cnf.h
deleted file mode 100644
index 74c8432..0000000
--- a/include/asm-arm/arch-omap/hdrc_cnf.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * Copyright 2005 Mentor Graphics Corporation
- * USB High-Speed Multi-Point Dual-Role Controller Configuration
- *
- * Copyright Mentor Graphics Corporation and Licensors 2004
- * Copyright (C) 2005 by Texas Instruments
- *
- * This file contains configuration constants for the (m)hdrc
- * silicon as integrated into DaVinci CPUs.
- */
-
-#ifndef	__ARCH_MUSB_HDRC_CNF
-#define	__ARCH_MUSB_HDRC_CNF
-
-/* ** Number of Tx endpoints ** */
-/* Legal values are 1 - 16 (this value includes EP0) */
-#define MUSB_C_NUM_EPT 8
-
-/* ** Number of Rx endpoints ** */
-/* Legal values are 1 - 16 (this value includes EP0) */
-#define MUSB_C_NUM_EPR 8
-
-/* ** Endpoint 1 to 15 direction types ** */
-/* C_EP1_DEF is defined if either Tx endpoint 1 or Rx endpoint 1 are used */
-#define MUSB_C_EP1_DEF
-
-/* C_EP1_TX_DEF is defined if Tx endpoint 1 is used */
-#define MUSB_C_EP1_TX_DEF
-
-/* C_EP1_RX_DEF is defined if Rx endpoint 1 is used */
-#define MUSB_C_EP1_RX_DEF
-
-/* C_EP1_TOR_DEF is defined if Tx endpoint 1 and Rx endpoint 1 share a FIFO */
-/*`define C_EP1_TOR_DEF */
-
-/* C_EP1_TAR_DEF is defined if both Tx endpoint 1 and Rx endpoint 1 are used */
-/* and do not share a FIFO */
-#define MUSB_C_EP1_TAR_DEF
-
-/* Similarly for all other used endpoints */
-#define MUSB_C_EP2_DEF
-#define MUSB_C_EP2_TX_DEF
-#define MUSB_C_EP2_RX_DEF
-#define MUSB_C_EP2_TAR_DEF
-#define MUSB_C_EP3_DEF
-#define MUSB_C_EP3_TX_DEF
-#define MUSB_C_EP3_RX_DEF
-#define MUSB_C_EP3_TAR_DEF
-#define MUSB_C_EP4_DEF
-#define MUSB_C_EP4_TX_DEF
-#define MUSB_C_EP4_RX_DEF
-#define MUSB_C_EP4_TAR_DEF
-#define MUSB_C_EP5_DEF
-#define MUSB_C_EP5_TX_DEF
-#define MUSB_C_EP5_RX_DEF
-#define MUSB_C_EP5_TAR_DEF
-#define MUSB_C_EP6_DEF
-#define MUSB_C_EP6_TX_DEF
-#define MUSB_C_EP6_RX_DEF
-#define MUSB_C_EP6_TAR_DEF
-#define MUSB_C_EP7_DEF
-#define MUSB_C_EP7_TX_DEF
-#define MUSB_C_EP7_RX_DEF
-#define MUSB_C_EP7_TAR_DEF
-
-/* ** Endpoint 1 to 15 FIFO address bits ** */
-/* Legal values are 3 to 13 - corresponding to FIFO sizes of 8 to 8192 bytes. */
-/* If an Tx endpoint shares a FIFO with an Rx endpoint then the Rx FIFO size */
-/* must be the same as the Tx FIFO size. */
-/* All endpoints 1 to 15 must be defined, unused endpoints should be set to 2. */
-#define MUSB_C_EP1T_BITS 10
-#define MUSB_C_EP1R_BITS 10
-#define MUSB_C_EP2T_BITS 9
-#define MUSB_C_EP2R_BITS 9
-#define MUSB_C_EP3T_BITS 3
-#define MUSB_C_EP3R_BITS 3
-#define MUSB_C_EP4T_BITS 3
-#define MUSB_C_EP4R_BITS 3
-#define MUSB_C_EP5T_BITS 3
-#define MUSB_C_EP5R_BITS 3
-#define MUSB_C_EP6T_BITS 3
-#define MUSB_C_EP6R_BITS 3
-#define MUSB_C_EP7T_BITS 3
-#define MUSB_C_EP7R_BITS 3
-#define MUSB_C_EP8T_BITS 2
-#define MUSB_C_EP8R_BITS 2
-#define MUSB_C_EP9T_BITS 2
-#define MUSB_C_EP9R_BITS 2
-#define MUSB_C_EP10T_BITS 2
-#define MUSB_C_EP10R_BITS 2
-#define MUSB_C_EP11T_BITS 2
-#define MUSB_C_EP11R_BITS 2
-#define MUSB_C_EP12T_BITS 2
-#define MUSB_C_EP12R_BITS 2
-#define MUSB_C_EP13T_BITS 2
-#define MUSB_C_EP13R_BITS 2
-#define MUSB_C_EP14T_BITS 2
-#define MUSB_C_EP14R_BITS 2
-#define MUSB_C_EP15T_BITS 2
-#define MUSB_C_EP15R_BITS 2
-
-/* Define the following constant if the USB2.0 Transceiver Macrocell data width is 16-bits. */
-/* `define C_UTM_16 */
-
-/* Define this constant if the CPU uses big-endian byte ordering. */
-/*`define C_BIGEND */
-
-/* Define the following constant if any Tx endpoint is required to support multiple bulk packets. */
-/* `define C_MP_TX */
-
-/* Define the following constant if any Rx endpoint is required to support multiple bulk packets. */
-/* `define C_MP_RX */
-
-/* Define the following constant if any Tx endpoint is required to support high bandwidth ISO. */
-/* `define C_HB_TX */
-
-/* Define the following constant if any Rx endpoint is required to support high bandwidth ISO. */
-/* `define C_HB_RX */
-
-/* Define the following constant if software connect/disconnect control is required. */
-#define MUSB_C_SOFT_CON
-
-/* Define the following constant if Vendor Control Registers are required. */
-/* `define C_VEND_REG */
-
-/* Vendor control register widths. */
-#define MUSB_C_VCTL_BITS 4
-#define MUSB_C_VSTAT_BITS 8
-
-
-/* Define the following constant to include a DMA controller. */
-#define MUSB_C_DMA
-
-/* Define the following constant if 2 or more DMA channels are required. */
-#define MUSB_C_DMA2
-
-/* Define the following constant if 3 or more DMA channels are required. */
-#define MUSB_C_DMA3
-
-/* Define the following constant if 4 or more DMA channels are required. */
-#define MUSB_C_DMA4
-
-/* Define the following constant if 5 or more DMA channels are required. */
-/*`define C_DMA5 */
-
-/* Define the following constant if 6 or more DMA channels are required. */
-/*`define C_DMA6 */
-
-/* Define the following constant if 7 or more DMA channels are required. */
-/*`define C_DMA7 */
-
-/* Define the following constant if 8 or more DMA channels are required. */
-/*`define C_DMA8 */
-
-
-/* ** Enable Dynamic FIFO Sizing ** */
-#define MUSB_C_DYNFIFO_DEF
-
-/* ** Derived constants ** */
-/* The following constants are derived from the previous configuration constants */
-
-/* Total number of endpoints
- * Legal values are 2 - 16
- * This must be equal to the larger of C_NUM_EPT, C_NUM_EPR
- */
-#define MUSB_C_NUM_EPS 8
-
-/* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits */
-#define MUSB_C_EPMAX_BITS 12
-
-/* C_RAM_BITS is the number of address bits required to address the RAM (32-bit
- * addresses).  It is defined as log2 of the sum of 2** of all the endpoint FIFO
- * dword address bits (rounded up).
- */
-#define MUSB_C_RAM_BITS 12
-
-#endif	/* __ARCH_MUSB_HDRC_CNF */
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d325a0d..630962c 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -19,6 +19,36 @@ enum musb_mode {
 
 struct clk;
 
+struct musb_hdrc_eps_bits {
+	const char	name[16];
+	u8		bits;
+};
+
+struct musb_hdrc_config {
+	/* MUSB configuration-specific details */
+	unsigned	multipoint:1;	/* multipoint device */
+	unsigned	dyn_fifo:1;	/* supports dynamic fifo sizing */
+	unsigned	soft_con:1;	/* soft connect required */
+	unsigned	utm_16:1;	/* utm data witdh is 16 bits */
+	unsigned	big_endian:1;	/* true if CPU uses big-endian */
+	unsigned	mult_bulk_tx:1;	/* Tx ep required for multbulk pkts */
+	unsigned	mult_bulk_rx:1;	/* Rx ep required for multbulk pkts */
+	unsigned	high_iso_tx:1;	/* Tx ep required for HB iso */
+	unsigned	high_iso_rx:1;	/* Rx ep required for HD iso */
+	unsigned	dma:1;		/* supports DMA */
+	unsigned	vendor_req:1;	/* vendor registers required */
+
+	u8		num_eps;	/* number of endpoints _with_ ep0 */
+	u8		dma_channels;	/* number of dma channels */
+	u8		dyn_fifo_size;	/* dynamic size in bytes */
+	u8		vendor_ctrl;	/* vendor control reg width */
+	u8		vendor_stat;	/* vendor status reg witdh */
+	u8		dma_req_chan;	/* bitmask for required dma channels */
+	u8		ram_bits;	/* ram address size */
+
+	struct musb_hdrc_eps_bits *eps_bits;
+};
+
 struct musb_hdrc_platform_data {
 	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
 	u8		mode;
@@ -38,16 +68,14 @@ struct musb_hdrc_platform_data {
 	/* (HOST or OTG) msec/2 after VBUS on till power good */
 	u8		potpgt;
 
-	/* TBD:  chip defaults should probably go someplace else,
-	 * e.g. number of tx/rx endpoints, etc
-	 */
-	unsigned	multipoint:1;
-
 	/* Power the device on or off */
 	int		(*set_power)(int state);
 
 	/* Turn device clock on or off */
 	int		(*set_clock)(struct clk *clock, int is_on);
+
+	/* MUSB configuration-specific details */
+	struct musb_hdrc_config	*config;
 };
 
 
-- 
1.6.0.rc1.71.gfba5

