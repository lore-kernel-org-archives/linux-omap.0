From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [08/15] usb: musb: Improve PM runtime and phy handling for 2430 glue layer
Date: Fri, 09 Sep 2016 20:08:53 +0300
Message-ID: <1473471770.EbnIMnoyD8@avalon>
References: <1463014396-4095-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463014396-4095-9-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 11 May 2016 17:53:09 Tony Lindgren wrote:
> This simplifies things and allows idling both MUSB and PHY
> when nothing is configured. Let's just return early from PM
> runtime if musb is not yet initialized.
> 
> Let's also warn if PHY is not configured.

git bisect pointed out to this patch today when I tried to find out what broke 
nfsroot over USB ethernet gadget on my Panda board :-/ Could you help me 
debugging and fixing that ?

> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/musb/omap2430.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 02d40bc..eb0f332 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -435,6 +435,7 @@ static int omap2430_musb_init(struct musb *musb)
>  		return PTR_ERR(musb->phy);
>  	}
>  	musb->isr = omap2430_musb_interrupt;
> +	phy_init(musb->phy);
> 
>  	/*
>  	 * Enable runtime PM for musb parent (this driver). We can't
> @@ -471,8 +472,6 @@ static int omap2430_musb_init(struct musb *musb)
>  	if (glue->status != MUSB_UNKNOWN)
>  		omap_musb_set_mailbox(glue);
> 
> -	phy_init(musb->phy);
> -	phy_power_on(musb->phy);
>  	pm_runtime_put(glue->dev);
>  	return 0;
> 
> @@ -489,6 +488,9 @@ static void omap2430_musb_enable(struct musb *musb)
>  	struct musb_hdrc_platform_data *pdata = dev_get_platdata(dev);
>  	struct omap_musb_board_data *data = pdata->board_data;
> 
> +	if (!WARN_ON(!musb->phy))
> +		phy_power_on(musb->phy);
> +
>  	omap2430_set_power(musb, true, glue->cable_connected);
> 
>  	switch (glue->status) {
> @@ -526,6 +528,9 @@ static void omap2430_musb_disable(struct musb *musb)
>  	struct device *dev = musb->controller;
>  	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
> 
> +	if (!WARN_ON(!musb->phy))
> +		phy_power_off(musb->phy);
> +
>  	if (glue->status != MUSB_UNKNOWN)
>  		omap_control_usb_set_mode(glue->control_otghs,
>  			USB_MODE_DISCONNECT);
> @@ -535,11 +540,14 @@ static void omap2430_musb_disable(struct musb *musb)
> 
>  static int omap2430_musb_exit(struct musb *musb)
>  {
> -	del_timer_sync(&musb_idle_timer);
> +	struct device *dev = musb->controller;
> +	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
> 
> +	del_timer_sync(&musb_idle_timer);
>  	omap2430_low_level_exit(musb);
> -	phy_power_off(musb->phy);
>  	phy_exit(musb->phy);
> +	musb->phy = NULL;
> +	cancel_work_sync(&glue->omap_musb_mailbox_work);
> 
>  	return 0;
>  }
> @@ -707,7 +715,6 @@ static int omap2430_remove(struct platform_device *pdev)
> struct musb *musb = glue_to_musb(glue);
> 
>  	pm_runtime_get_sync(glue->dev);
> -	cancel_work_sync(&glue->omap_musb_mailbox_work);
>  	platform_device_unregister(glue->musb);
>  	omap2430_set_power(musb, false, false);
>  	pm_runtime_put_sync(glue->dev);
> @@ -723,12 +730,13 @@ static int omap2430_runtime_suspend(struct device
> *dev) struct omap2430_glue		*glue = dev_get_drvdata(dev);
>  	struct musb			*musb = glue_to_musb(glue);
> 
> -	if (musb) {
> -		musb->context.otg_interfsel = musb_readl(musb->mregs,
> -				OTG_INTERFSEL);
> +	if (!musb)
> +		return 0;
> 
> -		omap2430_low_level_exit(musb);
> -	}
> +	musb->context.otg_interfsel = musb_readl(musb->mregs,
> +						 OTG_INTERFSEL);
> +
> +	omap2430_low_level_exit(musb);
> 
>  	return 0;
>  }
> @@ -739,7 +747,7 @@ static int omap2430_runtime_resume(struct device *dev)
>  	struct musb			*musb = glue_to_musb(glue);
> 
>  	if (!musb)
> -		return -EPROBE_DEFER;
> +		return 0;
> 
>  	omap2430_low_level_init(musb);
>  	musb_writel(musb->mregs, OTG_INTERFSEL,

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
