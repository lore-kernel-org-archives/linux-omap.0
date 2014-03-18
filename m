From: Felipe Balbi <balbi@ti.com>
Subject: Re: rts-gpio DT binding
Date: Tue, 18 Mar 2014 12:11:10 -0500
Message-ID: <20140318171110.GI14373@saruman.home>
References: <20140318165536.GH14373@saruman.home>
 <53287CAF.9040708@newflow.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50722 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044AbaCRRM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 13:12:58 -0400
Content-Disposition: inline
In-Reply-To: <53287CAF.9040708@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 05:04:47PM +0000, Mark Jackson wrote:
> On 18/03/14 16:55, Felipe Balbi wrote:
> > Hi Mark,
> >=20
> > I'm looking at the omap-serial driver and saw that you added rts-gpio
> > binding in commit 4a0ac0f55b18dc297a87a85417fcf068658bf103 (OMAP: add
> > RS485 support) but, as it turns out, gpio0_13 and gpio2_15 are both
> > actual RTS signals.
> >=20
> > Instead of adding that extra GPIO handling, why didn't you just mux
> > those signals as RTS and enable auto-RTS/auto-CTS feature ?
> >=20
> > It looks to me like that's highly unnecessary binding.
>=20
> I agree !!
>=20
> I think it was to allow delays pre- and post- sending the comms data.
>=20
> Several RS485 drivers require a "warm up" time before they will
> transmit data correctly, and also need a "cool down" time to prevent
> clipping of the last few bits of data.
>=20
> IIRC the built-in RTS handling did not allow for this.

you might be right here. I can't find anywhere to write rts delays.
Weird... digging TRM.

> It also allows the RTS signal to be "inverted", again required for
> some RS485 driver chips.
>=20
> However, I'll dig into why I did this and report back.

cool, thanks

--=20
balbi

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKH4uAAoJEIaOsuA1yqRExOoP/jPF2xIGeSSQ3xPjy6DYFLWn
9C5m8Rmw/jIWZ9rYI8+OoxrZ1iCGpStiFpCan9GLvsJb4rhhskFeJKtOPFph0Uk/
N4ZG4RxZzVCBuDCSl0zlNtXSqI7O40OftkrjGZFOBzPt/MYZsXg7hpx1IesRC7yn
E87Ho+0JSIUeLqMP8QEJQgKod/D+NfQIBUQClo5xG++L+5k5r22dzYZQt+VXXVNA
VnGI4aPzJPGCTyxg7NsdeobwdWrMpUH8prG88+H1tmGK9aq49ZZSWeUYlEBc0WkN
8NJ1v5kHXDrZt26iBwa2ULwYHpSEv51OjBzzp6186huy8fCCRl74iGkO8JgqNnIe
7O43WZnvrFedHqPqVm0r+jIoOH4NRMWLQ30wNMfYmUTEhtYDbrntU69lvMbmQjfL
PowNXL9l0np3pPbx2jQbFBdpgxW5EaiHq8qoaBGbidYv2OIV0oSx9aLRjPCp1Lj4
EPs1JtTyXXTWylXOGxzmdCoTt1Xvx20h1UEI2k3mI4UKExHKsOsyQc7m+tagzbHy
bEuMIcKn/00B7x211bpxBc5X9yYlfVLARJyk4ySK2ppHQQCKIfY5qa+dDcEGFL9v
v7DUx7kusadv8o5wlt+z5NYJpAhe3guS8HVli2lpgSqQPasDbu4odpCqGsWuiWCI
F3TNt0cigyTKBDAGyOze
=LzaY
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
