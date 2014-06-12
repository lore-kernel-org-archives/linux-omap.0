From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 08/19] irqchip: crossbar: fix checkpatch warning
Date: Thu, 12 Jun 2014 07:18:31 -0700
Message-ID: <1402582711.9947.17.camel@joe-AO725>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
	 <1402574007-13987-9-git-send-email-r.sricharan@ti.com>
	 <20140612131042.GU8664@titan.lakedaemon.net> <5399AC9C.4080602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5399AC9C.4080602-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2014-06-12 at 19:05 +0530, Sricharan R wrote:
> On Thursday 12 June 2014 06:40 PM, Jason Cooper wrote:
> > On Thu, Jun 12, 2014 at 05:23:16PM +0530, Sricharan R wrote:
> >> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
[]
> >> @@ -34,7 +34,8 @@ struct crossbar_device {
> >>  	uint *irq_map;
> >>  	void __iomem *crossbar_base;
> >>  	int *register_offsets;
> >> -	void (*write) (int, int);
> >> +
> >> +	void (*write)(int, int);
> > 
> > The empty line here looks bogus to me.

Good eye.  It's unnecessary.

>   Did you re-run checkpatch after
> > fixing the unnecessary space to see if it still complained about having
> > a 'blank line after declarations'?
> > 
>  Yes, it still complains even after fixing unnecessary space.

It's a checkpatch defect.

It's been fixed by:
https://lkml.org/lkml/2014/6/6/426

> > I'm generally opposed to these sorts of checkpatch patches, especially
> > when they are just warnings.  It's great for a new driver in the staging
> > tree, but it makes backporting future bugfixes that much harder when
> > drivers have been live in mainline.

Blind adherence to checkpatch isn't always a great idea.

But bugfix backports haven't been much of an issue in
other subsystems with fairly active whitespace/style
changes.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
