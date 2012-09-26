From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] mtd: nand: omap2: Fix the nand-disk led trigger
Date: Wed, 26 Sep 2012 12:44:30 +0300
Message-ID: <1348652670.24309.52.camel@sauron.fi.intel.com>
References: <20120913150614.GC22993@renkinjitsu.usine.8d.com>
	 <CANOLnOOfwe1EvG1VHAZbtaC2xAD7_Rc6PqCWrs2cwEqauun8KA@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-UnR3GSraj77/MearMSNo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5572 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515Ab2IZJoY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 05:44:24 -0400
In-Reply-To: <CANOLnOOfwe1EvG1VHAZbtaC2xAD7_Rc6PqCWrs2cwEqauun8KA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org


--=-UnR3GSraj77/MearMSNo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-09-17 at 13:52 +0300, Grazvydas Ignotas wrote:
> On Thu, Sep 13, 2012 at 6:06 PM, Raphael Assenat <raph@8d.com> wrote:
> > When the omap2 nand flash driver is used, the nand-disk led trigger doe=
s not
> > work due to nand_wait_ready not being called.
>=20
> I think better solution is just to delete omap_wait() function, which
> is just a copy of nand_wait() without LED and oops handling. If
> waitfunc is not set by the driver, default nand_wait is used by the
> core.

Or if it does really need own wait function, we can re-work the internal
api similarly to what we did to MTD api. Instead of calling
'chip->waitfunc()' directly from everywhere, have a wrapper
'nand_wati()' function, which can do things common to all drivers, and
then actually call the underlying '->waitfunc()'. So in this case, it
can do the LED stuff.

--=20
Best Regards,
Artem Bityutskiy

--=-UnR3GSraj77/MearMSNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQYs5+AAoJECmIfjd9wqK0P0AQALIemvybZnyRbJp+f7wBMe9E
uwy4rgiKY83wqiKYzJ/mi04sWaxSpl2AhqL7LFDjfRAoAwe1u4viKIOMxyC17nOd
DV69eyfpE202SjLofQlbUSpmnxOXndmZDfXYSXKXcj7fm3Q2HP6GOB18fc7gsvor
4WhFaYP3gc2GgXemJT6r53093bBvp2gzZ4yvgUEfDPwbAKf0O+t1FzWwQFt1woo5
/KwBcVKMVwQjNpBupnn0j28I8DL0es5KGjqcmEX4qSBrY5/7TSLNFTFejjRrKkeX
CgaWJ6zlAo7qhc13UThSofT8Hlm7i8lNYCnDTT+Q8y/Ywy9fRA1qoLkE/IkHQTkM
Akj/NINNcvAqcaI2xIsfoUuEyILZcFUepmu1RUk62umwV88RoVGsSvh9kIZfxZ9N
Nv0Rz7SrtoojFlRdibIiRLjaX0riwREv2XW2xG+iwTPEZRFFcMfC5P4okJYuAyab
Fd+HEmqHJ3tAtrLV64PnyZbReiq+gl+gU/VY0mZdorENDDJhXhEkpBWiEF4PP2z8
g1V6BPQmxmBzFMQwgXzHSA5WtuNH8OMctC90eBVMVSvDjMW817dyxIDA9R+YgCCV
3xi2CknL7ng5lEMBb6oWJ716/EJ/tdIplKchZ1bQTnMQ+b+jkvubYGI4VHmablR5
sKTvx9rf9W9hC4i4xA7r
=JrcH
-----END PGP SIGNATURE-----

--=-UnR3GSraj77/MearMSNo--

