From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Fri, 28 Aug 2009 10:38:51 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4A53A@dbde02.ent.ti.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436A4A15B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A4A15B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>, Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> ========== patch =========================
> There is an issue with MUSB AUTOIDLE as reported by Niilo Minkkinen in
> below commit.
> 
> 9a4b5e36ce58febdd2039dd4d129ee7edf4f5536
> usb: musb: disable OTG AUTOIDLE only with omap3430
> 
> As OMAP35x is just a variant of OMAP34xx chip thus the fix is also
> applicable for OMAP35x so updating it for OMAP35x.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/omap2430.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 453796c..ab8336d 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -233,7 +233,7 @@ int __init musb_platform_init(struct musb *musb)
>  	 * MUSB AUTOIDLE don't work in 3430.
>  	 * Workaround by Richard Woodruff/TI
>  	 */
> -	if (!cpu_is_omap3430())
> +	if (!cpu_is_omap3430() && !cpu_is_omap35xx())

cpu_is_omap35xx() is not yet available so this fix has to wait until this
definition makes its way to l-o or mainline.

-Ajay

>  		l |= AUTOIDLE;		/* enable auto idle */
>  	omap_writel(l, OTG_SYSCONFIG);
> 
> --
> 1.6.2.4
> ==============================================
> 
> >
> > Regards,
> > Richard W.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
