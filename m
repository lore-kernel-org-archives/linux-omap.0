From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4] mfd: cpcap: Add minimal support
Date: Wed, 25 Jan 2017 14:41:16 -0800
Message-ID: <20170125224114.GK7403@atomide.com>
References: <20170106004439.12249-1-tony@atomide.com>
 <20170124093534.GU16020@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170124093534.GU16020@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [170124 01:32]:
> On Thu, 05 Jan 2017, Tony Lindgren wrote:
> > +
> > +	bit = irq % cpcap->regmap_conf->val_bits;
> > +	mask = (1 << bit);
> 
> Nit: BIT()
...
> > + * Copyright (C) 2016 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> Nit: 2017
...
> > +/*
> > + * Helpers for child devices to check the revision and vendor.
> > + *
> > + * REVISIT: No documentation for the bits below, please update
> > + * to use proper names for defines when available.
> > + */
> 
> Yes, please do that.
> 
> But you can do all of the above with subsequent patches.

OK I'll send you a BIT() follow-up patch.

> Applied, thanks.

Thanks, not seeing it in next or mfd git tree yet though, forgot
to push out?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
