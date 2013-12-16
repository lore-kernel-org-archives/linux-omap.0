From: Anton Tikhomirov <av.tikhomirov-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
Date: Mon, 16 Dec 2013 11:31:50 +0900
Message-ID: <00a001cefa06$f9ab3d60$ed01b820$%tikhomirov@samsung.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-8-git-send-email-balbi@ti.com>
 <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
 <20131213195618.GG5292@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20131213195618.GG5292-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Content-language: en-us
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: 'Linux USB Mailing List' <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, 'Linux ARM Kernel Mailing List' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux OMAP Mailing List' <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, w-kwok2-l0cyMroinI0@public.gmane.org, 'Santosh Shilimkar' <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

> On Fri, Dec 13, 2013 at 02:01:32PM +0900, Anton Tikhomirov wrote:
> > Hi Felipe,
> >
> > > -static int dwc3_exynos_suspend(struct device *dev)
> > > +static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
> > >  {
> > > -	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> > > -
> > >  	clk_disable(exynos->clk);
> > >
> > >  	return 0;
> > >  }
> > >
> > > +static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
> > > +{
> > > +	return clk_enable(exynos->clk);
> > > +}
> > > +
> > > +static int dwc3_exynos_suspend(struct device *dev)
> > > +{
> > > +	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> > > +
> > > +	return __dwc3_exynos_suspend(exynos);
> >
> > If dwc3-exynos is runtime suspended, the clock will be disabled
> > second time here (unbalanced clk_enable/clk_disable).
> 
> I don't get what you mean but there is something that probably needs
> fixing, I guess below makes it better:
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-
> exynos.c
> index c93919a..1e5720a 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -218,6 +218,9 @@ static int dwc3_exynos_suspend(struct device *dev)
>  {
>  	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> 
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
>  	return __dwc3_exynos_suspend(exynos);
>  }
> 
> 
> Is that what you meant ?

Yes, this is exactly what I meant.

Thanks.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
