From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Request for OMAPDSS testing
Date: Thu, 13 Jun 2013 19:01:02 +0300
Message-ID: <51B9ECBE.3010401@ti.com>
References: <51AD99F5.7060506@ti.com> <51B9EA7B.8070906@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2MVRUEPLFELWAMOIXWHVI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48961 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab3FMQBW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 12:01:22 -0400
In-Reply-To: <51B9EA7B.8070906@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

------enig2MVRUEPLFELWAMOIXWHVI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/06/13 18:51, Igor Grinberg wrote:
> Hi Tomi,
>=20
> On 06/04/13 10:40, Tomi Valkeinen wrote:
>> Hi guys,
>=20
>> I've made some big changes on the omapdss device model, which involves=

>> converting all the panel drivers. I've got only a bunch of boards, so =
I
>> hope some of you can perhaps do some minimal tests on some other board=
s.
>=20
>> I've got: Beagle (old one), Panda, 4430SDP, Overo with LCD43.
>=20
>> The code can be found from the below git branch. It's based on 3.10-rc=
1.
>=20
>> git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
>=20
> Works on cm-t3730.
> Tested with tdo24m LCD and DVI.

Thanks!

> Although one thing is missing from the tfp410 driver is
> the PD GPIO polarity. I had to adjust it locally to get the DVI working=
=2E
> The original polarity was high =3D disabled, low =3D enabled.

Hmm, but this is missing from the old driver also, isn't it? At least
with a quick glance the old and new tfp410 drivers do the same thing
with the PD gpio.

 Tomi


------enig2MVRUEPLFELWAMOIXWHVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuey+AAoJEPo9qoy8lh71ArkQAKUtnZwU0GFiElFWEfZI2uFn
pz8URet3WOfHOrogCvwaK7ILRj4BS3THsPYHtWiNx4k+XAk5qD1N81Xvi2o7Z8wB
Yq0F7FPrj6BUiGj5Jgw66Nj8IJjF6UvvVl2Fx/BtLclpiUmkRYvfvtoJevuitnc+
tS4zKwCLJVm6cWD3YoRfqlczMmI4X4fU2ASTw+9Q2y1yeoYdmURTqo9NtMIwMhBY
qTKn0U7fpi4sVyMEFl3Xzkfc8I93tVsZKwDdQqBFhPgbduhdPsrFFpJHjR+Ch+Gx
aY4j4GotofFrY2xNnrNgi9icc0zbRYhEXxUV/EGQq2GUDP8xEuVmlCGucuxTS00z
1UC4zkvLo1J93HBKIeX24HMzPGUWP7C15Tr9Vnl7HI4RQf4RAZouen8JSHRX/eWa
sx94Gf4L7JEI0wcBLhEox63nxytdT7z6MGHtwJcHk+MduIBfU3zMOsFK0HVXTilM
wdhUPLZmmOu76eXPaqoVVPdrJmkD+QNLE4OyDofISPcDY5Q77c68jp/cDHwyVTqI
gyL7WbN3OuFeny6StIFpDS5OGuz+9+JfzeWiXaeGzsp3FpIB+c9NQ3JH0Fu/3s2N
sRToNcsnVvY+IFpTtuchJ11bGNvvbT2vZPYwAq76jqd+DLwhXABqXN8hcKpjkch2
v7vZ0VFnKXl4zWvccahM
=rPnU
-----END PGP SIGNATURE-----

------enig2MVRUEPLFELWAMOIXWHVI--
