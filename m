From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] [OMAP] gpio: Allow for extended GPIO space
Date: Mon, 29 Nov 2010 11:37:37 -0800
Message-ID: <20101129193737.GH17222@atomide.com>
References: <1279598741-18607-1-git-send-email-darkstar6262@gmail.com>
 <1279598741-18607-2-git-send-email-darkstar6262@gmail.com>
 <20100802105150.GB12293@atomide.com>
 <AANLkTinCxh39iLjVnmc0=VVE8aQahpo9XMjg0B7CiffW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30077 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab0K2Thp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 14:37:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinCxh39iLjVnmc0=VVE8aQahpo9XMjg0B7CiffW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [101125 07:23]:
> On Mon, Aug 2, 2010 at 4:51 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > * Cory Maccarrone <darkstar6262@gmail.com> [100720 06:59]:
> >> This change copies from the s3c24xx the ability for a board to spe=
cify
> >> if it wants 64 or 128 more GPIOs in the board space. =C2=A0This is=
 needed
> >> to get the HTC Herald board's extra htcpld gpios to work as actual
> >> gpios.
> >
> > <snip>
> >
> >> +config OMAP_GPIO_EXTRA
> >> + =C2=A0 =C2=A0 int
> >> + =C2=A0 =C2=A0 default 128 if OMAP_GPIO_EXTRA128
> >> + =C2=A0 =C2=A0 default 64 if OMAP_GPIO_EXTRA64
> >> + =C2=A0 =C2=A0 default 0
> >> +
> >> +config OMAP_GPIO_EXTRA64
> >> + =C2=A0 =C2=A0 bool
> >> + =C2=A0 =C2=A0 help
> >> + =C2=A0 =C2=A0 =C2=A0 Add an extra 64 gpio numbers to the availab=
le GPIO pool. This is
> >> + =C2=A0 =C2=A0 =C2=A0 available for boards that need extra gpios =
for external devices.
> >> +
> >> +config OMAP_GPIO_EXTRA128
> >> + =C2=A0 =C2=A0 bool
> >> + =C2=A0 =C2=A0 help
> >> + =C2=A0 =C2=A0 =C2=A0 Add an extra 128 gpio numbers to the availa=
ble GPIO pool. This is
> >> + =C2=A0 =C2=A0 =C2=A0 available for boards that need extra gpios =
for external devices.
> >> +
> >
> > Let's wait on this and the following patch a a little, I believe th=
ere
> > are already patches in the works to deal with this for the multi-ar=
m
> > support. So this should get solved eventually in a generic way.
> >
> > Regards,
> >
> > Tony
> >
>=20
> Has anything happened with this recently?  I haven't been keeping up
> too much, and I notice the latest linus-tree kernel still needs these
> patches (or something similar) for me to be able to use the htcpld on
> herald.

Well I'm working on a patch series that combines all mach-omap1 defconf=
igs
into one, still need to sort out few places to make it work.

That means we must be able to compile in all the needed options without
breaking things, so let's not make this a Kconfig option. Or at least
it should be possible to enable it for all mach-omap1 machines.

AFAIK, you should be able to just define it the same way as TWL4030_IRQ=
_BASE
in arch/arm/plat-omap/include/plat/irqs.h, maybe based it on
CONFIG_ARCH_OMAP7XX?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
