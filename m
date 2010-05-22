From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Re: omap_musb_board_data -- trouble specifying 500mA supply
Date: Sat, 22 May 2010 09:58:59 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E6162B3@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044E3514C2@dbde02.ent.ti.com>
 <806509.34149.qm@web180310.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39905 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab0EVE3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 00:29:10 -0400
In-Reply-To: <806509.34149.qm@web180310.mail.gq1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Linux OMAP Users <linux-omap@vger.kernel.org>
Cc: Cliff Brake <cliff.brake@gmail.com>

Hi,

> > > >> We are designing a custom OMAP board that
> > will have a 500mA supply on
> > > >> the OTG port.=A0 It looks like the power
> > is set with:
> > > >>
> > > >> struct omap_musb_board_data {
> > > >>=A0 =A0 =A0=A0=A0u8
> > =A0 =A0 interface_type;
> > > >>=A0 =A0 =A0=A0=A0u8
> > =A0 =A0 mode;
> > > >>=A0 =A0 =A0=A0=A0u8
> > =A0 =A0 power;
> > > >> };
> > > >>
> > > >> However, with a u8, the max value is
> > 255.=A0 Should power be changed to a
> > > >> u16?
>=20
> No.  The units are "2mA" not "1mA", matching the USB specs.
>=20
> So to specify 500mA (the max), say "250" ...

David,
Actually in OMAP board files, power values have been provided
With units of 1mA which gets divided to half in
arch/arm/mach-omap2/usb-musb.c before sending it to musb driver.

-Ajay =20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
