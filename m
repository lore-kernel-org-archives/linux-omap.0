From: Hema HK <hemahk@ti.com>
Subject: [PATCH 1/8 v2] usb: musb: Adding names for IRQs in resource structure
Date: Wed, 18 Aug 2010 19:34:52 +0530
Message-ID: <1282140292-28468-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54311 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827Ab0HROFE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 10:05:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Modified the Omap,Blackfin and Davinci board files to add the name of the IRQs
in the resource structures and musb driver to use the get_irq_byname() api to
get the mc and dma irq numbers instead of using the index as the order of
resource definition need not be always in order of device interrupt and
then dma interrupt

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
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

diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 31f0cbe..b0d6b07 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -64,10 +64,12 @@ static struct resource usb_resources[] = {
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
 
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 33a5cde..1b7aa70 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -39,10 +39,12 @@ static struct resource musb_resources[] = {
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
 
diff --git a/arch/blackfin/mach-bf527/boards/cm_bf527.c b/arch/blackfin/mach-bf527/boards/cm_bf527.c
index f392af6..a8f840a 100644
--- a/arch/blackfin/mach-bf527/boards/cm_bf527.c
+++ b/arch/blackfin/mach-bf527/boards/cm_bf527.c
@@ -82,11 +82,13 @@ static struct resource musb_resources[] = {
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
 
diff --git a/arch/blackfin/mach-bf527/boards/ezbrd.c b/arch/blackfin/mach-bf527/boards/ezbrd.c
index 606eb36..be6d415 100644
--- a/arch/blackfin/mach-bf527/boards/ezbrd.c
+++ b/arch/blackfin/mach-bf527/boards/ezbrd.c
@@ -46,11 +46,13 @@ static struct resource musb_resources[] = {
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
 
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index a05c967..4125335 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -86,11 +86,13 @@ static struct resource musb_resources[] = {
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
 
diff --git a/arch/blackfin/mach-bf548/boards/cm_bf548.c b/arch/blackfin/mach-bf548/boards/cm_bf548.c
index dbb6b1d..0f2ddc3 100644
--- a/arch/blackfin/mach-bf548/boards/cm_bf548.c
+++ b/arch/blackfin/mach-bf548/boards/cm_bf548.c
@@ -482,11 +482,13 @@ static struct resource musb_resources[] = {
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
 
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 6fcfb91..30b929d 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -587,11 +587,13 @@ static struct resource musb_resources[] = {
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
 
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 59dc3d3..82bf59b 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1307,7 +1307,7 @@ dma_controller_create(struct musb *musb, void __iomem *mregs)
 	struct cppi		*controller;
 	struct device		*dev = musb->controller;
 	struct platform_device	*pdev = to_platform_device(dev);
-	int			irq = platform_get_irq(pdev, 1);
+	int			irq = platform_get_irq_byname(pdev, "dma");
 
 	controller = kzalloc(sizeof *controller, GFP_KERNEL);
 	if (!controller)
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3b795c5..447ea9b 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2204,7 +2204,7 @@ static u64	*orig_dma_mask;
 static int __init musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
-	int		irq = platform_get_irq(pdev, 0);
+	int		irq = platform_get_irq_byname(pdev, "mc");
 	int		status;
 	struct resource	*iomem;
 	void __iomem	*base;
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index dc66e43..50bc9aa 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -366,7 +366,7 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev);
-	int irq = platform_get_irq(pdev, 1);
+	int irq = platform_get_irq_byname(pdev, "dma");
 
 	if (irq == 0) {
 		dev_err(dev, "No DMA interrupt line!\n");
-- 
1.7.0.4

