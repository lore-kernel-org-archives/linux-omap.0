From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
Date: Wed, 21 May 2014 18:17:10 +0300
Message-ID: <537CC376.5050501@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com> <20140521150231.GH17417@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="S26GnRe6hw8qJAvGVdNdkd2WwrJw6m4cM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47024 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbaEUPRg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 11:17:36 -0400
In-Reply-To: <20140521150231.GH17417@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--S26GnRe6hw8qJAvGVdNdkd2WwrJw6m4cM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/05/14 18:02, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:51]:
>> Hi,
>>
>> Here are the AM43xx and OMAP5 display DT changes again. I've sent the =
clock
>> related changes separately, and I removed OMAP5's RFBI node, which dep=
ends on
>> more clock changes. The RFBI driver doesn't work at the moment anyway,=
 so
>> removing the RFBI node should not be an issue.
>>
>> Tony, if these look fine (the rfbi change is the only one compared to =
the
>> previous versions), can you queue them for 3.16?
>=20
> Probably best that you do a late branch again after arm-soc dts changes=

> have been merged. Sounds like you have at least that macro dependency
> to omap-for-v3.16/dt-v2 so you should probably base your branch on

There are no dependencies that I know of. Which macro dependency is that?=


 Tomi



--S26GnRe6hw8qJAvGVdNdkd2WwrJw6m4cM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfMN2AAoJEPo9qoy8lh71fSMQAJl1ypYTuEdGQVIqD4IHO+jp
NmFD2rhox5M0+oo4nwkL+l9nrFIY+yEj1QXPRUsWZP7zFsUAYc+RM4YjZ7OM6GeA
1L33aSR2lWrwbBk+VBbK8i1v2NiSZY/MG2EmDO3kX6TLQfkkjSnkA8vh8Y6VfSdN
PrDTPNgS00RQ/efa3Su/kWoYAqBhgTeQ5Qw738S91fn3/jnsz2NjT78PMXbEkaz1
tf5SjHR9jMGCTze1r5AwHurHHah8/pjeZ1XUms7b+oeS/ztD8OGn0ARZQOAYe8zj
LnVY/FzaP+9n+50lM+PndDnyvHDRUUdBX3xb16pBWpd1O9N3glw9YPbn9QIndhWh
2kThHnpuv4vu9q8vLfeiyAlTC7S95c6PgDzAfTNisaWwyaL/neSTW6z3lo1hrQ4N
iMhQP/eaaInSSNOC6TRKmwGgUFvxbipAiYpQ/I+NuKNi4ielCiGL3PWGzd2DuTsO
fU1nhylpETbuQ1QBbl9ZNJMW08nG7S1ZuRzfscghZCzmFVW4jrBGRifaA+HoUu9C
1ugT0lNTs/WjcUj0sNurSATQoAOdhcy7pZx8aKeWuBjtqNYyEuik5AbzY5MZ9W51
uxHDeX3o4gEk70xYdJ5b1chrNewiZQEVEgMsoP6UxX/6LzbtLa8Rn/1qD68yoJcG
odqWY2sd4y44TLmARH5f
=12W+
-----END PGP SIGNATURE-----

--S26GnRe6hw8qJAvGVdNdkd2WwrJw6m4cM--
