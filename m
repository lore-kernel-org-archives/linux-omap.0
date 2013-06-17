From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 Panda DVI problem
Date: Mon, 17 Jun 2013 14:27:59 +0300
Message-ID: <51BEF2BF.3000104@ti.com>
References: <51BB201C.3000605@ti.com> <51BEC4D7.2080903@ti.com> <20130617111834.GR20992@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2MOBJMXMHHPTHOFXFXKXX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320Ab3FQL2D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 07:28:03 -0400
In-Reply-To: <20130617111834.GR20992@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

------enig2MOBJMXMHHPTHOFXFXKXX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/06/13 14:18, Tony Lindgren wrote:

> You should be able to get the regulator based on the name just fine
> from the drivers even if one driver is using DT and one is not. That is=

> as long as the regulator is defined. Then the regulator fwk will track
> the usecount properly.

Doesn't the regulator need to be "bound" to a device for the driver to
use the proper name for the regulator? I mean, in this case the dvi
driver wants to get a regulator named "vdd_5v" (or something like that,
I'm not sure what's the proper name). The USB host driver uses a name
"vcc", while the real name of the regulator is "hsusbX_vcc".

If DVI driver wanted to use the regulator, it'd need to get
"hsusbX_vcc". Which, I presume, would work, but is board specific and
hacky, and it makes handling EPROBE_DEFER a bit more difficult.

Then again, maybe that's still simpler than making the regulator
always-on, as there are complications with that approach also, which we
are currently studying.

>>> So I think the simplest solution is to make DC_HST_5V always-on. This=

>>> should be fixed for 3.10 also.
>>
>> I am fine with this.
>=20
> For a short term fix I'm fine with that, but please investigate using
> the regulator, it might be simpler than you think.

I'll have a look, maybe there's something I'm missing.

 Tomi



------enig2MOBJMXMHHPTHOFXFXKXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRvvLAAAoJEPo9qoy8lh710FMP/RB3tw91dPyQXVA/nxV5aMqu
/l3PgewbEwcK8MgCwUI6SQp7QHwaxPIkZUPTgkFRQcFuhW2VyE8qKtL+eUSW0qMP
r2TaLTLYAiCi9cHJf/iNrtvP5fVvU0Zbvyz3FsFe/6e4gDudJEhtxl3eO5Aboz5v
vJFVpzJqniYCcBSwzMTNylfBsp+dUgd7JXhzXFmGFTDMJimgczDM6ACGY3aikdRP
LXVoPwQh9zL2xsojoxGHeSDZOWheV30XBDHAgcBJa50yuLqREwF2mRxgN+Ht3cok
EwerrLvlIoGAIj/ho+hqspNzQajlXv3Orh8onvQh7TdqVvZ/xA8mg3a2y9UDLCVI
VP34iKPdMqIfXnokoh82sylzoSVkjx4cyzLTV/T8G3GC/fTgJ8Rt7/0wLOAKIL0H
So8x8RGy7hMb2w1FizjEtNd9Piy9m3vA4lsxhZaxy+H1DXHs+1c6ZCmSvrOj0A3/
j5vloPWbsJ1hJYn8wichdrQ189ozEEuUgCipNSdw212UIG0Yxtf7bMbj5RmVNR35
HbgIy+YuFYDrhzNeMG0w2uXd6pmtOB/xuUJI37QaO3O2B9McZ9zTWtKQ+B0v1NPy
O1NQH7SIjKFgCVjOK9YKI1GhnOO+vOOB9ux/hlBNl0PalcFu/hvERvCK9NoQwoLN
BxcIvCyLWaJu2sJwuU8L
=HU42
-----END PGP SIGNATURE-----

------enig2MOBJMXMHHPTHOFXFXKXX--
