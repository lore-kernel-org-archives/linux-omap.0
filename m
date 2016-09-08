From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 3/3] Input: Add support for tps65217 power button
Date: Thu, 8 Sep 2016 16:21:26 -0700
Message-ID: <20160908232126.piopvzfhpfhpw2ed@atomide.com>
References: <20160908095900.30975-1-m.niestroj@grinn-global.com>
 <20160908095900.30975-4-m.niestroj@grinn-global.com>
 <20160908170437.GA30299@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160908170437.GA30299@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160908 10:04]:
> On Thu, Sep 08, 2016 at 11:59:00AM +0200, Marcin Niestroj wrote:
> > -	pwr->tps = tps;
> > +	pwr->regmap = *(struct regmap **) (tps + pwr->data->regmap_offset);
> 
> Please never ever do this stuff, it is extremely fragile and is bound to
> break. Do this instead:
> 
> 	regmap = dev_get_regmap(pdev->dev.parent, NULL);

I wonder if we should add dev_get_parent_regmap(dev, "desc")?

This passing of pdev->dev.parent always makes me wonder why
we're tweaking the parent resources..

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
