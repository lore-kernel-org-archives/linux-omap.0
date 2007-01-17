From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.20-rc5-omap] musb_hdrc runtime code shrinkage
Date: Wed, 17 Jan 2007 12:41:59 -0800
Message-ID: <200701171241.59902.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Move musb_hdrc driver init into the init section, by switching over to use
platform_driver_probe().  Shrinks this driver's run-time footprint by about
5KB ... pretty good for linker level tweaks to just one (big) driver, and
there's a bit more shrinkage yet to be had (for DMA init).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/drivers/usb/musb/davinci.c
===================================================================
--- h4.orig/drivers/usb/musb/davinci.c	2007-01-09 22:24:42.000000000 -0800
+++ h4/drivers/usb/musb/davinci.c	2007-01-09 23:47:08.000000000 -0800
@@ -376,7 +376,7 @@ static irqreturn_t davinci_interrupt(int
 	return IRQ_HANDLED;
 }
 
-int __devinit musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb)
 {
 	void	*__iomem tibase = musb->ctrl_base;
 	u32	revision;
Index: h4/drivers/usb/musb/omap2430.c
===================================================================
--- h4.orig/drivers/usb/musb/omap2430.c	2007-01-09 22:24:41.000000000 -0800
+++ h4/drivers/usb/musb/omap2430.c	2007-01-09 23:45:13.000000000 -0800
@@ -61,7 +61,7 @@ static void omap_vbus_power(struct musb 
 {
 }
 
-int __devinit musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb)
 {
 	/* Erratum - reset value of STP has pull-down.
 	   Change it to pull-up. */
Index: h4/drivers/usb/musb/plat_uds.c
===================================================================
--- h4.orig/drivers/usb/musb/plat_uds.c	2007-01-09 23:45:01.000000000 -0800
+++ h4/drivers/usb/musb/plat_uds.c	2007-01-09 23:47:09.000000000 -0800
@@ -807,9 +807,9 @@ static void musb_shutdown(struct platfor
 #endif
 
 #ifdef CONFIG_USB_TUSB6010
-static ushort __devinitdata fifo_mode = 4;
+static ushort __initdata fifo_mode = 4;
 #else
-static ushort __devinitdata fifo_mode = 2;
+static ushort __initdata fifo_mode = 2;
 #endif
 
 /* "modprobe ... fifo_mode=1" etc */
@@ -835,7 +835,7 @@ struct fifo_cfg {
  */
 
 /* mode 0 - fits in 2KB */
-static const struct fifo_cfg __devinitdata mode_0_cfg[] = {
+static struct fifo_cfg __initdata mode_0_cfg[] = {
 { .hw_ep_num = 1, .style = FIFO_TX,   .maxpacket = 512, },
 { .hw_ep_num = 1, .style = FIFO_RX,   .maxpacket = 512, },
 { .hw_ep_num = 2, .style = FIFO_RXTX, .maxpacket = 512, },
@@ -844,7 +844,7 @@ static const struct fifo_cfg __devinitda
 };
 
 /* mode 1 - fits in 4KB */
-static const struct fifo_cfg __devinitdata mode_1_cfg[] = {
+static struct fifo_cfg __initdata mode_1_cfg[] = {
 { .hw_ep_num = 1, .style = FIFO_TX,   .maxpacket = 512, .mode = BUF_DOUBLE, },
 { .hw_ep_num = 1, .style = FIFO_RX,   .maxpacket = 512, .mode = BUF_DOUBLE, },
 { .hw_ep_num = 2, .style = FIFO_RXTX, .maxpacket = 512, .mode = BUF_DOUBLE, },
@@ -853,7 +853,7 @@ static const struct fifo_cfg __devinitda
 };
 
 /* mode 2 - fits in 4KB */
-static const struct fifo_cfg __devinitdata mode_2_cfg[] = {
+static struct fifo_cfg __initdata mode_2_cfg[] = {
 { .hw_ep_num = 1, .style = FIFO_TX,   .maxpacket = 512, },
 { .hw_ep_num = 1, .style = FIFO_RX,   .maxpacket = 512, },
 { .hw_ep_num = 2, .style = FIFO_TX,   .maxpacket = 512, },
@@ -863,7 +863,7 @@ static const struct fifo_cfg __devinitda
 };
 
 /* mode 3 - fits in 4KB */
-static const struct fifo_cfg __devinitdata mode_3_cfg[] = {
+static struct fifo_cfg __initdata mode_3_cfg[] = {
 { .hw_ep_num = 1, .style = FIFO_TX,   .maxpacket = 512, .mode = BUF_DOUBLE, },
 { .hw_ep_num = 1, .style = FIFO_RX,   .maxpacket = 512, .mode = BUF_DOUBLE, },
 { .hw_ep_num = 2, .style = FIFO_TX,   .maxpacket = 512, },
@@ -873,7 +873,7 @@ static const struct fifo_cfg __devinitda
 };
 
 /* mode 4 - fits in 16KB */
-static const struct fifo_cfg __devinitdata mode_4_cfg[] = {
+static struct fifo_cfg __initdata mode_4_cfg[] = {
 { .hw_ep_num =  1, .style = FIFO_TX,   .maxpacket = 512, },
 { .hw_ep_num =  1, .style = FIFO_RX,   .maxpacket = 512, },
 { .hw_ep_num =  2, .style = FIFO_TX,   .maxpacket = 512, },
@@ -911,7 +920,7 @@ static const struct fifo_cfg __devinitda
  *
  * returns negative errno or offset for next fifo.
  */
-static int __devinit
+static int __init
 fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 		const struct fifo_cfg *cfg, u16 offset)
 {
@@ -983,11 +992,11 @@ fifo_setup(struct musb *musb, struct mus
 	return offset + (maxpacket << ((c_size & MGC_M_FIFOSZ_DPB) ? 1 : 0));
 }
 
-static const struct fifo_cfg __devinitdata ep0_cfg = {
+static struct fifo_cfg __initdata ep0_cfg = {
 	.style = FIFO_RXTX, .maxpacket = 64,
 };
 
-static int __devinit ep_config_from_table(struct musb *musb)
+static int __init ep_config_from_table(struct musb *musb)
 {
 	const struct fifo_cfg	*cfg;
 	unsigned		i, n;
@@ -1069,7 +1082,7 @@ static int __devinit ep_config_from_tabl
  * ep_config_from_hw - when MUSB_C_DYNFIFO_DEF is false
  * @param pThis the controller
  */
-static int __devinit ep_config_from_hw(struct musb *musb)
+static int __init ep_config_from_hw(struct musb *musb)
 {
 	u8 bEnd = 0, reg;
 	struct musb_hw_ep *pEnd;
@@ -1136,7 +1149,7 @@ enum { MUSB_CONTROLLER_MHDRC, MUSB_CONTR
 /* Initialize MUSB (M)HDRC part of the USB hardware subsystem;
  * configure endpoints, or take their config from silicon
  */
-static int __devinit musb_core_init(u16 wType, struct musb *pThis)
+static int __init musb_core_init(u16 wType, struct musb *pThis)
 {
 #ifdef MUSB_AHB_ID
 	u32 dwData;
@@ -1422,7 +1435,7 @@ irqreturn_t musb_interrupt(struct musb *
 
 
 #ifndef CONFIG_USB_INVENTRA_FIFO
-static int __devinitdata use_dma = is_dma_capable();
+static int __initdata use_dma = 1;
 
 /* "modprobe ... use_dma=0" etc */
 module_param(use_dma, bool, 0);
@@ -1468,7 +1481,7 @@ void musb_dma_completion(struct musb *mu
 }
 
 #else
-#define use_dma			is_dma_capable()
+#define use_dma			0
 #endif
 
 /*-------------------------------------------------------------------------*/
@@ -1560,7 +1573,7 @@ static void musb_irq_work(void *data)
  * Init support
  */
 
-static struct musb *__devinit
+static struct musb *__init
 allocate_instance(struct device *dev, void __iomem *mbase)
 {
 	struct musb		*musb;
@@ -1656,7 +1669,7 @@ static void musb_free(struct musb *musb)
  * @pRegs: virtual address of controller registers,
  *	not yet corrected for platform-specific offsets
  */
-static int __devinit
+static int __init
 musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 {
 	int			status;
@@ -1723,6 +1736,9 @@ musb_init_controller(struct device *dev,
 	if (use_dma && dev->dma_mask) {
 		struct dma_controller	*c;
 
+// FIXME get rid of dma_controller_factory and just call the methods
+// directly ... then create() can be in the init section, etc
+
 		c = dma_controller_factory.create(pThis, pThis->pRegs);
 		pThis->pDmaController = c;
 		if (c)
@@ -1750,6 +1766,7 @@ musb_init_controller(struct device *dev,
 		goto fail2;
 	}
 	pThis->nIrq = nIrq;
+// FIXME this handles wakeup irqs wrong
 	if (enable_irq_wake(nIrq) == 0)
 		device_init_wakeup(dev, 1);
 
@@ -1849,7 +1866,7 @@ fail2:
 static u64	*orig_dma_mask;
 #endif
 
-static int __devinit musb_probe(struct platform_device *pdev)
+static int __init musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	int		irq = platform_get_irq(pdev, 0);
@@ -1954,7 +1971,6 @@ static struct platform_driver musb_drive
 		.bus		= &platform_bus_type,
 		.owner		= THIS_MODULE,
 	},
-	.probe		= musb_probe,
 	.remove		= __devexit_p(musb_remove),
 	.shutdown	= musb_shutdown,
 	.suspend	= musb_suspend,
@@ -1992,7 +2008,7 @@ static int __init musb_init(void)
 #endif
 		", debug=%d\n",
 		musb_driver_name, debug);
-	return platform_driver_register(&musb_driver);
+	return platform_driver_probe(&musb_driver, musb_probe);
 }
 
 /* make us init after usbcore and before usb
Index: h4/drivers/usb/musb/tusb6010.c
===================================================================
--- h4.orig/drivers/usb/musb/tusb6010.c	2007-01-09 23:45:01.000000000 -0800
+++ h4/drivers/usb/musb/tusb6010.c	2007-01-09 23:47:09.000000000 -0800
@@ -682,7 +682,7 @@ void musb_platform_disable(struct musb *
  * Sets up TUSB6010 CPU interface specific signals and registers
  * Note: Settings optimized for OMAP24xx
  */
-static void tusb_setup_cpu_interface(struct musb *musb)
+static void __init tusb_setup_cpu_interface(struct musb *musb)
 {
 	void __iomem	*base = musb->ctrl_base;
 
@@ -708,7 +708,7 @@ static void tusb_setup_cpu_interface(str
 #define TUSB_REV_MAJOR(reg_val)		((reg_val >> 4) & 0xf)
 #define TUSB_REV_MINOR(reg_val)		(reg_val & 0xf)
 
-static int tusb_print_revision(struct musb *musb)
+static int __init tusb_print_revision(struct musb *musb)
 {
 	void __iomem	*base = musb->ctrl_base;
 
@@ -729,7 +729,7 @@ static int tusb_print_revision(struct mu
 	return TUSB_REV_MAJOR(musb_readl(base, TUSB_INT_CTRL_REV));
 }
 
-static int __devinit tusb_start(struct musb *musb)
+static int __init tusb_start(struct musb *musb)
 {
 	void __iomem	*base = musb->ctrl_base;
 	int		ret = 0;
@@ -798,7 +798,7 @@ err:
 	return -ENODEV;
 }
 
-int __devinit musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
Index: h4/drivers/usb/musb/cppi_dma.c
===================================================================
--- h4.orig/drivers/usb/musb/cppi_dma.c	2007-01-09 22:24:41.000000000 -0800
+++ h4/drivers/usb/musb/cppi_dma.c	2007-01-09 23:47:53.000000000 -0800
@@ -91,7 +91,7 @@ static void cppi_reset_rx(struct cppi_rx
 	musb_writel(CAST &rx->byteCount, 0, 0);
 }
 
-static void __devinit cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
+static void __init cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
 {
 	int	j;
 
@@ -137,7 +137,7 @@ static void cppi_pool_free(struct cppi_c
 	c->lastHwBDProcessed = NULL;
 }
 
-static int __devinit cppi_controller_start(struct dma_controller *c)
+static int __init cppi_controller_start(struct dma_controller *c)
 {
 	struct cppi	*pController;
 	void		*__iomem regBase;
Index: h4/drivers/usb/musb/musb_gadget.c
===================================================================
--- h4.orig/drivers/usb/musb/musb_gadget.c	2007-01-09 23:47:08.000000000 -0800
+++ h4/drivers/usb/musb/musb_gadget.c	2007-01-09 23:48:07.000000000 -0800
@@ -1589,7 +1589,7 @@ static void musb_gadget_release(struct d
 }
 
 
-static void __devinit
+static void __init
 init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 bEnd, int is_in)
 {
 	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
@@ -1626,7 +1626,7 @@ init_peripheral_ep(struct musb *musb, st
  * Initialize the endpoints exposed to peripheral drivers, with backlinks
  * to the rest of the driver state.
  */
-static inline void __devinit musb_g_init_endpoints(struct musb *pThis)
+static inline void __init musb_g_init_endpoints(struct musb *pThis)
 {
 	u8			bEnd;
 	struct musb_hw_ep	*hw_ep;
@@ -1659,7 +1659,7 @@ static inline void __devinit musb_g_init
 /* called once during driver setup to initialize and link into
  * the driver model; memory is zeroed.
  */
-int __devinit musb_gadget_setup(struct musb *pThis)
+int __init musb_gadget_setup(struct musb *pThis)
 {
 	int status;
 
Index: h4/drivers/usb/musb/musb_procfs.c
===================================================================
--- h4.orig/drivers/usb/musb/musb_procfs.c	2007-01-09 22:24:41.000000000 -0800
+++ h4/drivers/usb/musb/musb_procfs.c	2007-01-09 23:48:12.000000000 -0800
@@ -813,7 +813,7 @@ void __devexit musb_debug_delete(char *n
 		remove_proc_entry(name, NULL);
 }
 
-struct proc_dir_entry *__devinit
+struct proc_dir_entry *__init
 musb_debug_create(char *name, struct musb *data)
 {
 	struct proc_dir_entry	*pde;
Index: h4/drivers/usb/musb/musbdefs.h
===================================================================
--- h4.orig/drivers/usb/musb/musbdefs.h	2007-01-09 23:47:09.000000000 -0800
+++ h4/drivers/usb/musb/musbdefs.h	2007-01-09 23:47:57.000000000 -0800
@@ -525,7 +525,7 @@ extern int musb_platform_get_vbus_status
 #define musb_platform_get_vbus_status(x)	0
 #endif
 
-extern int __devinit musb_platform_init(struct musb *musb);
+extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
 
 /*-------------------------- ProcFS definitions ---------------------*/
