From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v5 2/3] wl18xx: add basic device-tree support
Date: Wed, 11 Mar 2015 10:51:21 +0100
Message-ID: <2121942.zIG9BfPsTV@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com> <1425915402-10012-2-git-send-email-eliad@wizery.com> <CABxcv=mygdT2Q+ByVKPx4+o_Oj9KSy=zVX9ng9yN25ivkfSn1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=mygdT2Q+ByVKPx4+o_Oj9KSy=zVX9ng9yN25ivkfSn1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 11 March 2015 01:34:19 Javier Martinez Canillas wrote:
> > +
> > +static struct wl12xx_platform_data *
> > +wlcore_get_platform_data(struct device *dev)
> > +{
> > +       struct wl12xx_platform_data *pdata;
> > +
> > +       /* first, look for DT data */
> 
> I thought it was the opposite, that platform data should over-rule DT.
> That way you can still use the data filled in
> arch/arm/mach-omap2/pdata-quirks.c even after the driver supports your
> new DT binding.

No, the pdata-quirks stuff for this driver must die, it was a hack
that only exists because we previously could not attach data to an
sdio function.

> > +       pdata = wlcore_probe_of(dev);
> > +       if (pdata)
> > +               return pdata;
> > +
> > +       /* if not found - fallback to static platform data */
> > +       pdata = wl12xx_get_platform_data();
> > +       if (!IS_ERR(pdata))
> > +               return kmemdup(pdata, sizeof(*pdata), GFP_KERNEL);
> > +
> > +       dev_err(dev, "No platform data set\n");
> > +       return NULL;
> > +}
> > +
> > +static void wlcore_del_platform_data(struct wl12xx_platform_data *pdata)
> > +{
> > +       kfree(pdata);
> > +}
> > +
> 
> This function seems to be an unnecessary, why not just call kfree() directly?
> 
> Or better, maybe the resource-managed devm_*() functions can be used
> so the data doesn't have to be explicitly freed?

As I said earlier, I think it would be best not to dynamically allocate anything
here at all. As Eliad explained, the data is used by two different drivers:
wl12xx and wl18xx, and only the latter is converted for now, but after the
conversion, it should not need the platform data structure any more, only
the irq number that gets passed in from DT.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
