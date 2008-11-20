From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix section mismatch warning.
Date: Thu, 20 Nov 2008 14:55:29 +0200
Message-ID: <20081120125529.GE7476@gandalf.research.nokia.com>
References: <1227102749-19536-1-git-send-email-premi@ti.com> <200811191626.02717.david-b@pacbell.net> <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C6E5@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39816 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbYKTM4A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 07:56:00 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C6E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Nov 20, 2008 at 06:14:55PM +0530, ext Premi, Sanjeev wrote:
>=20
> > -----Original Message-----
> > From: David Brownell [mailto:david-b@pacbell.net]=20
> > Sent: Thursday, November 20, 2008 5:56 AM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] Fix section mismatch warning.
> >=20
> > I know that Beagle and Overo get the same warnings, so this=20
> > isn't really a sufficient fix...
>=20
> Was trying to fix for EVM. Can extend to these boards once we have a =
fix.
>=20
> >=20
> > On Wednesday 19 November 2008, Sanjeev Premi wrote:
> > > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > > @@ -130,7 +130,7 @@ static struct twl4030_madc_platform_data=20
> > > omap3evm_madc_data =3D {
> > > =A0=A0=A0=A0=A0=A0=A0=A0.irq_line=A0=A0=A0=A0=A0=A0=A0=3D 1,
> > > =A0};
> > > =A0
> > > -static struct twl4030_platform_data omap3evm_twldata =3D {
> > > +static struct twl4030_platform_data __initdata omap3evm_twldata =
=3D {
> >=20
> > ... and that's incorrect in any case, since that data is used=20
> > by probe() code that's doesn't sit in an init section.

__initdata_or_module would do the trick for static and dynamically
linked modules. When building it statically, we'd get a bit of
shrinkage, right ?

> Function probe() would be in __devinit. Changing __initdata to __devi=
nit
> would be fine for compilation. Do you see any issues with it?

doesn't make sense.

> BTW, I could not locate the definition of platform_driver for twl4030
> to verify if probe() is indeed in __devinit.

It's in drivers/base/platform.c

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
