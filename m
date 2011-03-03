From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 01/17] omap4: pm: Add omap WakeupGen module support
Date: Thu, 3 Mar 2011 21:34:23 +0530
Message-ID: <61680f5ee8942ca702a9edd3496c3090@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-2-git-send-email-santosh.shilimkar@ti.com>
 <87hbbl8aaz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38278 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887Ab1CCQE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:04:26 -0500
Received: by qyj19 with SMTP id 19so39qyj.16
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:04:24 -0800 (PST)
In-reply-to: <87hbbl8aaz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 3:17 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 01/17] omap4: pm: Add omap WakeupGen module
> support
>
[...]
> > +
> > +static inline u32 cpu_readl(u8 idx, u32 cpu)
>
> Minor nit: the cpu_ prefix is too generic, how about wakeupgen_ or
> wugen_?
>
Done. I used wakeupgen_ prefeix.

[...]

> > +static void _wakeupgen_set_all(unsigned int cpu, unsigned int
> reg)
> > +{
> > +	u8 i;
> > +
> > +	for (i = 0; i < NR_BANKS; i++)
> > +		cpu_writel(reg, i, cpu);
> > +}
> > +
> > +static void _wakeupgen_set(unsigned int irq, unsigned int set)
>
> I (still) don't like a single "set" function, especially when it
> takes a
> "set" argument.
>
> Make separate set and clear functions, with the common stuff in a
> helper function like _wakeupgen_get_irq() or something.
>
Done.

[...]

> > +
> > +#ifdef CONFIG_PM
>
> I think this should be CONFIG_SUSPEND
I don't see any body using "CONFIG_SUSPEND".
set_wake() seems to be under CONFIG_PM, so I
am retaining as it is.
>
> > +/*
> > + * Architecture specific set_wake extension
> > + */
> > +static int wakeupgen_set_wake(struct irq_data *d, unsigned int
> on)


> > +	/* Static mapping, never released */
> > +	wakeupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
> > +	BUG_ON(!wakeupgen_base);
>
> A WARN_ON() with a graceful exit is more appropriate here:
>
Done.

Regards
Santosh
