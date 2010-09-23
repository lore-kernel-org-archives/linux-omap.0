From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 5/9 v3] usb: musb: Using omap_device_build for musb
 device registration
Date: Thu, 23 Sep 2010 12:16:51 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D978@dbde02.ent.ti.com>
References: <1285201750-26438-1-git-send-email-hemahk@ti.com>
 <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38912 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967Ab0IWGq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 02:46:59 -0400
In-Reply-To: <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi, 

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Thursday, September 23, 2010 11:51 AM
>To: Kalliguddi, Hema
>Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; 
>Balbi, Felipe; Tony Lindgren; Kevin Hilman; Cousson, Benoit; 
>Paul Walmsley
>Subject: Re: [PATCH 5/9 v3] usb: musb: Using omap_device_build 
>for musb device registration
>
>Hi,
>
>On Wed, Sep 22, 2010 at 07:29:10PM -0500, Kalliguddi, Hema wrote:
>>+#define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
>
>this isn't used anywhere.
>
>>@@ -75,31 +62,30 @@ static struct musb_hdrc_platform_data mu
>>
>> static u64 musb_dmamask = DMA_BIT_MASK(32);
>>
>>-static struct platform_device musb_device = {
>>-	.name		= "musb_hdrc",
>>-	.id		= -1,
>>-	.dev = {
>>-		.dma_mask		= &musb_dmamask,
>>-		.coherent_dma_mask	= DMA_BIT_MASK(32),
>>-		.platform_data		= &musb_plat,
>>+static struct omap_device_pm_latency omap_musb_latency[] = {
>>+	{
>>+		.deactivate_func = omap_device_idle_hwmods,
>>+		.activate_func   = omap_device_enable_hwmods,
>>+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>> 	},
>>-	.num_resources	= ARRAY_SIZE(musb_resources),
>>-	.resource	= musb_resources,
>> };
>>
>> void __init usb_musb_init(struct omap_musb_board_data *board_data)
>> {
>>-	if (cpu_is_omap243x()) {
>>-		musb_resources[0].start = OMAP243X_HS_BASE;
>>-	} else if (cpu_is_omap34xx()) {
>>-		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
>>-	} else if (cpu_is_omap44xx()) {
>>-		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
>>-		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
>>-		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
>>+	struct omap_hwmod *oh;
>>+	struct omap_device *od;
>>+	struct platform_device *pdev;
>>+	struct device	*dev;
>>+	int bus_id = -1;
>>+	const char *oh_name = "usb_otg_hs";
>>+	struct musb_hdrc_platform_data *pdata;
>>+
>>+	oh = omap_hwmod_lookup(oh_name);
>>+
>>+	if (!oh) {
>>+		pr_err("Could not look up %s\n", oh_name);
>>+		return;
>> 	}
>
>Paul, Kevin, to me it looks like a duplication that all devices will
>have to:
>
>oh = omap_hwmod_lookup("my_hwmod_name");
>omap_device_build("my_device_name", bus_id, oh, pdata, sizeof(*pdata));
>
>could the omap_hwmod_lookup() part be moved to omap_device_build ? Or
>maybe create a omap_hwmod_lookup_and_build(oh_name, dev_name, bus_id,
>pdata, sizeof(*pdata)) ??

>>@@ -110,8 +96,23 @@ void __init usb_musb_init(struct omap_mu
>> 	musb_plat.mode = board_data->mode;
>> 	musb_plat.extvbus = board_data->extvbus;
>>
>>-	if (platform_device_register(&musb_device) < 0)
>>-		printk(KERN_ERR "Unable to register HS-USB 
>(MUSB) device\n");
>>+	pdata = &musb_plat;
>>+
>>+	od = omap_device_build(name, bus_id, oh, pdata,
>>+			       sizeof(struct musb_hdrc_platform_data),
>
>use sizeof(*pdata), if we change the name of that structure (very
>unlikely, but still) it'll avoid unwanted compile breakage.
>
Ok. Make sense.

>>+	pdev = &od->pdev;
>>+	dev = &pdev->dev;
>>+	get_device(dev);
>>+	dev->dma_mask = &musb_dmamask;
>>+	dev->coherent_dma_mask = musb_dmamask;
>>+	put_device(dev);
>
>I think this is also a duplication, it's gonna on all hwmod device
>registration, no ?

Any driver which uses the device->dma_mask will have to it after the device build.
~Hema
>
>-- 
>balbi
>