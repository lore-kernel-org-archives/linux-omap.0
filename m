From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH resend 1/3] AM35x: Add musb support
Date: Wed, 7 Jul 2010 04:16:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03238308B1@dbde02.ent.ti.com>
References: <20100705095015.GP15951@atomide.com>
 <4C31ADCA.40607@ru.mvista.com> <20100705102322.GR15951@atomide.com>
 <4C31B54F.6040109@ru.mvista.com> <20100705104841.GS15951@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
 <20100705134552.GD15951@atomide.com> <4C31F135.5060108@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA64@dbde02.ent.ti.com>
 <20100706075707.GC3192@atomide.com> <20100706084603.GA3035@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59208 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359Ab0GFWqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 18:46:47 -0400
In-Reply-To: <20100706084603.GA3035@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Tue, Jul 06, 2010 at 09:57:09AM +0200, ext Tony Lindgren wrote:
> >Sounds like we should first fix thing before adding new code
> >that will make fixing the basic issues harder.
> 
> my idea to deal with this is to have a set of "platform glue drivers".  
> So omap2430.c, blackfin.c, tusb6010 and davinci.c would become a 
> platform driver themselves that would instantiate musb-hdrc 
> platform_driver and the correct dma driver (inventra, omap, cppi, etc).
> 
> It would look something like:
> 
> #include <plat/usb.h>
> 
> static struct musb_hdrc_ops omap2430_musb_ops = {
> 	.readb	= generic_readb,
> 	.readw	= generic_readw,
> 	.readl	= generic_readl,
> 	.writeb	= generic_writeb,
> 	.writew	= generic_writew,
> 	.writel	= generic_writel,
> };
> 
> static struct musb_platform_data omap2430_musb_data = {
> 	.ops	= &omap2430_musb_ops,
> 	.mode	= -EINVAL,	/* change it later */
> };
> 
> static int __init omap2430_musb_probe(struct platform_device *pdev)
> {
> 	struct omap24030_musb_platform_data pdata = pdev->dev.platform_data;
> 
> 	musb = platform_device_alloc("musb-hdrc", -1);
> 
> 	/* check error */
> 
> 	musb->dev.parent = &pdev->dev;
> 	omap2430_musb_data.mode = pdata->mode;
> 	/* initialize every other necessary field */
> 
> 	platform_device_add_data(musb, &omap2430_musb_data);
> 
> 	dma = platform_device_alloc("dma-inventra", -1);
> 
> 	/* check error */
> 
> 	dma->dev.parent = &pdev->dev;
> 
> 	/* add both devices */
> 
> 	return 0;
> }
> 
> static int omap2430_musb_suspend(struct platform_device *pdev,
> 			pm_message_t state)
> {
> 	return omap2430_musb_save_context(pdev);
> }
> 
> static int omap2430_musb_resume(stuct platform_device *pdev)
> {
> 	omap2430_musb_restore_context(pdev);
> }
> 
> this would allow us to factor-out save/restore context, get rid of all 
> exported functions (by just adding every necessary function to 
> musb_hdrc_ops) and compile in every single musb file in one driver and 
> still have it working. Boards would, then, just instantiate 
> musb-omap2430/musb-blackfin/musb-tusb6010/musb-davinci 
> platform_driver(s) and the rest would be done on runtime, since only the 
> driver that matches would actually probe.
> 
> How does that sound ??
> 

Like it is done in ehci-hcd.c/ohci-hcd.c?

This looks much easier to maintain.

Do you already have a patch doing this, or would you like me to spin one
for RFC/RFT?

- Anand
