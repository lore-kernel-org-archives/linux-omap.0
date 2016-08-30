From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/5] mfd: tps65217: Add power button as subdevice
Date: Tue, 30 Aug 2016 10:50:34 +0100
Message-ID: <20160830095034.GI1661@dell>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-5-m.niestroj@grinn-global.com>
 <c849849f-ba1d-3263-9941-b346ef9eef59@grinn-global.com>
 <20160830090329.GD1661@dell>
 <9fafa9b0-cc45-6fe9-ddb9-5c933064261c@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9fafa9b0-cc45-6fe9-ddb9-5c933064261c-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 30 Aug 2016, Marcin Niestroj wrote:

> On 30.08.2016 11:03, Lee Jones wrote:
> > On Mon, 29 Aug 2016, Marcin Niestroj wrote:
> > 
> > > ping
> > 
> > Don't do that!
> > 
> > If you think the patch hasn't attracted attention in >2 weeks, then
> > it's probably slipped through the gaps and you need to send a
> > [RESEND].
> 
> Clear.
> 
> > 
> > However ...
> > 
> > > On 20.06.2016 12:50, Marcin Niestroj wrote:
> > > > Add tps65217 power buttor subdevice with assigned IRQ resources.
> > > > 
> > > > Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> > > > Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > 
> > This patch has a maintainer Ack, so why are you pinging?
> 
> Because I didn't see it applied anywhere and there were no new
> comments, so I thought it slipped somewhere.
> 
> So my question is: what happens with the patch after maintainer Ack?
> Are we still waiting for some comments from the community? Do I still
> need to worry, that the patch might slipped? What is author's role now?

Since you sent the patches as a set, it is assumed there are some
dependencies between them, or they are at least in some way related.
To that end, it is normal for Maintainers (especially for me as the
MFD Maintainer, since there often some complex ties into the leaf
driver's changes) to wait until *all* of the patches have either been
accepted or have acquired an Ack of their own to proceed.

I believe we are still waiting on other patches to be reviewed, no?

> > > > ---
> > > > Depends on patch 1 in series
> > > > 
> > > > Changes v1 -> v4: none
> > > > 
> > > >  drivers/mfd/tps65217.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> > > > index 41b5d59..57c8741 100644
> > > > --- a/drivers/mfd/tps65217.c
> > > > +++ b/drivers/mfd/tps65217.c
> > > > @@ -38,6 +38,10 @@ static struct resource charger_resources[] = {
> > > >  	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
> > > >  };
> > > > 
> > > > +static struct resource pb_resources[] = {
> > > > +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
> > > > +};
> > > > +
> > > >  struct tps65217_irq {
> > > >  	int mask;
> > > >  	int interrupt;
> > > > @@ -122,6 +126,12 @@ static struct mfd_cell tps65217s[] = {
> > > >  		.resources = charger_resources,
> > > >  		.of_compatible = "ti,tps65217-charger",
> > > >  	},
> > > > +	{
> > > > +		.name = "tps65217-pwrbutton",
> > > > +		.num_resources = ARRAY_SIZE(pb_resources),
> > > > +		.resources = pb_resources,
> > > > +		.of_compatible = "ti,tps65217-pwrbutton",
> > > > +	},
> > > >  };
> > > > 
> > > >  static irqreturn_t tps65217_irq_thread(int irq, void *data)
> > > > 
> > > 
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
