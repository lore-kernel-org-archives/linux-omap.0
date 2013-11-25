From: Felipe Balbi <balbi@ti.com>
Subject: Re: Help needed to force USB host mode on AM335x CPU
Date: Mon, 25 Nov 2013 11:50:02 -0600
Message-ID: <20131125175002.GK18046@saruman.home>
References: <528F6A22.2070906@newflow.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48202 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949Ab3KYRud (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 12:50:33 -0500
Content-Disposition: inline
In-Reply-To: <528F6A22.2070906@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 22, 2013 at 02:28:50PM +0000, Mark Jackson wrote:
> We have a custom AM335x board where the USB0_ID pin has been left floatin=
g.
>=20
> By default, this puts the USB controller into peripheral mode, but we need
> to force it into host mode.
>=20
> This can be achieved in s/w by setting some bits in the relevant USB mode
> register (see TRM 16.5.2.35).
>=20
> This mode register's offset is already defined in musb_dsps.c
>=20
> static const struct dsps_musb_wrapper am33xx_driver_data =3D {
> ...
> 	.mode			=3D 0xe8,
> ...
> };
>=20
> I can manually set this register to the correct value in musb_host.c and
> the USB all seems to work as expected.
>=20
> int musb_host_setup(struct musb *musb, int power_budget)
> {
> 	int ret;
> 	struct usb_hcd *hcd =3D musb->hcd;
>=20
> /* Force HOST mode */
> unsigned long __iomem *p;
> p =3D ioremap(0x474010e8, 4);
> *p =3D 0x80;	/* IDDIG =3D 0, IDDIG_MUX =3D 1 */
>=20
> 	MUSB_HST_MODE(musb);
> ...
> };
>=20
> Ideally I'd like to add an entry in my dts file to flag for this "force m=
ode"
> to be setup, such as:-
>=20
> usb@47401000 {
> 	status =3D "okay";
> 	dr_mode =3D "host";
> 	ti,force-host;		/* force host mode */
> };
>=20
> Can anyone point me in the right direction as to where to put this extra =
code ?
>=20
> I see there's a musb_am335x.c file, but that just seems to be a wrapper.
>=20
> Any help would be greatly apperciated.

I just sent two patches to linux-usb and I suppose they can help. In
fact, I remember now that I have to fix commit log on one of them. I'll
do that now.

cheers

--=20
balbi

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk43KAAoJEIaOsuA1yqRENDMP/3M2X5WJiCooDEBFpFNFUb6+
UuFPsU8P7PJ2VlmoZ0w94yHFPFSms70KndBegCQfL5SECivysD9HyYoOWgd7LGyk
/J5p2+CXz7ly+PZxaMIdjptHGcZmdfgfvmgO5C4xR5lowwiW7J+MWqdlr30/0+vH
gX1ifacwB8eZVoNlz8PKJMme+O5debam8yiRDhG5eGuSwyjQ4bCe4rsDtJZPXNDI
UdHtjXUk9sWSNyNUN07QNAHOHhpoRzzO5s2AEMYAJethy0b/TyRi4O9+X73cKptv
vZ98CzP6depe9EHQ9lJyGaOylkynyki7ylNNJZbDyL22/HaMV57izMqQlr3BLF/b
HHGIkNF4s9nfMWpM3XBRKbO2sBZXUPo5/mdLUPyjy+vUHM1f5dUgHA0ktdc9wVmC
H5AoeFKjq+JaDimYJmDNJLxzfPLDdRxJGCOUdggOxX57S39FvTXblk65yt10Mxm/
MUUJOPjY+kfCugxDeTHNu5v06n5o6SsLHRPYoE4GfPDTZYHQz8IakVebqbSPDMPp
13cLncCvH3zU1fMzDT1WsuBRZrK02EKZJnm1eUxuJim2ma/mSYr797tCmGsgtmx+
NKX/g/SO2adGQ2ccT2EUWvzJ0hDJo2ZXRfUrA4ZEf5oHH0cMZLkdhGlycsgG823J
pIhhSS2i6ohZYLZs3FZa
=Qqq3
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--
