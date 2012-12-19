From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 13:21:47 +0200
Message-ID: <50D1A34B.8030308@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net> <50D1A2BC.4040605@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig42D387350A41E0F00D4EC3B7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47802 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2LSLVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 06:21:51 -0500
In-Reply-To: <50D1A2BC.4040605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

--------------enig42D387350A41E0F00D4EC3B7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 13:19, Tomi Valkeinen wrote:
> On 2012-12-19 12:51, Peter Meerwald wrote:
>> Hello,
>>
>>> In the case we set it to 4, the DISPC_FCLK is fast enough to do the r=
equired
>>> downscaling, but in the case when it's set to 0, it might need to pre=
 decimate
>>> rather than try to scale.
>>
>> this is my understanding as well
>>
>>>> I think there is a bug downscaling YUV data when resorting to
>>>> pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a workar=
ound
>>>> -- any ideas how this can be fixed?
>>
>>> Pre-decimation should work for YUV formats also. Could you share DISP=
C reg
>>> dumps when this happens:
>>>
>>> mount -t debugfs debugfs /sys/kernel/debug
>>> cat /sys/kernel/debug/omapdss/dispc
>>
>> please find the files http://pmeerw.net/ok.dispc (with FCK_PER_PCK=3D4=
) and=20
>> http://pmeerw.net/fail.dispc (FCK_PER_PCK=3D0)
>=20
> Something funny is going on here. I can reproduce on omap3 with a few
> hacks that reduce the clocks. The PICTURE_SIZE's width field is
> different for working and non-working cases, but I think it should be
> the same for both.

Ah, never mind. Of course the picture_size needs to be modified if
predecimation is used...

 Tomi



--------------enig42D387350A41E0F00D4EC3B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0aNLAAoJEPo9qoy8lh71NlMP/R3DnphDk6t1xjf0FkrOPXnp
P/olJac/GF9tmciddMdmD7gJyLpYaeI/5oEU2k7ylhd5QHf5jizz3kHZdKjAtxRC
SF3wuFpVROZzyn9zRpXkt1Gu12K4Y5wcviCgwMSvnTnEXqNsySmdRBRc8zhHI6zi
QBMT8CjP9IOrsLAouNT96eFYlzDgQsF1LRtAf8GSZWu/Bmq+OtOqIkFAqHkWiJBw
kCPvnkpFuSBdyjlKBb07G9tJXKn1WW+KjY4DpIAG1Bjl2j+76WmRL6160SfK5+tY
fVktEsUqN5COhU/E3OoM8rYnyCfRqLX4ilrsJMCR0TqS4blrf7yeyMNaoX+YnwA9
z1yKhIY8m6v3pgjA5BTAa+KZ2yxxutJSivw5E3yK6oid/Svommd2oTGEUIrfg963
7nlBq8LExAIVFxqRifC9WcWkGtEwmg//N2DcVAyF054hiJPYm34fG1gntIC0HbAz
CBfxjMwLDT76YaTC313KtyZs8WPaPQfaIYPWF5ZWfn8H6c5rUDvWXQKgiRdKlUj/
vFE1KqS1AwsnP3ifyJTojdlNkFZttyNev5loSPnQfyNzBQkoqMzQA8e4fIw+mro4
Av27DwCgVNPunb7mItds/gqrUzDbmXnJsn3XUMmI4oCRQGaOegOo1m0Kj0bEzWsp
0Aj/akVy8Bx9OTO8GKz9
=hXy9
-----END PGP SIGNATURE-----

--------------enig42D387350A41E0F00D4EC3B7--
