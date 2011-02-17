From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/6 v8] OMAP2+: musb: hwmod adaptation for musb
 registration
Date: Thu, 17 Feb 2011 13:53:33 +0200
Message-ID: <20110217115332.GB22356@legolas.emea.dhcp.ti.com>
References: <1297924642-3791-1-git-send-email-hemahk@ti.com>
 <1297924642-3791-6-git-send-email-hemahk@ti.com>
 <20110217113321.GA22356@legolas.emea.dhcp.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110217113321.GA22356-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Feb 17, 2011 at 01:33:21PM +0200, Felipe Balbi wrote:
> On Thu, Feb 17, 2011 at 12:07:21PM +0530, Hema HK wrote:
> > Using omap_device_build API instead of platform_device_register for
> > OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
> > The device specific resources defined in centralized
> > database will be used.
> > 
> > Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> > Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> > Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> > Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> 
> doesn't apply:
> 
> OMAP2+: musb: hwmod adaptation for musb registration
> 
> Using omap_device_build API instead of platform_device_register for
> OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
> The device specific resources defined in centralized
> database will be used.
> 
> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> --------------------------
> Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y
> Applying: OMAP2+: musb: hwmod adaptation for musb registration
> error: patch failed: arch/arm/mach-omap2/usb-musb.c:30
> error: arch/arm/mach-omap2/usb-musb.c: patch does not apply
> Patch failed at 0005 OMAP2+: musb: hwmod adaptation for musb registration
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".

I fixed this one by hand, patch attached. Check if I fixed correctly.
Patch attached.

-- 
balbi

--3MwIy2ne0vdjdPXF
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-OMAP2-musb-hwmod-adaptation-for-musb-registration.diff"

>From 76ad3bd54b53b36c908acddc603a4f1aa2ef45ab Mon Sep 17 00:00:00 2001
From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Date: Thu, 17 Feb 2011 12:07:21 +0530
Subject: [PATCH] OMAP2+: musb: hwmod adaptation for musb registration
Organization: Texas Instruments\n

Using omap_device_build API instead of platform_device_register for
OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
The device specific resources defined in centralized
database will be used.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-musb.c |   84 +++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 5a82b43..b089ea4 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -30,6 +30,7 @@
 #include <mach/irqs.h>
 #include <mach/am35xx.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
 #include "control.h"
 #include "mux.h"
 
@@ -127,22 +128,6 @@ static void am35x_musb_set_mode(u8 musb_mode)
 	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 }
 
-static struct resource musb_resources[] = {
-	[0] = { /* start and end set dynamically */
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {	/* general IRQ */
-		.start	= INT_243X_HS_USB_MC,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "mc",
-	},
-	[2] = {	/* DMA IRQ */
-		.start	= INT_243X_HS_USB_DMA,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "dma",
-	},
-};
-
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
@@ -170,16 +155,12 @@ static struct musb_hdrc_platform_data musb_plat = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device musb_device = {
-	.name		= "musb-omap2430",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &musb_plat,
+static struct omap_device_pm_latency omap_musb_latency[] = {
+	{
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
-	.num_resources	= ARRAY_SIZE(musb_resources),
-	.resource	= musb_resources,
 };
 
 static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
@@ -219,28 +200,24 @@ static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
 		break;
 	}
 }
+
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
-	if (cpu_is_omap243x()) {
-		musb_resources[0].start = OMAP243X_HS_BASE;
-	} else if (cpu_is_omap3517() || cpu_is_omap3505()) {
-		musb_device.name = "musb-am35x";
-		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
-		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
+	struct omap_hwmod		*oh;
+	struct omap_device		*od;
+	struct platform_device		*pdev;
+	struct device			*dev;
+	int				bus_id = -1;
+	const char			*oh_name, *name;
+
+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		board_data->set_phy_power = am35x_musb_phy_power;
 		board_data->clear_irq = am35x_musb_clear_irq;
 		board_data->set_mode = am35x_musb_set_mode;
 		board_data->reset = am35x_musb_reset;
-	} else if (cpu_is_omap34xx()) {
-		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	} else if (cpu_is_omap44xx()) {
-		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
-		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
-		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
-
 		usb_musb_mux_init(board_data);
 	}
-	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
@@ -252,8 +229,35 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
+		oh_name = "am35x_otg_hs";
+		name = "musb-am35x";
+	} else {
+		oh_name = "usb_otg_hs";
+		name = "musb-omap2430";
+	}
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
+	}
+
+	od = omap_device_build(name, bus_id, oh, &musb_plat,
+			       sizeof(musb_plat), omap_musb_latency,
+			       ARRAY_SIZE(omap_musb_latency), false);
+	if (IS_ERR(od)) {
+		pr_err("Could not build omap_device for %s %s\n",
+						name, oh_name);
+		return;
+	}
+
+	pdev = &od->pdev;
+	dev = &pdev->dev;
+	get_device(dev);
+	dev->dma_mask = &musb_dmamask;
+	dev->coherent_dma_mask = musb_dmamask;
+	put_device(dev);
 }
 
 #else
-- 
1.7.4.rc2


--3MwIy2ne0vdjdPXF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
