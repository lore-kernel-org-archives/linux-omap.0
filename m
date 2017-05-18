From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: host: ohci-platform: Add basic runtime PM
 support
Date: Thu, 18 May 2017 08:52:37 -0700
Message-ID: <20170518155237.GD10472@atomide.com>
References: <20170517225922.17723-2-tony@atomide.com>
 <Pine.LNX.4.44L0.1705181114280.1619-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1705181114280.1619-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [170518 08:28]:
> On Wed, 17 May 2017, Tony Lindgren wrote:
> 
> > This is needed in preparation of adding support for omap3 and
> > later OHCI. The runtime PM will only do something on platforms
> > that implement it.
> 
> This patch isn't correct.  See below.
> 
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/usb/host/ohci-platform.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> > --- a/drivers/usb/host/ohci-platform.c
> > +++ b/drivers/usb/host/ohci-platform.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/err.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/reset.h>
> >  #include <linux/usb/ohci_pdriver.h>
> >  #include <linux/usb.h>
> > @@ -51,6 +52,10 @@ static int ohci_platform_power_on(struct platform_device *dev)
> >  	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
> >  	int clk, ret, phy_num;
> >  
> > +	ret = pm_runtime_get_sync(&dev->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	for (clk = 0; clk < OHCI_MAX_CLKS && priv->clks[clk]; clk++) {
> >  		ret = clk_prepare_enable(priv->clks[clk]);
> >  		if (ret)
> > @@ -96,6 +101,8 @@ static void ohci_platform_power_off(struct platform_device *dev)
> >  	for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
> >  		if (priv->clks[clk])
> >  			clk_disable_unprepare(priv->clks[clk]);
> > +
> > +	pm_runtime_put_sync(&dev->dev);
> >  }
> 
> ohci_platform_power_on() is invoked (by default) by the runtime-resume
> callback routine ohci_platform_resume(), through the pdata->power_on
> method pointer.  Likewise, ohci_platform_power_off() is invoked by the
> runtime-suspend callback routine.
> 
> This means you shouldn't do pm_runtime_get/put calls from within these 
> routines.

Oh OK great, so the above should not be needed at all.

> Is there any particular reason you wanted to add these calls?  In
> general, USB host controllers are expected to go into runtime suspend
> whenever there aren't any children keeping them awake.  Hence they
> usually don't need to worry about initiating their own suspends and
> resumes.

No particular reason as it sounds things work without it :) I'll check.

> >  static struct hc_driver __read_mostly ohci_platform_hc_driver;
> > @@ -242,6 +249,7 @@ static int ohci_platform_probe(struct platform_device *dev)
> >  	}
> >  #endif
> >  
> > +	pm_runtime_enable(&dev->dev);
> 
> There should be a pm_runtime_set_active() just before this.

OK

> >  	if (pdata->power_on) {
> >  		err = pdata->power_on(dev);
> >  		if (err < 0)
> > @@ -271,6 +279,7 @@ static int ohci_platform_probe(struct platform_device *dev)
> >  	if (pdata->power_off)
> >  		pdata->power_off(dev);
> >  err_reset:
> > +	pm_runtime_disable(&dev->dev);
> >  	while (--rst >= 0)
> >  		reset_control_assert(priv->resets[rst]);
> >  err_put_clks:
> > @@ -305,6 +314,8 @@ static int ohci_platform_remove(struct platform_device *dev)
> >  
> >  	usb_put_hcd(hcd);
> >  
> > +	pm_runtime_disable(&dev->dev);
> > +
> >  	if (pdata == &ohci_platform_defaults)
> >  		dev->dev.platform_data = NULL;
> 
> These changes make sense.

OK thanks for looking.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
