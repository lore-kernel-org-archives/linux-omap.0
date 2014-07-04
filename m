From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] SiI9022 HDMI encoder for AM4xxx boards
Date: Fri, 4 Jul 2014 11:02:57 +0300
Message-ID: <53B65FB1.5020901@ti.com>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com> <87k37u7bp5.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BHvgkEVcAxpdG7S5NU41qDQL688NiQD9V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45887 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbaGDIDq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jul 2014 04:03:46 -0400
In-Reply-To: <87k37u7bp5.fsf@lebrac.rtp-net.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--BHvgkEVcAxpdG7S5NU41qDQL688NiQD9V
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/14 17:34, Arnaud Patard wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>=20
>> Hi,
>=20
> Hi,
>=20
>>
>> This series adds a driver for SiI9022 HDMI encoder, which is used on A=
M437x GP
>> and AM43x EPOS boards.
>>
>> The series is based on the OMAPDSS HDMI infoframe series sent earlier,=
 as the
>> SiI9022 driver uses the new infoframe support.
>=20
> Is there any small possibility to not make it an omap specific driver?
> There are other boards with sii9022 out there. imx5x dev boards could
> receive a daughter board with this chip (both sold by Freescale) and
> efikamx platform has it too. I think that some old msm platforms has it=

> too.
> I've not compared the code of the drivers and don't know how the sii902=
2
> works but would be annoying to have 2 or more drivers for the same piec=
e
> of HW. imho, it would be nice if it could be avoided.

No, not at the moment. There is no framework to create generic drivers
for display components.

There has been work towards that (google for "Common Display
Framework"), but that is far from finished.

 Tomi



--BHvgkEVcAxpdG7S5NU41qDQL688NiQD9V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtl+0AAoJEPo9qoy8lh71r5gP/3AY24J1vqen2aqul9iPSgI4
2hbkoWJ5QN7FNTwlNDBqUEJoG5iv3H9XqewhB5OVt9bC5DU/2ifRV3GNJPWtwn37
GEBtztSqU3DwJP7/tXqpNpF600RDARaT7+6I4s5an4GOhbYNAS+yY8Lhe7QAvjvH
Vu8jbQd4obxcFk756w3XOMZ4dkWg6IDKsxImT7PIVc/CC0GHNeHTCJGkJgZGmc5U
nypGneSL+XuqFF1W2hNvSjiW2amQhsw0kr+uYrK0/bKLvGnLN+uvGrnFGtwqYmTc
Jils3ZajKly30cQ9LBufSzQ/fSbRWvCv5rCrFcVPUmqW4aR3eJBu3cDCLa8zZrfy
MuL57H9uZDE6YMC90s1jRKGAuNGq4NOsss/vvxNowVLTxONNwOteRQF+MvED8kPC
y7bsNQVCxCDfWt8A6pIueEYdjP0H7pCjYTBJWJoR6774x0zvYTn7Ii/OcSRWRnzC
y7EJI8qbAEQO2DjQFrspBbo+9jNG0QFr2BLSnoCv2HEMa1MEawHeObtkVCKg85W0
C3m+lju5A0h3hsbzP9eEMaMxtyG17dYtH56cwYEXYX7NyCuvPmoRlYD88U/fkRBQ
7KrMldkihcKCUeCINmk4/Ka1fvdfrVT1tAfG/Xy57SjOAXWPjAxMYtc7691c76ZX
t6uZqlNjXWeDIK33UR9h
=j3k3
-----END PGP SIGNATURE-----

--BHvgkEVcAxpdG7S5NU41qDQL688NiQD9V--
