From: David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [PATCH V3] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Tue, 17 Dec 2013 09:22:33 -0800
Message-ID: <20131217172233.GA29638@psi-dev26.jf.intel.com>
References: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55996 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab3LQRck (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 12:32:40 -0500
Content-Disposition: inline
In-Reply-To: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anaumann@ultratronik.de
Cc: notasas@gmail.com, linux-usb@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org

On Tue, Dec 17, 2013 at 05:48:33PM +0100, anaumann@ultratronik.de wrote:
> From: Andreas Naumann <anaumann@ultratronik.de>
> 
> This is a hard to reproduce problem which leads to non-functional
> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
> e25bec160158abe86c276d7d206264afc3646281, which introduces save/restore
> of OTG_INTERFSEL over suspend.
> Since the resume function is also called early in driver init, it uses a
> non-initialized value (which is 0 and a non-supported setting in DM37xx
> for INTERFSEL). Shortly after the correct value is set. Apparently this
> works most time, but not always.
> 
> Fix it by not writing the value on runtime resume if it has not been
> initialized yet.
> 
> Signed-off-by: Andreas Naumann <anaumann@ultratronik.de>
> ---
> Even though I find the implementation a bit awkward this should fix
> the issue without breaking anything else. Hope everyone is happy 
> with this.
> 
>  drivers/usb/musb/omap2430.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 4315d35..fbe2c08 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -48,6 +48,7 @@ struct omap2430_glue {
>  	enum omap_musb_vbus_id_status status;
>  	struct work_struct	omap_musb_mailbox_work;
>  	struct device		*control_otghs;
> +	u8 	initialized;
>  };
>  #define glue_to_musb(g)		platform_get_drvdata(g->musb)
>  
> @@ -383,6 +384,7 @@ static int omap2430_musb_init(struct musb *musb)
>  	}
>  
>  	musb_writel(musb->mregs, OTG_INTERFSEL, l);
> +	glue->initialized = 1;
>  
>  	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
>  			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
> @@ -509,6 +511,7 @@ static int omap2430_probe(struct platform_device *pdev)
>  	glue->dev			= &pdev->dev;
>  	glue->musb			= musb;
>  	glue->status			= OMAP_MUSB_UNKNOWN;
> +	glue->initialized	= 0;

You don't need to do this. 'glue' was already allocated with kzalloc().

>  
>  	if (np) {
>  		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> @@ -646,7 +649,8 @@ static int omap2430_runtime_resume(struct device *dev)
>  
>  	if (musb) {
>  		omap2430_low_level_init(musb);
> -		musb_writel(musb->mregs, OTG_INTERFSEL,
> +		if(glue->initialized)

Are you sure this is thread safe?
If you're sending this patch it means runtime_resume can be called
before omap2430_must_init(), but how about at the same time?
You defined 'initialized' as u8 type, then read/write operations won't
be atomic in ARM.

Br, David Cohen

> +			musb_writel(musb->mregs, OTG_INTERFSEL,
>  				musb->context.otg_interfsel);
>  
>  		usb_phy_set_suspend(musb->xceiv, 0);
> -- 
> 1.8.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
