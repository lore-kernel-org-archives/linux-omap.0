From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB lockups on BeagleBone/AM335x
Date: Thu, 20 Feb 2014 19:14:05 -0600
Message-ID: <20140221011405.GB19336@saruman.home>
References: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C07@SRVEXCH01.enatel.local>
 <20140220224902.GB10878@saruman.home>
 <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C96@SRVEXCH01.enatel.local>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52846 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbaBUBPc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Feb 2014 20:15:32 -0500
Content-Disposition: inline
In-Reply-To: <BCBA70ECF3E0284F86C53FAF9ED7FCA1426C96@SRVEXCH01.enatel.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Kimber <chris.kimber@enatel.net>
Cc: "balbi@ti.com" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(please avoid top-posting)

On Fri, Feb 21, 2014 at 12:11:40AM +0000, Chris Kimber wrote:
> Hey,
>=20
> Thanks for the response.
>=20
> I've disabled the DMA (CONFIG_MUSB_PIO_ONLY=3Dy) but the problem still
> persists (for both USB sticks & USB serial ports).

hmm, that's weird.

> Now it looks like dsps_interrupt() never fires and causes the hang
> up...
>=20
> [   94.865635] tty ttyUSB0: serial_write - 11 byte(s)
> [   94.865656] cp210x ttyUSB0: usb_serial_generic_write_start - length =
=3D 11, data =3D 54 45 53 54 49 4e 47 20 34 32 0a
> [   94.865680] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot 10
> [   94.865700] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 dev2 =
ep1out-bulk, hw_ep 10, ce43db00/11
> [   94.865721] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2 dev=
2 ep1out h_addr00 h_port00 bytes 11
> [   94.865740] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 count 11=
 buf ce43db00
> [   94.865755] musb-hdrc musb-hdrc.1.auto: Start TX10 pio
> [   94.865792] musb-hdrc musb-hdrc.1.auto: usbintr (0) epintr(400)
> [   94.865810] musb-hdrc musb-hdrc.1.auto: ** IRQ host usb0000 tx0400 rx0=
000
> [   94.865826] musb-hdrc musb-hdrc.1.auto: OUT/TX10 end, csr 2100
> [   94.865866] musb-hdrc musb-hdrc.1.auto: complete ce481e80 usb_serial_g=
eneric_write_bulk_callback+0x0/0xd4 [usbserial] (0), dev2 ep1out, 11/11

so the first one completed just fine.

> [   94.865971] tty ttyUSB0: serial_write - 11 byte(s)
> [   94.865991] cp210x ttyUSB0: usb_serial_generic_write_start - length =
=3D 11, data =3D 54 45 53 54 49 4e 47 20 34 33 0a
> [   94.866015] musb-hdrc musb-hdrc.1.auto: qh ce461a00 periodic slot 10
> [   94.866035] musb-hdrc musb-hdrc.1.auto: qh ce461a00 urb ce481e80 dev2 =
ep1out-bulk, hw_ep 10, ce43db00/11
> [   94.866055] musb-hdrc musb-hdrc.1.auto: --> hw10 urb ce481e80 spd2 dev=
2 ep1out h_addr00 h_port00 bytes 11
> [   94.866075] musb-hdrc musb-hdrc.1.auto: TX ep10 fifo d0832c48 count 11=
 buf ce43db00
> [   94.866089] musb-hdrc musb-hdrc.1.auto: Start TX10 pio

can you dump TXCSR, DEVCTL and IRQ registers when this happens ?

--=20
balbi

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTBqhdAAoJEIaOsuA1yqREuJoP/1ukk/EKdaYK5Ij4yrUaVf4C
sPgDxp3OAWtnY5n54C64luuJA5Bhtu31syT0W57DX4qUpvtyJQfqQ+nFiaC9UPmM
MQ8AJycVnAFOaiPjGUjoHFfXCsgzV9lTy9/8/BojgEG/tjqgyvaC5G1hkn7SjNPo
RaKjucokA54z6rMyBRNJNjWJGd2gJlAcv3VhN8KLbaE00KGIGzbXA3fX5kn3RYkj
Q3RLgqLVITsDTUT76TSXZKDmUnhT3who8tcyN3rr9xbhRamqeDQg3ZxFEYDyQ03R
4k+kQ1H/XviOmoBhZ6Q/CfFnMjWtM753amlOG6+nPF4lr/HuzHIk3om+leBlQ7/s
kTnPsYTQjkjGJsrpodF7kdB9WWcOLI7qkBRDOaXps00OurG5o8pJP+qbInqH52Rd
QegqEmYSGovjCA53NNDccp6NWhmAP3/4YnSuhEoDtuO7L/8rF4hkjbsp0gGOgeVN
7nKUTRN1xFDidjgF/X8gQ8wku7H0PvBBprrFxaLu+eZHHoTpXMtTnrlFXnlBBKbI
5bgaThUM6fUK+69NChYdg3qBq/0GzWSSN8RdxlPs2EgxEUgi1kqq0Sos5ToyMODq
zZIOSzB0R5bCQJjXVqqRuNl/SpaSgm4aE7Ubij9siufNVGo6PU1S/nQyZM7+7aDU
e9mMi8eRa9zcK7zcDukA
=VUhi
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
