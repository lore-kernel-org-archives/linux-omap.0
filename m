From: Philippe De Swert <philippe.deswert@jollamobile.com>
Subject: RE: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Wed, 3 Oct 2012 13:45:33 +0000
Message-ID: <02DC685EFE4B1942A41870A0F2608047A6570C@ORD2MBX02B.mex05.mlsrvr.com>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
	<20120924121538.GH2892@arwen.pp.htv.fi>
	<CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
	<20120924130216.GA5603@arwen.pp.htv.fi>	<20120924160914.GB28835@atomide.com>
	<20120925080420.GH9137@arwen.pp.htv.fi>
	<CAPsFW+T_ezWAxO9StSf9cu9nJ6Gw8T9Dk1H3g6+bwJ-PKtn-cQ@mail.gmail.com>,<CAPe0uWoX92e6Hbazji+s9DPiZnfxqE=a=5Hnu39SrD6qZnRWzg@mail.gmail.com>,<02DC685EFE4B1942A41870A0F2608047A65157@ORD2MBX02B.mex05.mlsrvr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp150.dfw.emailsrvr.com ([67.192.241.150]:49406 "EHLO
	smtp150.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab2JCNqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 09:46:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 2F5B12D05D3
	for <linux-omap@vger.kernel.org>; Wed,  3 Oct 2012 09:46:17 -0400 (EDT)
Received: from smtp136.ord.emailsrvr.com (smtp136.ord.emailsrvr.com [173.203.6.136])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id CC1932D01FC
	for <linux-omap@vger.kernel.org>; Wed,  3 Oct 2012 09:46:15 -0400 (EDT)
In-Reply-To: <02DC685EFE4B1942A41870A0F2608047A65157@ORD2MBX02B.mex05.mlsrvr.com>
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "praveen.nadahally@stericsson.com" <praveen.nadahally@stericsson.com>, Philippe De Swert <philippedeswert@gmail.com>
Cc: "balbi@ti.com" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>, "kishon@ti.com" <kishon@ti.com>, "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "leoli@freescale.com" <leoli@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shubhrajyoti@ti.com" <shubhrajyoti@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>, "vikram.pandita@ti.com" <vikram.pandita@ti.com>, "ravibabu@ti.com" <ravibabu@ti.com>, "mina86@mina86.com" <mina86@mina86.com>, "mian.yousaf.kaukab@stericsson.com" <mian.yousaf.kaukab@stericsson.com>

Hi all,

On 26/09/2012, Philippe De Swert <philippe.deswert@jollamobile.com> wrote:
> Hi,
> ________________________________________
>>On Tue, Sep 25, 2012 at 2:39 PM, Philippe De Swert
>>>> Then maybe it's best to just remove the ifdefs and always provide
>>>> generic_interrupt() ?
>>>>
>>>> Anyone against it ?
>>
>>Providing generic_interrupt seems fine.
>>
>>> Well it seems there are only two drivers that use it omap2430 and
>>> ux500. Maybe we somehow link it to the drivers that need it? (I might
>>> have missed other drivers but it looks like it is just those two)
>>
>>One way I see is that omap2430 and ux500 implement the isr handler
>>in platform glue driver and then call the musb_interrupt() as done in
>>daxxx, amxxx, ti8xxx platforms. Then generic_interrupt can be removed.
> 
> So something along those lines? (If this is the right way I will resend as a
> real patch)

So any comments on the approach here (see patch kept below)? Or should I immediately send it as a new patch to get the comments? I sent it in this thread as it also solves the issue I have. 

BTW: CONFIG_SOC_OMAP3430 could be easily removed as it only changes minor things in the musb stack. It would clean up the code and get rid of this very misleading option as it has nothing to do with any OMAP3430 soc specific handling.

Regards,

Philippe

 
> From deae78e1084749f340ae8b8aaeca51818d5bfc55 Mon Sep 17 00:00:00 2001
> From: Philippe De Swert <philippe.deswert@jollamobile.com>
> Date: Wed, 26 Sep 2012 17:00:46 +0300
> Subject: [PATCH 1/1] musb: Move generic_interrupt out of the way
> 
> Have all musb drivers define their own isr.
> 
> Signed-off-by: Philippe De Swert <philippe.deswert@jollamobile.com>
> ---
>  drivers/usb/musb/musb_core.c |   33 ++-------------------------------
>  drivers/usb/musb/omap2430.c  |   22 ++++++++++++++++++++++
>  drivers/usb/musb/ux500.c     |   21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 26f1bef..1d5ee34 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1496,35 +1496,6 @@ static int __devinit musb_core_init(u16 musb_type,
> struct musb *musb)
>  	return 0;
>  }
>  
> -/*-------------------------------------------------------------------------*/
> -
> -#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
> -	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
> -
> -static irqreturn_t generic_interrupt(int irq, void *__hci)
> -{
> -	unsigned long	flags;
> -	irqreturn_t	retval = IRQ_NONE;
> -	struct musb	*musb = __hci;
> -
> -	spin_lock_irqsave(&musb->lock, flags);
> -
> -	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
> -	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
> -	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
> -
> -	if (musb->int_usb || musb->int_tx || musb->int_rx)
> -		retval = musb_interrupt(musb);
> -
> -	spin_unlock_irqrestore(&musb->lock, flags);
> -
> -	return retval;
> -}
> -
> -#else
> -#define generic_interrupt	NULL
> -#endif
> -
>  /*
>   * handle all the irqs defined by the HDRC core. for now we expect:  other
>   * irq sources (phy, dma, etc) will be handled first, musb->int_* values
> @@ -1907,7 +1878,8 @@ musb_init_controller(struct device *dev, int nIrq,
> void __iomem *ctrl)
>  	musb->ops = plat->platform_ops;
>  
>  	/* The musb_platform_init() call:
> -	 *   - adjusts musb->mregs and musb->isr if needed,
> +	 *   - adjusts musb->mregs if needed 
> +	 *   - sets the musb->isr 
>  	 *   - may initialize an integrated tranceiver
>  	 *   - initializes musb->xceiv, usually by otg_get_phy()
>  	 *   - stops powering VBUS
> @@ -1917,7 +1889,6 @@ musb_init_controller(struct device *dev, int nIrq,
> void __iomem *ctrl)
>  	 * external/discrete ones in various flavors (twl4030 family,
>  	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
>  	 */
> -	musb->isr = generic_interrupt;
>  	status = musb_platform_init(musb);
>  	if (status < 0)
>  		goto fail1;
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 5fdb9da..5461619d 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -306,6 +306,26 @@ static void omap_musb_mailbox_work(struct work_struct
> *mailbox_work)
>  	omap_musb_set_mailbox(glue);
>  }
>  
> +static irqreturn_t omap2430_musb_interrupt(int irq, void *__hci)
> +{
> +        unsigned long   flags;
> +        irqreturn_t     retval = IRQ_NONE;
> +        struct musb     *musb = __hci;
> +
> +        spin_lock_irqsave(&musb->lock, flags);
> +
> +        musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
> +        musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
> +        musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
> +
> +        if (musb->int_usb || musb->int_tx || musb->int_rx)
> +                retval = musb_interrupt(musb);
> +
> +        spin_unlock_irqrestore(&musb->lock, flags);
> +
> +        return retval;
> +}
> +
>  static int omap2430_musb_init(struct musb *musb)
>  {
>  	u32 l;
> @@ -325,6 +345,8 @@ static int omap2430_musb_init(struct musb *musb)
>  		return -ENODEV;
>  	}
>  
> +	musb->isr = omap2430_musb_interrupt;
> +
>  	status = pm_runtime_get_sync(dev);
>  	if (status < 0) {
>  		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
> diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
> index a8c0fad..ec9aaec 100644
> --- a/drivers/usb/musb/ux500.c
> +++ b/drivers/usb/musb/ux500.c
> @@ -36,6 +36,26 @@ struct ux500_glue {
>  };
>  #define glue_to_musb(g)	platform_get_drvdata(g->musb)
>  
> +static irqreturn_t ux500_musb_interrupt(int irq, void *__hci)
> +{
> +        unsigned long   flags;
> +        irqreturn_t     retval = IRQ_NONE;
> +        struct musb     *musb = __hci;
> +
> +        spin_lock_irqsave(&musb->lock, flags);
> +
> +        musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
> +        musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
> +        musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
> +
> +        if (musb->int_usb || musb->int_tx || musb->int_rx)
> +                retval = musb_interrupt(musb);
> +
> +        spin_unlock_irqrestore(&musb->lock, flags);
> +
> +        return retval;
> +}
> +
>  static int ux500_musb_init(struct musb *musb)
>  {
>  	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
> @@ -43,6 +63,7 @@ static int ux500_musb_init(struct musb *musb)
>  		pr_err("HS USB OTG: no transceiver configured\n");
>  		return -ENODEV;
>  	}
> +	musb->isr = ux500_musb_interrupt;
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
