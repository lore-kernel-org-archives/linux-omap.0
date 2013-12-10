From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 11/15] mfd: menelaus: Start to use irqdomain
Date: Tue, 10 Dec 2013 18:37:49 +0000
Message-ID: <20131210183749.GC2390@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-11-git-send-email-balbi@ti.com>
 <20131210092050.GT12675@lee--X1>
 <20131210163430.GG22750@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:61642 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab3LJShy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 13:37:54 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so4141707yho.24
        for <linux-omap@vger.kernel.org>; Tue, 10 Dec 2013 10:37:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131210163430.GG22750@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> > > Introduce an irq_chip and irq_domain for menelaus driver. Followi=
ng
> > > patches will convert uses to traditional request_threaded_irq().
> > >=20
> > > While at that, some better error handling had to be added, so we =
could
> > > free irq descs we allocated.
> > >=20
> > > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  drivers/mfd/menelaus.c | 127 +++++++++++++++++++++++++++++++++++=
+++++++++++---
> >=20
> > <snip>
> >=20
> > > +	irq_domain_add_legacy(node, MENELAUS_NR_IRQS, irq_base, 0,
> > > +			&irq_domain_simple_ops, m);
> >=20
> > When will this driver become DT compliant?
>=20
> when OMAP2 becomes DT-compliant. It still boots with legacy board-fil=
e +
> platform_data.

Really? Tony, are there any plans to DT the platform?

=46elipe, what did you think about using irq_domain_add_simple()?

> > > +	m->irq_base =3D irq_base;
> > > +
> > > +	for (i =3D irq_base; i < irq_base + MENELAUS_NR_IRQS; i++) {
> > > +		irq_set_chip_data(i, m);
> > > +		irq_set_chip_and_handler(i, &menelaus_irq_chip,
> > > +				handle_simple_irq);
> > > +		irq_set_nested_thread(i, 1);
> > > +		set_irq_flags(i, IRQF_VALID);
> >=20
> > This assumes that this h/w only exists on ARM platforms. Is that tr=
ue?
>=20
> it was made *only* for Nokia to use on their ARM-only internet tablet=
s.

If the IP is genuinely not reusable, them I'm fine with it.

I see that the Kconfig is setup in the correct way too, so we're good.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
