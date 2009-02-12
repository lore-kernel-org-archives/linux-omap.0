From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Wed, 11 Feb 2009 17:55:26 -0800
Message-ID: <200902111755.26856.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <200901261523.42769.david-b@pacbell.net> <20090212012359.GH13748@atomide.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:48411 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757744AbZBLBz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Feb 2009 20:55:29 -0500
In-Reply-To: <20090212012359.GH13748@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: me@felipebalbi.com, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 11 February 2009, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [090126 15:23]:
> > On Sunday 18 January 2009, Tony Lindgren wrote:
> > >=20
> > > > > #if =A0 =A0 !defined(CONFIG_ARCH_OMAP730) && \
> > > > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP15XX) && \
> > > > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP16XX) && \
> > > > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP24XX) && \
> > > > > =A0=A0=A0=A0!defined(CONFIG_ARCH_OMAP34XX)
> > > > > #error "Power management for this processor not implemented y=
et"
> > > > > #endif
> > > >=20
> > > > I didn't realize anyone outside of TI had their hands
> > > > on OMAP4 chips yet. =A0:)
> > >=20
> > > Might be worth looking what it would take to make dummy CONFIG_PM
> > > compile in mainline for mach-omap2.
> >=20
> > This (against mainline) makes build+link work ...
>=20
> I'll add it to omap-fixes. Dave, can you please reply with your SOB?

Special offer, today only ... take your pick:

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Sonofabitch: David Brownell <dbrownell@users.sourceforge.net>

:)


>=20
> Thanks,
>=20
> Tony
>=20
>=20
> > ---
> >  arch/arm/plat-omap/include/mach/pm.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > --- a/arch/arm/plat-omap/include/mach/pm.h
> > +++ b/arch/arm/plat-omap/include/mach/pm.h
> > @@ -108,7 +108,7 @@
> >  	!defined(CONFIG_ARCH_OMAP15XX) && \
> >  	!defined(CONFIG_ARCH_OMAP16XX) && \
> >  	!defined(CONFIG_ARCH_OMAP24XX)
> > -#error "Power management for this processor not implemented yet"
> > +#warning "Power management for this processor not implemented yet"
> >  #endif
> > =20
> >  #ifndef __ASSEMBLER__
> >=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
