From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/9 v3] usb: musb: Using omap_device_build for musb
 device registration
Date: Thu, 23 Sep 2010 09:20:44 +0300
Message-ID: <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
References: <1285201750-26438-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285201750-26438-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 22, 2010 at 07:29:10PM -0500, Kalliguddi, Hema wrote:
>+#define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16

this isn't used anywhere.

>@@ -75,31 +62,30 @@ static struct musb_hdrc_platform_data mu
>
> static u64 musb_dmamask = DMA_BIT_MASK(32);
>
>-static struct platform_device musb_device = {
>-	.name		= "musb_hdrc",
>-	.id		= -1,
>-	.dev = {
>-		.dma_mask		= &musb_dmamask,
>-		.coherent_dma_mask	= DMA_BIT_MASK(32),
>-		.platform_data		= &musb_plat,
>+static struct omap_device_pm_latency omap_musb_latency[] = {
>+	{
>+		.deactivate_func = omap_device_idle_hwmods,
>+		.activate_func   = omap_device_enable_hwmods,
>+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> 	},
>-	.num_resources	= ARRAY_SIZE(musb_resources),
>-	.resource	= musb_resources,
> };
>
> void __init usb_musb_init(struct omap_musb_board_data *board_data)
> {
>-	if (cpu_is_omap243x()) {
>-		musb_resources[0].start = OMAP243X_HS_BASE;
>-	} else if (cpu_is_omap34xx()) {
>-		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
>-	} else if (cpu_is_omap44xx()) {
>-		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
>-		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
>-		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
>+	struct omap_hwmod *oh;
>+	struct omap_device *od;
>+	struct platform_device *pdev;
>+	struct device	*dev;
>+	int bus_id = -1;
>+	const char *oh_name = "usb_otg_hs";
>+	struct musb_hdrc_platform_data *pdata;
>+
>+	oh = omap_hwmod_lookup(oh_name);
>+
>+	if (!oh) {
>+		pr_err("Could not look up %s\n", oh_name);
>+		return;
> 	}

Paul, Kevin, to me it looks like a duplication that all devices will
have to:

oh = omap_hwmod_lookup("my_hwmod_name");
omap_device_build("my_device_name", bus_id, oh, pdata, sizeof(*pdata));

could the omap_hwmod_lookup() part be moved to omap_device_build ? Or
maybe create a omap_hwmod_lookup_and_build(oh_name, dev_name, bus_id,
pdata, sizeof(*pdata)) ??

>@@ -110,8 +96,23 @@ void __init usb_musb_init(struct omap_mu
> 	musb_plat.mode = board_data->mode;
> 	musb_plat.extvbus = board_data->extvbus;
>
>-	if (platform_device_register(&musb_device) < 0)
>-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
>+	pdata = &musb_plat;
>+
>+	od = omap_device_build(name, bus_id, oh, pdata,
>+			       sizeof(struct musb_hdrc_platform_data),

use sizeof(*pdata), if we change the name of that structure (very
unlikely, but still) it'll avoid unwanted compile breakage.

>+	pdev = &od->pdev;
>+	dev = &pdev->dev;
>+	get_device(dev);
>+	dev->dma_mask = &musb_dmamask;
>+	dev->coherent_dma_mask = musb_dmamask;
>+	put_device(dev);

I think this is also a duplication, it's gonna on all hwmod device
registration, no ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
