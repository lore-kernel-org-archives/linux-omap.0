From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Tue, 6 Jul 2010 12:51:38 +0300
Message-ID: <20100706095134.GF3192@atomide.com>
References: <4C31ADCA.40607@ru.mvista.com>
 <20100705102322.GR15951@atomide.com>
 <4C31B54F.6040109@ru.mvista.com>
 <20100705104841.GS15951@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
 <20100705134552.GD15951@atomide.com>
 <4C31F135.5060108@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA64@dbde02.ent.ti.com>
 <20100706075707.GC3192@atomide.com>
 <20100706084603.GA3035@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100706084603.GA3035-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [100706 11:40]:
> Hi,
> 
> On Tue, Jul 06, 2010 at 09:57:09AM +0200, ext Tony Lindgren wrote:
> >Sounds like we should first fix thing before adding new code
> >that will make fixing the basic issues harder.
> 
> my idea to deal with this is to have a set of "platform glue
> drivers".  So omap2430.c, blackfin.c, tusb6010 and davinci.c would
> become a platform driver themselves that would instantiate musb-hdrc
> platform_driver and the correct dma driver (inventra, omap, cppi,
> etc).
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
> this would allow us to factor-out save/restore context, get rid of
> all exported functions (by just adding every necessary function to
> musb_hdrc_ops) and compile in every single musb file in one driver
> and still have it working. Boards would, then, just instantiate
> musb-omap2430/musb-blackfin/musb-tusb6010/musb-davinci
> platform_driver(s) and the rest would be done on runtime, since only
> the driver that matches would actually probe.
> 
> How does that sound ??

That sounds good to me! It would be nice to have usable musb with
soon-to-be-gone omap3_defconfig :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
