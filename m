From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by
	uBoot)?
Date: Tue, 17 Jan 2012 08:54:44 +0000
Message-ID: <WC20120117085444.17057E@terrafix.co.uk>
References: <WC20120116100344.4204CC@terrafix.co.uk> <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com> <20120116105949.GG16726@n2100.arm.linux.org.uk> <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com> <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:58490 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752400Ab2AQIzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 03:55:13 -0500
In-Reply-To: <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>

=2E..snip...

> >
> Fair point. It will be harder to maintain and won't be consistent.
>=20
> >> Am not sure what you mean because secure API
> >> as such isn't a problem. If you mean one standard interface
> >> for all the ARM SOC's then that's something won't be
> >> easy to handled because it is tied up the security architecture
> >> which can vary across SoCs.
> >
> > The latter. =A0This is exactly the kind of pain I forsaw with this
> security
> > shite, and when I heard about it I was utterly dismayed at ARM Ltd
> for
> > coming up with such a brain-dead lack of design here.
> >
> > You're having to struggle with the results of that by having lots o=
f
> > SoC specific hooks all around the place to fiddle with this that an=
d
> the
> > other. =A0Your need to have something called from the early assembl=
y
> code
> > is just yet more of that disease caused by ARM Ltd's lack of forsig=
ht
> > on this matter.
> >
> > I have no solution for you on this
>=20
> I managed use some secure macro kind of code but as you said it
> will be really hard to maintain.
>=20
> So we are stuck with this issue then.

So, is the upshot of this that the kernel isn't going to be in a positi=
on to enable the L2/outer cache on OMAP3 (due to the need for hacky/unm=
aintainable code)?

Hence the bootloader/uBoot had better leave it enabled...

Cheers,
Joe

>=20
> Regards
> Santosh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
