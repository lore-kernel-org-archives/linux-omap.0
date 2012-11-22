From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAP: DSS: panel-n8x0: register the DSS driver after
 SPI probe
Date: Thu, 22 Nov 2012 17:21:42 +0200
Message-ID: <50AE4306.60203@ti.com>
References: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi> <1353527332-5216-2-git-send-email-aaro.koskinen@iki.fi> <50AE1831.90308@ti.com> <20121122151728.GA13187@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0588237FB834D5C088BA2C36"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411Ab2KVSiN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 13:38:13 -0500
In-Reply-To: <20121122151728.GA13187@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig0588237FB834D5C088BA2C36
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 17:17, Aaro Koskinen wrote:
> On Thu, Nov 22, 2012 at 02:18:57PM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 2012-11-21 21:48, Aaro Koskinen wrote:
>>> Register the DSS driver after SPI probe. This simplifies the
>>> initialization. This is similar to what is being done e.g.
>>> in panel-acx565akm.
>>
>> Is this a fix? The description sounds like it's just a cleanup.
>=20
> Yes, it's a cleanup. I should have sent it separately, sorry.

Ok. Did you actually manage to test it? I haven't tested N800 for ages,
as I don't have a serial console for my N800, and last times I've tried
I didn't manage to get it to boot.

>> The first patch in the series needs to be sent for the next -rc, right=
?
>=20
> Yes, it's fixing regression. There are OMAP2 boards with display
> configured (e.g. board-apollon) and those will see probe failing.

Ok, I'll queue it for next -rc.

 Tomi



--------------enig0588237FB834D5C088BA2C36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrkMGAAoJEPo9qoy8lh71/VYP+wSN8k9BNy9A8QT9hh94hdFV
EOohjUgPhtvrHRIU1EUKrf2RHwF5zLXrmibF5uF52DsFEj2GNo9tJ+uFWPkntIBf
aQZ4+b5d/shjpXwBijSHXtaLCadBQYgaXrXOeAn+cX5H06ojqmc4/RmzZtf8Fdtq
Mjs8lW2HW94QLmmBSAyLSGb4MeyDBwLEOAQaRhsFIrvp4Eco89Sfwe2hEnuCIPAS
2pjmFa8JVhVKb2KxuV7uW2/qOKmW1/SwaBfLt88m9iaUyjE4lTHeQW71SIQxILx5
MLTRdgl61KnZ10rp8m+4IO7uB9MlbsreqNjbLm0Ufoc+aHbCY6zOr8TFdWEHKzCW
EhnsSE3Udt5IyTUP4j6fDP1e740BKLCp5yjx6fXKa7sxpfayREOLhh0SfryPA7Nc
gJYxYLgc55FfEN8Vmz7wuNcA175Ek5LmBiOBPp4hV2g4VqtWQRrCh9gZs5Z/8zNC
V1G84lf7hjs0PdOVoO4rTKdyQZm39xuLTPf4hdvHc43OFWtHCUo5vbUTCSvF9CdI
bl4zlBRRqzVBJoyl6uY73EzE9MK6BWhFcNF1BfauY1X03Uo92tMcB615UUClf/D2
JIwsHwimByi8d0IIsKP9/Dnab3qXtSUxsSXgX5iFneoEcf9xx0QfoasbSWTQYjRi
Vq25/jBuJyvkaos3l6ts
=euBq
-----END PGP SIGNATURE-----

--------------enig0588237FB834D5C088BA2C36--
