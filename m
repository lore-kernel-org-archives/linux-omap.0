From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] usb: musb: Adding names for IRQs in resource structure
Date: Mon, 28 Jun 2010 17:41:14 +0530
Message-ID: <1277727074-5535-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>

Modified the Omap,Blackfin and Davinci board files to add the name of the IRQs
in the resource structures and musb driver to use the get_irq_byname() api to
get the mc and dma irq numbers instead of using the index as the order of
resource definition need not be always in order of device interrupt and 
then dma interrupt

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
---

Based off  omap4-next branch.

 arch/arm/mach-davinci/usb.c                |    2 ++
 arch/arm/mach-omap2/usb-musb.c             |    2 ++
 arch/blackfin/mach-bf527/boards/cm_bf527.c |    2 ++
 arch/blackfin/mach-bf527/boards/ezbrd.c    |    2 ++
 arch/blackfin/mach-bf527/boards/ezkit.c    |    2 ++
 arch/blackfin/mach-bf548/boards/cm_bf548.c |    2 ++
 arch/blackfin/mach-bf548/boards/ezkit.c    |    2 ++
 drivers/usb/musb/cppi_dma.c                |    2 +-
 drivers/usb/musb/musb_core.c               |    2 +-
 drivers/usb/musb/musbhsdma.c               |    2 +-
 10 files changed, 17 insertions(+), 3 deletions(-)

Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
+++ linux-omap-pm/arch/arm/mach-davinci/usb.c
@@ -64,10 +64,12 @@ static struct resource usb_resources[] =
 	{
 		.start          = IRQ_USBINT,
 		.flags          = IORESOURCE_IRQ,
+		.name		= "mc"
 	},
 	{
 		/* placeholder for the dedicated CPPI IRQ */
 		.flags          = IORESOURCE_IRQ,
+		.name		= "dma"
 	},
 };
 
Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
@@ -40,10 +40,12 @@ static struct resource musb_resources[] 
 	[1] = {	/* general IRQ */
 		.start	= INT_243X_HS_USB_MC,
 		.flags	= IORESOURCE_IRQ,
+		.name	= "mc",
 	},
 	[2] = {	/* DMA IRQ */
 		.start	= INT_243X_HS_USB_DMA,
 		.flags	= IORESOURCE_IRQ,
+		.name	= "dma",
 	},
 };
 
Index: linux-omap-pm/arch/blackfin/mach-bf527/boards/cm_bf527.c
===================================================================
--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/cm_bf527.c
+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/cm_bf527.c
@@ -82,11 +82,13 @@ static struct resource musb_resources[] 
 		.start	= IRQ_USB_INT0,
 		.end	= IRQ_USB_INT0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "mc"
 	},
 	[2] = {	/* DMA IRQ */
 		.start	= IRQ_USB_DMA,
 		.end	= IRQ_USB_DMA,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "dma"
 	},
 };
 
Index: linux-omap-pm/arch/blackfin/mach-bf527/boards/ezbrd.c
===================================================================
--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/ezbrd.c
+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/ezbrd.c
@@ -46,11 +46,13 @@ static struct resource musb_resources[] 
 		.start	= IRQ_USB_INT0,
 		.end	= IRQ_USB_INT0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "mc"
 	},
 	[2] = {	/* DMA IRQ */
 		.start	= IRQ_USB_DMA,
 		.end	= IRQ_USB_DMA,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "dma"
 	},
 };
 
Index: linux-omap-pm/arch/blackfin/mach-bf527/boards/ezkit.c
===================================================================
--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/ezkit.c
+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -86,11 +86,13 @@ static struct resource musb_resources[] 
 		.start	= IRQ_USB_INT0,
 		.end	= IRQ_USB_INT0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "mc"
 	},
 	[2] = {	/* DMA IRQ */
 		.start	= IRQ_USB_DMA,
 		.end	= IRQ_USB_DMA,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "dma"
 	},
 };
 
Index: linux-omap-pm/arch/blackfin/mach-bf548/boards/cm_bf548.c
===================================================================
--- linux-omap-pm.orig/arch/blackfin/mach-bf548/boards/cm_bf548.c
+++ linux-omap-pm/arch/blackfin/mach-bf548/boards/cm_bf548.c
@@ -482,11 +482,13 @@ static struct resource musb_resources[] 
 		.start	= IRQ_USB_INT0,
 		.end	= IRQ_USB_INT0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "mc"
 	},
 	[2] = {	/* DMA IRQ */
 		.start	= IRQ_USB_DMA,
 		.end	= IRQ_USB_DMA,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "dma"
 	},
 };
 
Index: linux-omap-pm/arch/blackfin/mach-bf548/boards/ezkit.c
===================================================================
--- linux-omap-pm.orig/arch/blackfin/mach-bf548/boards/ezkit.c
+++ linux-omap-pm/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -587,11 +587,13 @@ static struct resource musb_resources[] 
 		.start	= IRQ_USB_INT0,
 		.end	= IRQ_USB_INT0,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "mc"
 	},
 	[2] = {	/* DMA IRQ */
 		.start	= IRQ_USB_DMA,
 		.end	= IRQ_USB_DMA,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+		.name	= "dma"
 	},
 };
 
Index: linux-omap-pm/drivers/usb/musb/cppi_dma.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/cppi_dma.c
+++ linux-omap-pm/drivers/usb/musb/cppi_dma.c
@@ -1307,7 +1307,7 @@ dma_controller_create(struct musb *musb,
 	struct cppi		*controller;
 	struct device		*dev = musb->controller;
 	struct platform_device	*pdev = to_platform_device(dev);
-	int			irq = platform_get_irq(pdev, 1);
+	int			irq = platform_get_irq_byname(pdev, "dma");
 
 	controller = kzalloc(sizeof *controller, GFP_KERNEL);
 	if (!controller)
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
+++ linux-omap-pm/drivers/usb/musb/musb_core.c
@@ -2207,7 +2207,7 @@ static u64	*orig_dma_mask;
 static int __init musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
-	int		irq = platform_get_irq(pdev, 0);
+	int		irq = platform_get_irq_byname(pdev, "mc");
 	int		status;
 	struct resource	*iomem;
 	void __iomem	*base;
Index: linux-omap-pm/drivers/usb/musb/musbhsdma.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musbhsdma.c
+++ linux-omap-pm/drivers/usb/musb/musbhsdma.c
@@ -375,7 +375,7 @@ dma_controller_create(struct musb *musb,
 	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev);
-	int irq = platform_get_irq(pdev, 1);
+	int irq = platform_get_irq_byname(pdev, "dma");
 
 	if (irq == 0) {
 		dev_err(dev, "No DMA interrupt line!\n");
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
