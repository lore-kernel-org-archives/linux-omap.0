From: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Mon, 7 May 2012 11:01:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987147@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com>
 <4FA4035E.6020308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA4035E.6020308-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Hunter, Jon" <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org" <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hire
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Fri, May 04, 2012 at 21:57:10, Hunter, Jon wrote:
> > -	gpmc_write_reg(GPMC_SYSCONFIG, l);
> > -	gpmc_mem_init();
> > +	switch (conf & GPMC_WAITPIN_MASK) {
> > +	case GPMC_WAITPIN_0:
> > +		idx =  GPMC_WAITPIN_IDX0;
> > +		break;
> > +	case GPMC_WAITPIN_1:
> > +		idx =  GPMC_WAITPIN_IDX1;
> > +		break;
> > +	case GPMC_WAITPIN_2:
> > +		idx =  GPMC_WAITPIN_IDX2;
> > +		break;
> > +	case GPMC_WAITPIN_3:
> > +		idx =  GPMC_WAITPIN_IDX3;
> > +		break;
> > +	/* no waitpin */
> > +	case 0:
> > +		break;
> > +	default:
> > +		dev_err(gpmc->dev, "multiple waitpins selected on CS:%u\n", cs);
> > +		return -EINVAL;
> > +		break;
> > +	}
> 
> Why not combined case 0 and default? Both are invalid configurations so
> just report invalid selection.

Case 0 is not invalid, a case where waitpin is not used, default refers
to when a user selects multiple waitpins wrongly.

> 
> >  
> > -	/* initalize the irq_chained */
> > -	irq = OMAP_GPMC_IRQ_BASE;
> > -	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
> > -		irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > -						handle_simple_irq);
> > -		set_irq_flags(irq, IRQF_VALID);
> > -		irq++;
> > +	switch (conf & GPMC_WAITPIN_POLARITY_MASK) {
> > +	case GPMC_WAITPIN_ACTIVE_LOW:
> > +		polarity = LOW;
> > +		break;
> > +	case GPMC_WAITPIN_ACTIVE_HIGH:
> > +		polarity = HIGH;
> > +		break;
> > +	/* no waitpin */
> > +	case 0:
> > +		break;
> > +	default:
> > +		dev_err(gpmc->dev, "waitpin polarity set to low & high\n");
> > +		return -EINVAL;
> > +		break;
> >  	}
> 
> Again, combine case 0 and default as these are invalid.

Similar to above

> 
> > +		if (gd->have_waitpin) {
> > +			if (gd->waitpin != idx ||
> > +					gd->waitpin_polarity != polarity) {
> > +				dev_err(gpmc->dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
> > +					gd->waitpin, gd->waitpin_polarity,
> > +					gd->name, gd->id);
> > +				return -EBUSY;
> > +			}
> > +		} else {
> 
> Don't need the else as you are going to return in the above.

Not always, only in case of error

> 
> > +			gd->have_waitpin = true;
> > +			gd->waitpin = idx;
> > +			gd->waitpin_polarity = polarity;
> > +		}
> > +
> > +		l &= ~GPMC_CONFIG1_WAIT_PIN_SEL_MASK;
> > +		l |= GPMC_CONFIG1_WAIT_PIN_SEL(idx);
> > +		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
> > +	} else if (polarity) {
> > +		dev_err(gpmc->dev, "error: waitpin polarity specified with out wait pin number on device %s.%d\n",
> > +							gd->name, gd->id);
> > +		return -EINVAL;
> 
> Drop this else-if. The above switch statements will report the bad
> configuration. This seems a bit redundant.

This is required as switch statements will not report error if polarity
is specified, w/o waitpin to be used.

Regards
Afzal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
