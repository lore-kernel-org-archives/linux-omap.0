From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
Date: Mon, 16 Dec 2013 11:47:12 +0900
Message-ID: <00a701cefa09$1f26f6e0$5d74e4a0$%tikhomirov@samsung.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-8-git-send-email-balbi@ti.com>
 <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
 <20131213195618.GG5292@saruman.home> <20131213201831.GJ5292@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20131213201831.GJ5292@saruman.home>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: balbi@ti.com
Cc: 'Linux USB Mailing List' <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, 'Linux ARM Kernel Mailing List' <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>, w-kwok2@ti.com, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

> On Fri, Dec 13, 2013 at 01:56:18PM -0600, Felipe Balbi wrote:
> > On Fri, Dec 13, 2013 at 02:01:32PM +0900, Anton Tikhomirov wrote:
> > > Hi Felipe,
> > >
> > > > -static int dwc3_exynos_suspend(struct device *dev)
> > > > +static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
> > > >  {
> > > > -	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> > > > -
> > > >  	clk_disable(exynos->clk);
> > > >
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
> > > > +{
> > > > +	return clk_enable(exynos->clk);
> > > > +}
> > > > +
> > > > +static int dwc3_exynos_suspend(struct device *dev)
> > > > +{
> > > > +	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> > > > +
> > > > +	return __dwc3_exynos_suspend(exynos);
> > >
> > > If dwc3-exynos is runtime suspended, the clock will be disabled
> > > second time here (unbalanced clk_enable/clk_disable).
> >
> > I don't get what you mean but there is something that probably needs
> > fixing, I guess below makes it better:
> >
> > diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-
> exynos.c
> > index c93919a..1e5720a 100644
> > --- a/drivers/usb/dwc3/dwc3-exynos.c
> > +++ b/drivers/usb/dwc3/dwc3-exynos.c
> > @@ -218,6 +218,9 @@ static int dwc3_exynos_suspend(struct device *dev)
> >  {
> >  	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> >
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> > +
> >  	return __dwc3_exynos_suspend(exynos);
> >  }
> >
> >
> > Is that what you meant ?
> 
> note, however, that this is *not* a case where we would fall today. See
> that we pm_runtime_get() in probe and only pm_runtime_put() during
> remove. So there would never be a case where we would try system
> suspend 
> while device was already runtime suspended.

You are right, while runtime PM is blocked by get_sync() in probe, this
check
doesn't matter.

> 
> I have fixed all patches in my testing/next branch anyway, just to make
> sure we're "idiot-proof" when it comes to implementing real runtime pm
> later on :-)
> 
> cheers
> 
> --
> balbi

Thank you
