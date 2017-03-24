From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Fri, 24 Mar 2017 07:08:07 -0700
Message-ID: <20170324140807.GW10760@atomide.com>
References: <20170322234210.5557-1-tony@atomide.com>
 <20170324100622.mzra66z35xlndhdj@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170324100622.mzra66z35xlndhdj@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170324 03:08]:
> On Wed, Mar 22, 2017 at 04:42:10PM -0700, Tony Lindgren wrote:
> > +Required properties:
> > +- compatible: Shall be "motorola,cpcap-charger" or
> > +	      "motorola,mapphone-cpcap-charger"
> > +- interrupts: Interrupts used on the CPCAP PMIC
> > +- interrupt-names: Names of the interrupts
> 
> That's usually done like
> 
> interrupts: Interrupt specifier for each name in interrupt-names
> interrupt-names: Should contain the following entries:
>  "bla", "foo", "42"

Sure will update.

> > +- io-channels: IIO ADC channels used by the charger
> > +- io-channel-names: Names of the IIO ADC channels
> 
> Same as for interrupts.

OK

> > +Optional properties:
> > +- mode-gpios: Optionally CPCAP charger can have a companion wireless
> > +	      charge controller that is controlled with two GPIOs
> 
> DT people prefer to have GPIO activity (high/low) to be specified in the
> binding.

OK will add.

> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -317,6 +317,13 @@ config BATTERY_RX51
> >  	  Say Y here to enable support for battery information on Nokia
> >  	  RX-51, also known as N900 tablet.
> >  
> > +config CHARGER_CPCAP
> > +	tristate "CPCAP PMIC Charger Driver"
> > +	depends on MFD_CPCAP
> > +	help
> > +	  Say Y to enable support for CPCAP PMIC charger driver for Motorola
> > +	  mobile devices such as Droid 4.
> > +
> 
> I think adding "default MFD_CPCAP" for CPCPAP's subdrivers would be nice.

OK

> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > 
> > [...]
> >
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/usb/phy_companion.h>
> > +#include <linux/phy/omap_usb.h>
> > +#include <linux/usb/otg.h>
> > +#include <linux/iio/consumer.h>
> > +#include <linux/mfd/motorola-cpcap.h>
> 
> This looks very entangled with mapphone specific things,
> so maybe we should not add "motorola,cpcap-charger" for
> now?

Yeah I think that's a good idea as we have no documentation for
the mystery companion charger chip there that has "6500" printed
on it.

> > +static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
> > +					struct cpcap_charger_ints_state *s)
> > +{
> > +	int val, error;
> > +
> > +	error = regmap_read(ddata->reg, CPCAP_REG_INTS1, &val);
> > +	if (error)
> > +		return error;
> > +
> > +	s->chrg_det = val & BIT(13);
> > +	s->rvrs_chrg = val & BIT(12);
> > +	s->vbusov = val & BIT(11);
> > +
> > +	error = regmap_read(ddata->reg, CPCAP_REG_INTS2, &val);
> > +	if (error)
> > +		return error;
> > +
> > +	s->chrg_se1b = val & BIT(13);
> > +	s->rvrs_mode = val & BIT(6);
> > +	s->chrgcurr1 = val & BIT(4);
> > +	s->vbusvld = val & BIT(3);
> > +
> > +	error = regmap_read(ddata->reg, CPCAP_REG_INTS4, &val);
> > +	if (error)
> > +		return error;
> > +
> > +	s->battdetb = val & BIT(6);
> 
> Did you avoid using cpcap_sense_virq() for performance reasons?

I don't think performance is an issue here :)

> s->battdetb = cpcap_sense_virq(ddata->reg, ddata->irq_battdetb);
> (and so on)
> 
> looks cleaner IMHO.

I figured I'll do a follow up patch for when available to remove
dependencies between subsystems.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
