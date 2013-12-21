From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Fri, 20 Dec 2013 16:53:09 -0800
Message-ID: <20131221005309.GH26054@atomide.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56830 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3LUAxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 19:53:15 -0500
Content-Disposition: inline
In-Reply-To: <20131219232153.GE707@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [131219 15:23]:
> On Thu, Dec 19, 2013 at 10:48:15AM -0800, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [131120 10:10]:
> > > Afte these patches, we're very close to being able
> > > to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c
> >=20
> > That would be nice :)
> > =20
> > > All which would be missing is for Tony to drop all OMAP2/3 board
> > > files so we remove the few pending bits and pieces left in
> > > for legacy boot.
> >=20
> > That may still need to wait a while, but let's see.
> > =20
> > > Note that I have only boot tested these on AM335x Bone Black
> > > (with a small fix for fixed regulator which should be in
> > > the mailing list already), so I'd need help testing all
> > > other impacted platforms, specially when it comes to PM.
> >=20
> > Sorry have not had much of a chance to test these with PM with
> > all the fixes needed for omap3 DT mode. Tried testing these
> > just now, but I get:
> >=20
> > arch/arm/mach-omap2/board-generic.c:134: error: =E2=80=98omap_intc_=
of_init=E2=80=99 undeclared here (not in a function)
>=20
> some of your other changes messed it up, I have not references of
> omap_intc_of_init() in my branch, because that's one of the things I'=
m
> dropping from DT-based boots.
>=20
> Can you see which patch added a new omap_intc_of_init() call ? Or may=
be
> tell me which branch I should rebase on top of ?

OK I tried against v3.13-rc4, it's the 3517 changes that caused
it. Looks like that can be just removed, and then there are some
trivial n8x0 merge conflicts. And n8x0 boots too.

But looks like omap3 off-idle hangs after hitting idle with these,
so a bit more work is needed. Maybe also rebase these against
omap-for-v3.14/dt too?

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
