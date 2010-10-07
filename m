From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: linux-omap/master is not booting up on OMAP3EVM
Date: Thu, 7 Oct 2010 18:22:18 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA21D126@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404AA21D110@dbde02.ent.ti.com>
 <AANLkTi=xKZH8vDUuM90461xnQ2_FRi_33U2tN_JNT+vq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53735 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760506Ab0JGMwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 08:52:25 -0400
In-Reply-To: <AANLkTi=xKZH8vDUuM90461xnQ2_FRi_33U2tN_JNT+vq@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Thursday, October 07, 2010 6:17 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: linux-omap/master is not booting up on OMAP3EVM
>=20
> Hi,
>=20
> On Thu, Oct 7, 2010 at 2:33 PM, Hiremath, Vaibhav <hvaibhav@ti.com> w=
rote:
> > Hi,
> >
> > Latest linux-omap/master branch is not booting up on OMAP3EVM board=
, I
> am using omap2plus_defcofnig without any changes.
<snip>
> > [ =A0 =A00.960083] omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq =3D=
 72) is a
> OMAP UART0
>=20
> You need to use ttyO0 for the console, since the new omap-hsuart is
> now used instead of the 8250 driver.
>=20
> I hope this helps!
>=20
[Hiremath, Vaibhav] Thanks, certainly this is the issue.=20

Thanks,
Vaibhav

> Jean
>=20
> > ; =A0=AE=B6=B6V=3D=AF=B0=A1=B3
> > =A0 =A0 =A0 =A0 =A0 =A02s14?=A04=AD=A5/0400=A8=C91=3D=B7=A0?=A0=B5!
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 2
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-=D5; =A0=AE7=A34=3D=AF=B0=A1=B3
> >
> > <Serial console goes for toss and dumps garbage here after>
> >
> >
> > Does anybody has seen such issues; any suggestion/help is helpful?
> >
> > Thanks,
> > Vaibhav
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
