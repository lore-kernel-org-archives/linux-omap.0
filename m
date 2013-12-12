From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: fix occasional musb breakage on boot
Date: Wed, 11 Dec 2013 16:38:43 -0800
Message-ID: <20131212003843.GA17760@psi-dev26.jf.intel.com>
References: <1386807659-5505-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386807659-5505-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 12, 2013 at 02:20:59AM +0200, Grazvydas Ignotas wrote:
> This is a hard to reproduce problem which leads to non-functional
> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
> e25bec160158abe86c "omap2+: save and restore OTG_INTERFSEL",
> which introduces save/restore of OTG_INTERFSEL over suspend.
> 
> Since the resume function is also called early in driver init, it uses a
> non-initialized value (which is 0 and a non-supported setting in DM37xx
> for INTERFSEL). Shortly after the correct value is set. Apparently this
> works most time, but not always.
> 
> Fix it by not writing the value on runtime resume if it is 0
> (0 should never be saved in the context as it's invalid value,
> so we use it as an indicator that context hasn't been saved yet).
> 
> This issue was originally found by Andreas Naumann:
> http://marc.info/?l=linux-usb&m=138562574719654&w=2
> 
> Reported-and-bisected-by: Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> ---
> This is a regression from 3.2, so should go to -rc and stable, IMO.
> It's really annoying issue if you want to have a stable OTG behavior,
> I've burned quite a lot of time on it myself over a year ago and gave up
> eventually. Good thing Andreas finally found it, many thanks to him!
> 
>  drivers/usb/musb/omap2430.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2a408cd..737b3da 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -672,7 +672,8 @@ static int omap2430_runtime_resume(struct device *dev)
>  
>  	if (musb) {
>  		omap2430_low_level_init(musb);
> -		musb_writel(musb->mregs, OTG_INTERFSEL,
> +		if (musb->context.otg_interfsel != 0)

You might want to write an inline comment explaining why you're checking
otg_interfsel for 0 here (as you explained 0 is not a valid value to be
found).

Br, David

> +			musb_writel(musb->mregs, OTG_INTERFSEL,
>  				musb->context.otg_interfsel);
>  		phy_power_on(musb->phy);
>  	}
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
