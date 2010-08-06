From: Hema HK <hemahk@ti.com>
Subject: [PATCH 1/8] usb: musb: Adding names for IRQs in resource structure
Date: Fri,  6 Aug 2010 21:25:24 +0530
Message-ID: <1281110124-3186-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36337 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab0HFPzf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 11:55:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK  <hemahk@ti.com>

Modified the Omap,Blackfin and Davinci board files to add the name of the IRQs
in the resource structures and musb driver to use the get_irq_byname() api to
get the mc and dma irq numbers instead of using the index as the order of
resource definition need not be always in order of device interrupt and 
then dma interrupt

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
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
--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c	2010-08-06 09:01:23.605862579 -0400
+++ linux-omap-pm/arch/arm/mach-davinci/usb.c	2010-08-06 09:01:25.526112352 -0400
@@ -64,10 +64,12 @@
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
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c	2010-08-06 09:01:23.613862415 -0400
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c	2010-08-06 09:01:25.526112352 -0400
@@ -39,10 +39,12 @@
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
--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/cm_bf527.c	2010-08-06 09:01:23.645862783 -0400
+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/cm_bf527.c	2010-08-06 09:01:25.526112352 -0400
@@ -82,11 +82,13 @@
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
--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/ezbrd.c	2010-08-06 09:01:23.637862922 -0400
+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/ezbrd.c	2010-08-06 09:01:25.526112352 -0400
@@ -46,11 +46,13 @@
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
--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/ezkit.c	2010-08-06 09:01:23.653862977 -0400
+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/ezkit.c	2010-08-06 09:01:25.526112352 -0400
@@ -86,11 +86,13 @@
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
--- linux-omap-pm.orig/arch/blackfin/mach-bf548/boards/cm_bf548.c	2010-08-06 09:01:23.625864028 -0400
+++ linux-omap-pm/arch/blackfin/mach-bf548/boards/cm_bf548.c	2010-08-06 09:01:25.526112352 -0400
@@ -482,11 +482,13 @@
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
--- linux-omap-pm.orig/arch/blackfin/mach-bf548/boards/ezkit.c	2010-08-06 09:01:23.629863856 -0400
+++ linux-omap-pm/arch/blackfin/mach-bf548/boards/ezkit.c	2010-08-06 09:01:25.530112841 -0400
@@ -587,11 +587,13 @@
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
--- linux-omap-pm.orig/drivers/usb/musb/cppi_dma.c	2010-08-06 09:01:23.589863406 -0400
+++ linux-omap-pm/drivers/usb/musb/cppi_dma.c	2010-08-06 09:01:25.530112841 -0400
@@ -1307,7 +1307,7 @@
 	struct cppi		*controller;
 	struct device		*dev = musb->controller;
 	struct platform_device	*pdev = to_platform_device(dev);
-	int			irq = platform_get_irq(pdev, 1);
+	int			irq = platform_get_irq_byname(pdev, "dma");
 
 	controller = kzalloc(sizeof *controller, GFP_KERNEL);
 	if (!controller)
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c	2010-08-06 09:01:23.585862534 -0400
+++ linux-omap-pm/drivers/usb/musb/musb_core.c	2010-08-06 09:01:25.530112841 -0400
@@ -2204,7 +2204,7 @@
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
--- linux-omap-pm.orig/drivers/usb/musb/musbhsdma.c	2010-08-06 09:01:23.597862505 -0400
+++ linux-omap-pm/drivers/usb/musb/musbhsdma.c	2010-08-06 09:01:25.530112841 -0400
@@ -366,7 +366,7 @@
 	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev);
-	int irq = platform_get_irq(pdev, 1);
+	int irq = platform_get_irq_byname(pdev, "dma");
 
 	if (irq == 0) {
 		dev_err(dev, "No DMA interrupt line!\n");
