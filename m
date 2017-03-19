From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
Date: Sun, 19 Mar 2017 10:54:26 -0700
Message-ID: <20170319175426.GE20572@atomide.com>
References: <20170317014344.27201-1-tony@atomide.com>
 <fefdc8e7-3780-b149-7898-0a4f3f58efc3@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fefdc8e7-3780-b149-7898-0a4f3f58efc3-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170319 10:08]:
> On 17/03/17 01:43, Tony Lindgren wrote:
> > On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
> > has ADCs that are used for battery charging and USB PHY VBUS and ID pin
> > detection.
> > 
> > Unfortunately the only documentation for this ADC seems to be the
> > Motorola mapphone Linux kernel tree. I have tested that reading raw and
> > scaled values works, but I have not used the timed sampling that the ADC
> > seems to support.
> Any link? I'm curious to see just how 'interesting' this was...

Well the Motorola kernel has the CPCAP PMIC registers quite nicely
documented. I mostly use the "STS-Dev-Team/kernel_mapphone_kexec"
git tree as a reference as that has the original Motorola patch
imported into a git tree. Below are few links to selected files
for fun reading:

https://github.com/STS-Dev-Team/kernel_mapphone_kexec
https://github.com/STS-Dev-Team/kernel_mapphone_kexec/blob/cm-10.1/drivers/mfd/cpcap-adc.c
https://github.com/STS-Dev-Team/kernel_mapphone_kexec/blob/cm-10.1/include/linux/spi/cpcap-regbits.h
https://github.com/STS-Dev-Team/kernel_mapphone_kexec/blob/cm-10.1/include/linux/spi/cpcap.h

> You are a brave person...

Well n950 is too hard to replace.. And n900 is a bit memory limited..
And there are tons of used droid 4 available for about $35 or so :)

> > +/*
> > + * Temperature lookup table of register values to milliCelcius.
> > + * REVISIT: Check the duplicate 0x3ff entry in a freezer
> :) Best comment I've seen in a driver for a while!

:)

> > +static const struct iio_chan_spec cpcap_adc_channels[] = {
> > +	CPCAP_CHAN(IIO_TEMP, 0, CPCAP_REG_ADCD0, "battdetb"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 1, CPCAP_REG_ADCD1, "battp"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 2, CPCAP_REG_ADCD2, "vbus"),
> > +	CPCAP_CHAN(IIO_TEMP, 3, CPCAP_REG_ADCD3, "ad3"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 4, CPCAP_REG_ADCD4, "ad4"),
> > +	CPCAP_CHAN(IIO_CURRENT, 5, CPCAP_REG_ADCD5, "chg_isense"),
> > +	CPCAP_CHAN(IIO_CURRENT, 6, CPCAP_REG_ADCD6, "batti"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 7, CPCAP_REG_ADCD7, "usb_id"),
> > +
> > +	CPCAP_CHAN(IIO_CURRENT, 8, CPCAP_REG_ADCD0, "ad8"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 9, CPCAP_REG_ADCD1, "ad9"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 10, CPCAP_REG_ADCD2, "licell"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 11, CPCAP_REG_ADCD3, "hv_battp"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 12, CPCAP_REG_ADCD4, "tsx1_ad12"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 13, CPCAP_REG_ADCD5, "tsx2_ad13"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 14, CPCAP_REG_ADCD6, "tsy1_ad14"),
> > +	CPCAP_CHAN(IIO_VOLTAGE, 15, CPCAP_REG_ADCD7, "tsy2_ad15"),
> Touch screen kicking around on here as well?  Or am I reading too much into
> the names?

Yeah so it seems. These do not seem to be wired to anything in
droid 4, but the Motorola kernel supports a whole family of
devices, so it was probably used for touch screen on some at some
point.

> > +		*val = req.result[index];
> 
> This would come in the seriously unusual category if the scale is integer...
> Could be I suppose, but seems unlikely ;)
> Note that value in mV should be raw_value * scale.
> 
> I'd guess these are what we term _processed channels, i.e. already in mV?

Oh OK, thanks I'll check, yeah it's already in mV.

> If all you have is unregister in remove, it's a fairly sure sign
> you could have used devm_iio_device_register and dropped the remove
> entirely.

Sure. Will also look at the other comments and repost, thanks
for the review.

Regards,

Tony
