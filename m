From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 07/11] mfd: Drop unnecessary static
Date: Sat, 15 Jul 2017 22:56:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707152254380.5105@hadrien>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr> <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr> <D2DCD2EA-E216-45D4-87F5-375C30F4AC76@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D2DCD2EA-E216-45D4-87F5-375C30F4AC76@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark D Rustad <mrustad@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Sat, 15 Jul 2017, Mark D Rustad wrote:

> > On Jul 15, 2017, at 1:07 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> >
> > Drop static on a local variable, when the variable is initialized before
> > any possible use.  Thus, the static has no benefit.
>
> I think in this case the use relies on the structure continuing to exist, so a stack object is not an acceptable substitute. Just because it is initialized doesn't mean that it doesn't need a persistent lifetime.

OK, I see.  Thanks for the feedback.  I'll extend the rule to ensure that
the address of the variable is not taken.  Ignore this patch in any case.

julia

>
> > The semantic patch that fixes this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @bad exists@
> > position p;
> > identifier x;
> > type T;
> > @@
> > static T x@p;
> > ...
> > x = <+...x...+>
> >
> > @@
> > identifier x;
> > expression e;
> > type T;
> > position p != bad.p;
> > @@
> > -static
> > T x@p;
> > ... when != x
> >     when strict
> > ?x = e;
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> > These patches are all independent of each other.
> >
> > drivers/mfd/twl4030-irq.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff -u -p a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> > --- a/drivers/mfd/twl4030-irq.c
> > +++ b/drivers/mfd/twl4030-irq.c
> > @@ -685,7 +685,7 @@ int twl4030_sih_setup(struct device *dev
> >
> > int twl4030_init_irq(struct device *dev, int irq_num)
> > {
> > -	static struct irq_chip	twl4030_irq_chip;
> > +	struct irq_chip		twl4030_irq_chip;
> > 	int			status, i;
> > 	int			irq_base, irq_end, nr_irqs;
> > 	struct			device_node *node = dev->of_node;
>
> --
> Mark Rustad, MRustad@gmail.com
>
>
