From: Felipe Balbi <balbi@ti.com>
Subject: Re: rts-gpio DT binding
Date: Tue, 18 Mar 2014 12:18:41 -0500
Message-ID: <20140318171841.GJ14373@saruman.home>
References: <20140318165536.GH14373@saruman.home>
 <53287CAF.9040708@newflow.co.uk>
 <20140318171110.GI14373@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52520 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbaCRRU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 13:20:29 -0400
Content-Disposition: inline
In-Reply-To: <20140318171110.GI14373@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Jackson <mpfj-list@newflow.co.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Tue, Mar 18, 2014 at 12:11:10PM -0500, Felipe Balbi wrote:
> On Tue, Mar 18, 2014 at 05:04:47PM +0000, Mark Jackson wrote:
> > On 18/03/14 16:55, Felipe Balbi wrote:
> > > Hi Mark,
> > >=20
> > > I'm looking at the omap-serial driver and saw that you added rts-gpio
> > > binding in commit 4a0ac0f55b18dc297a87a85417fcf068658bf103 (OMAP: add
> > > RS485 support) but, as it turns out, gpio0_13 and gpio2_15 are both
> > > actual RTS signals.
> > >=20
> > > Instead of adding that extra GPIO handling, why didn't you just mux
> > > those signals as RTS and enable auto-RTS/auto-CTS feature ?
> > >=20
> > > It looks to me like that's highly unnecessary binding.
> >=20
> > I agree !!
> >=20
> > I think it was to allow delays pre- and post- sending the comms data.
> >=20
> > Several RS485 drivers require a "warm up" time before they will
> > transmit data correctly, and also need a "cool down" time to prevent
> > clipping of the last few bits of data.
> >=20
> > IIRC the built-in RTS handling did not allow for this.
>=20
> you might be right here. I can't find anywhere to write rts delays.
> Weird... digging TRM.

hmm, you can change RTS value manually if you don't use auto-RTS. Just
write MCR BIT(1) to toggle that line.

The "warm up" time you mention, however, can be coped with by means of
RX FIFO trigger level. TRM mentions that far end could send another byte
after RTS has been deasserted. So if we set RX trigger level to always
have room for one extra byte, then we will never loose data and the
"warm up" time is probably negligible.

Am I missing something ?

--=20
balbi

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKH/xAAoJEIaOsuA1yqRE+0QP/RH8mvZIKZOJqD3zeWXk/SrM
cBOti5//uD8IQzoeVqj6i/sqVIt0amOyq6l5BDb0YiBR2en4lmCWzCz8JDE7lr7m
ksoJXSYnvRWuJXe+/rOhJv64h40dDPypePAMAj6QKhEJH6WaPu5EY2zUmjNsz26j
cM9n3Z+vUD0HpYbEkYX8D4qTVoy9fJP7zBUuFi8F+phOw00QBrJD3RWqChZr/vIq
epzR+yr5j+n+k4NdEHeMXAnbztN6jngjubSA1rQmJqzlDbskgajTneMNOYswC9Lf
BrG9b1WqATE7LSt2tI3wPD/xTLIiPT61a6DudInSLOeA9EkoX47eVJGOJqN9Fuy0
cIla84n1rd8dZfMixTl2Urjg3Cbn7A0xE4BT7fqyxqyobjHSXcF+leeOqkzTjsyW
jZ1rbL/ng6tY8v712hKvqgO6f+BQCJWCLA34KJuDv6gvcdj5SrFlbz2X6RBTkhly
ag4s6zbAMn7oQjvnXFejkO28AIUk4ROPI1grxl9qUGhqMY4WkJrppfDQ+Q/Lsbr6
rhtezNl1bHxDt9NtMNRQuUEuN46s3iO87NiPJNBL4aT9t7orWtQkjS1rPnbPmNO9
5IN4QjBftCJnAVnnBPZbV4ZFPoAYxpMmVaWdbIkaC4HV7OBvME16SBXtl/f6Wcik
OxvP86f7JUsurLWCDH3u
=Mo1m
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
