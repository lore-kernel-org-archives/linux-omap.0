From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource
 structure
Date: Thu, 23 Sep 2010 12:02:15 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285201631-26266-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mike,

>-----Original Message-----
>From: Kalliguddi, Hema 
>Sent: Thursday, September 23, 2010 5:57 AM
>To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Cc: Kalliguddi, Hema; Balbi, Felipe; Tony Lindgren; Kevin 
>Hilman; Cousson, Benoit; Paul Walmsley
>Subject: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in 
>resource structure
>
>Modified the Omap,Blackfin and Davinci board files to add the 
>name of the IRQs
>in the resource structures and musb driver to use the 
>get_irq_byname() api to
>get the mc and dma irq numbers instead of using the index as 
>the order of
>resource definition need not be always in order of device interrupt and
>then dma interrupt
>
>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
>---
> arch/arm/mach-davinci/usb.c                |    2 ++
> arch/arm/mach-omap2/usb-musb.c             |    2 ++
> arch/blackfin/mach-bf527/boards/cm_bf527.c |    2 ++
> arch/blackfin/mach-bf527/boards/ezbrd.c    |    2 ++
> arch/blackfin/mach-bf527/boards/ezkit.c    |    2 ++
> arch/blackfin/mach-bf548/boards/cm_bf548.c |    2 ++
> arch/blackfin/mach-bf548/boards/ezkit.c    |    2 ++
> drivers/usb/musb/cppi_dma.c                |    2 +-
> drivers/usb/musb/musb_core.c               |    2 +-
> drivers/usb/musb/musbhsdma.c               |    2 +-
> 10 files changed, 17 insertions(+), 3 deletions(-)
>
>Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>+++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>@@ -64,10 +64,12 @@ static struct resource usb_resources[] =
> 	{
> 		.start          = IRQ_USBINT,
> 		.flags          = IORESOURCE_IRQ,
>+		.name		= "mc"
> 	},
> 	{
> 		/* placeholder for the dedicated CPPI IRQ */
> 		.flags          = IORESOURCE_IRQ,
>+		.name		= "dma"
> 	},
> };
> 
>Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
>+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>@@ -39,10 +39,12 @@ static struct resource musb_resources[] 
> 	[1] = {	/* general IRQ */
> 		.start	= INT_243X_HS_USB_MC,
> 		.flags	= IORESOURCE_IRQ,
>+		.name	= "mc",
> 	},
> 	[2] = {	/* DMA IRQ */
> 		.start	= INT_243X_HS_USB_DMA,
> 		.flags	= IORESOURCE_IRQ,
>+		.name	= "dma",
> 	},
> };
> 
>Index: linux-omap-pm/arch/blackfin/mach-bf527/boards/cm_bf527.c
>===================================================================
>--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/cm_bf527.c
>+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/cm_bf527.c
>@@ -82,11 +82,13 @@ static struct resource musb_resources[] 
> 		.start	= IRQ_USB_INT0,
> 		.end	= IRQ_USB_INT0,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "mc"
> 	},
> 	[2] = {	/* DMA IRQ */
> 		.start	= IRQ_USB_DMA,
> 		.end	= IRQ_USB_DMA,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "dma"
> 	},
> };
> 
>Index: linux-omap-pm/arch/blackfin/mach-bf527/boards/ezbrd.c
>===================================================================
>--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/ezbrd.c
>+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/ezbrd.c
>@@ -46,11 +46,13 @@ static struct resource musb_resources[] 
> 		.start	= IRQ_USB_INT0,
> 		.end	= IRQ_USB_INT0,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "mc"
> 	},
> 	[2] = {	/* DMA IRQ */
> 		.start	= IRQ_USB_DMA,
> 		.end	= IRQ_USB_DMA,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "dma"
> 	},
> };
> 
>Index: linux-omap-pm/arch/blackfin/mach-bf527/boards/ezkit.c
>===================================================================
>--- linux-omap-pm.orig/arch/blackfin/mach-bf527/boards/ezkit.c
>+++ linux-omap-pm/arch/blackfin/mach-bf527/boards/ezkit.c
>@@ -86,11 +86,13 @@ static struct resource musb_resources[] 
> 		.start	= IRQ_USB_INT0,
> 		.end	= IRQ_USB_INT0,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "mc"
> 	},
> 	[2] = {	/* DMA IRQ */
> 		.start	= IRQ_USB_DMA,
> 		.end	= IRQ_USB_DMA,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "dma"
> 	},
> };
> 
>Index: linux-omap-pm/arch/blackfin/mach-bf548/boards/cm_bf548.c
>===================================================================
>--- linux-omap-pm.orig/arch/blackfin/mach-bf548/boards/cm_bf548.c
>+++ linux-omap-pm/arch/blackfin/mach-bf548/boards/cm_bf548.c
>@@ -482,11 +482,13 @@ static struct resource musb_resources[] 
> 		.start	= IRQ_USB_INT0,
> 		.end	= IRQ_USB_INT0,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "mc"
> 	},
> 	[2] = {	/* DMA IRQ */
> 		.start	= IRQ_USB_DMA,
> 		.end	= IRQ_USB_DMA,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "dma"
> 	},
> };
> 
>Index: linux-omap-pm/arch/blackfin/mach-bf548/boards/ezkit.c
>===================================================================
>--- linux-omap-pm.orig/arch/blackfin/mach-bf548/boards/ezkit.c
>+++ linux-omap-pm/arch/blackfin/mach-bf548/boards/ezkit.c
>@@ -587,11 +587,13 @@ static struct resource musb_resources[] 
> 		.start	= IRQ_USB_INT0,
> 		.end	= IRQ_USB_INT0,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "mc"
> 	},
> 	[2] = {	/* DMA IRQ */
> 		.start	= IRQ_USB_DMA,
> 		.end	= IRQ_USB_DMA,
> 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
>+		.name	= "dma"
> 	},
> };
> 
>Index: linux-omap-pm/drivers/usb/musb/cppi_dma.c
>===================================================================
>--- linux-omap-pm.orig/drivers/usb/musb/cppi_dma.c
>+++ linux-omap-pm/drivers/usb/musb/cppi_dma.c
>@@ -1307,7 +1307,7 @@ dma_controller_create(struct musb *musb,
> 	struct cppi		*controller;
> 	struct device		*dev = musb->controller;
> 	struct platform_device	*pdev = to_platform_device(dev);
>-	int			irq = platform_get_irq(pdev, 1);
>+	int			irq = 
>platform_get_irq_byname(pdev, "dma");
> 
> 	controller = kzalloc(sizeof *controller, GFP_KERNEL);
> 	if (!controller)
>Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>===================================================================
>--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
>+++ linux-omap-pm/drivers/usb/musb/musb_core.c
>@@ -2203,7 +2203,7 @@ static u64	*orig_dma_mask;
> static int __init musb_probe(struct platform_device *pdev)
> {
> 	struct device	*dev = &pdev->dev;
>-	int		irq = platform_get_irq(pdev, 0);
>+	int		irq = platform_get_irq_byname(pdev, "mc");
> 	int		status;
> 	struct resource	*iomem;
> 	void __iomem	*base;
>Index: linux-omap-pm/drivers/usb/musb/musbhsdma.c
>===================================================================
>--- linux-omap-pm.orig/drivers/usb/musb/musbhsdma.c
>+++ linux-omap-pm/drivers/usb/musb/musbhsdma.c
>@@ -363,7 +363,7 @@ dma_controller_create(struct musb *musb,
> 	struct musb_dma_controller *controller;
> 	struct device *dev = musb->controller;
> 	struct platform_device *pdev = to_platform_device(dev);
>-	int irq = platform_get_irq(pdev, 1);
>+	int irq = platform_get_irq_byname(pdev, "dma");
> 
> 	if (irq == 0) {
> 		dev_err(dev, "No DMA interrupt line!\n");
>

I am sorry I forgot to Cc you when I posted the patch. Please provide your comments on the changes.

Regards,
Hema



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
