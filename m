From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 00/11]O MAP/ASoC: Move and merge McBSP driver under ASoC
Date: Wed, 15 Feb 2012 08:08:10 -0800
Message-ID: <20120215160809.GF2996@opensource.wolfsonmicro.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54808 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750907Ab2BOQIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 11:08:14 -0500
Content-Disposition: inline
In-Reply-To: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 05:37:49PM +0200, Peter Ujfalusi wrote:
> Hello,
>=20
> The aim of this series is to move the plat-omap/mcbsp.c driver out to
> sound/soc/omap/
> By doing this we can combine the two levels of McBSP driver stack into a =
single
> one.

This all looks OK to me.

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9hiAAoJEBus8iNuMP3dx08P/jSTD9OK6dy+jpZ4aqCcNBT+
SGvuArB8DDsUppfs5rSfqorWOk1YO0ksJkWPj2K+/5EcUwS+kBeRW0StfDpS9QTr
j8Hl6Ip6ksr+gHi1fksiDmak2lp2sNc8cVsntbckeIO7qjq6sVvJuGUCY9nywH9g
yK54UpVCXXTPxMawo5SVzteL+YnxhxR/YVC8qxKWm7euPGksrKKMVrqpQKVpklmZ
jwQo6AKZ51Yhl9ipzLw9vIi6B1baQE3pvM0+vvAcclcFTNcdbOYA7SFtgTVrHSgm
dH+mJZJDt3Jd4wbctH7p6rx0K4jq4uxc8yMlhU0aGYrNDbe+0Kx2buxyCUdLZRA0
s/MFcA5Z1sukRJOekukxr8wrgEMheHa6lmW3NIdp7lbfLxyeScYE2DmfYgEMcymn
KogpdMv7MYB0xMHDYifVVRIamKRgPwKQ5kFHrgzepoDaHBYKHQtb098zpTMsLnZp
tqXP7sdVNjJRItkL5EJEJ3q0acnMdXjUTGmcCTxSdfrkQbcJFiiQYGtTKWa/MRxu
vOyl8n8Tz4MJrM2KFZRkszhe4nfksEB1N8AIq2EQ+o/wxHgaIFN2C76I8WYD0hIx
yPqQdd3+Fci+aVIppEK355phaDR3kTHCQ2VE2Cvn+AEROoDsLfLMy2ST/kMQ4NT8
GbAF72ALyman2+Yrr61T
=4BcC
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
