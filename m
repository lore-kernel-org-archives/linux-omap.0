From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 5/8] MFD: ti_am335x_tscadc: Add DT support
Date: Thu, 31 Jan 2013 12:25:07 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E9B21C5@DBDE01.ent.ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
 <1358999112-31192-6-git-send-email-rachna@ti.com>
 <A9839AA2-ABCD-4642-9766-D56824AC27AD@dominion.thruhere.net>
 <4CE347531D4CA947960AF71FF095B9323E9B1EE9@DBDE01.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A83EBEFAE8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EBEFAE8-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Vaibhav,

<SNIP>
> > > > 
> > > > -	if (!pdata) {
> > > > +	if (!pdata && !pdev->dev.of_node) {
> > > > 		dev_err(&pdev->dev, "Could not find platform data\n");
> > > > 		return -EINVAL;
> > > > 	}
> > > > 
> > > > -	if (pdata->adc_init)
> > > > -		adc_channels = pdata->adc_init->adc_channels;
> > > > +	if (pdev->dev.platform_data) {
> > > > +		if (pdata->tsc_init)
> > > > +			tsc_wires = pdata->tsc_init->wires;
> > > > +
> > > > +		if (pdata->adc_init)
> > > > +			adc_channels = pdata->adc_init->adc_channels;
> > > > +	} else {
> > > > +		node = of_find_node_by_name(pdev->dev.of_node, "tsc");
> > > > +		of_property_read_u32(node, "ti,wires", &tsc_wires);
> > > > +
> > > > +		node = of_find_node_by_name(pdev->dev.of_node, "adc");
> > > > +		of_property_read_u32(node, "ti,adc-channels", &adc_channels);
> > > > +	}
> > > 
> > > Since AM335x is DT only, why is there a platform data codepath and why is it the first branch it tries? And I guess the next question is related to the first: why doesn't it work when used with DT? When I copy over the nodes from the evm.dts to my board I get "tsc tsc: Missing platform data" in dmesg.
> > 
> > This IP came up 1st on AM335x, but it is not platform dependent. The driver can be used on other platforms where-in DT is not supported.
> > According to the maintainers platform data takes precedence over DT. Hence the order.
> > 
> 
> Rachana,
> 
> I see no point adding support for platform_data when you know that none of older platforms are going to use this driver and all future platforms _must_ follow device-tree model.
> 
> So I agree that you should remove board file dependency from the driver.

Ok. I will remove support for platform data in the next version of patches.

> 
> 
> > I do not see "Missing platform data" error msg in the latest driver. I am not able to trace from where this got populated.
> > 
> 
> Can you share the branch which you have tested?

https://github.com/patilrachna/linux/tree/v3.8_rc3_MFD_TSCADC_DT-v2

Regards,
Rachna
