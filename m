From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.14
Date: Wed, 2 Apr 2014 11:21:54 -0500
Message-ID: <20140402162154.GJ8504@saruman.home>
References: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
 <20140402162102.GB12234@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42058 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758888AbaDBQYY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Apr 2014 12:24:24 -0400
Content-Disposition: inline
In-Reply-To: <20140402162102.GB12234@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, Nishanth Menon <nm@ti.com>

--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2014 at 09:21:03AM -0700, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [140402 09:07]:
> >=20
> > Here are some basic OMAP test results for Linux v3.14.
> > Logs and other details at:
> >=20
> >     http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/
> >=20
> > Boot to userspace:
> >     FAIL ( 1/12): 2430sdp
>=20
> Is this a new regression with MMC? Looks like your boot log for this
> ends with "Waiting for root device /dev/mmcblk0p1...".

Nishanth already posted about this a few days ago, see [1]

[1] http://marc.info/?l=3Dlinux-omap&m=3D139637044425644&w=3D2

--=20
balbi

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTPDkiAAoJEIaOsuA1yqREpQAP/2K8JqL5mlC6b+XZy8C4rOs2
gAfwQ3+qFFjb7ReSJnNTB4fW+60tbhRf52gpBaQa9KcgT7ukWOOfo6F2ik0G0jeZ
/FL0lty3uMoxcIsTPDr8Tk4cDcuVKHssuBJ0SJnmGHWjKkYcMKFAPRqt5PiFNCWr
Zmh9hzSAjM6RfIKBv3A3HU0guVZMnlOodvdKqPJzFedi9/eHOGd6LZHgwB3xDtXz
MH7g6/E79yUT+Fu6JSbqGc2ayNJwqFOqqHzTguDRQCTHVQ7yqlz/Jmb2A1TC5IA0
AjrU5dAbPLEQrPm09+00tGf4U51YgLxYcktuyvZoB2UDvPHGyBy/LMKLLfZZju6p
YAc8j4PlqmfIsSVzCQ99XdtHuWgMkhOSVDPCEiD/SZN+D4PUb8sc0lzkrSL5VIWq
KKpTCrw60O+juG58afA3K5/JEoHLoSP8XWYloQaB+vTp1PdC5eWR3a/VIpDU1CqO
EP/fekf/k2Ws5WxeaBJQFvEEQuL0+JHeM50tldmKLJ3aFydunv6qCf6wZ31ZoVXn
6NNMP/UWnuRauFwc1bOKERKEt0b2xuVU8RDsGiWS5qEyHfq5THrY16OwXG/jFspE
cq3o1XAR7hWC/gfKO09SU5WCT5EttZFtvXKob/qCAbRIPccjwqGTKY+4Kvra3uUB
OXGYnrpG5HeFkAA6CHgk
=+GHN
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
