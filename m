From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 0/2] Fix simple-card *-master DT parameter handling
Date: Tue, 11 Mar 2014 10:50:20 +0000
Message-ID: <20140311105020.GO28112@sirena.org.uk>
References: <cover.1394451329.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fnSZu+x/QQRjdWqq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:32834 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaCKKu3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2014 06:50:29 -0400
Content-Disposition: inline
In-Reply-To: <cover.1394451329.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Xiubo Li <Li.Xiubo@freescale.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


--fnSZu+x/QQRjdWqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 01:41:14PM +0200, Jyri Sarha wrote:
> Since RFC:
> - fixed commit msg typo
> - added include/sound/soc.h changes too
>=20
> The sematics of bitclock-master and frame-master DT parameters
> should depend on whether they are found from a cpu-dai or codec
> sub-node.
>=20
> - bitclock-master in cpu-dai node means Codec-Bitclock-Slave
> - frame-master in cpu-dai node means Codec-Frame-Slave
> - bitclock-master in codec node means Codec-Bitclock-Master
> - frame-master in codec node means Codec-Frame-Master
>=20
> For example in a cpu-dai mode bitclock-master parameter should produce
> SND_SOC_DAIFMT_CBS_* daifmt flags and a codec node
> SND_SOC_DAIFMT_CBM_* flags.

I've added Morimoto-san and Xiubo to the CCs - can you please have a
look at this?  I can't see any in tree users but presumably there are
some existing out of tree users of the binding that use it without
current problems.

--fnSZu+x/QQRjdWqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHuppAAoJELSic+t+oim9lhcP/RFsHYs9T1K6MDRroYdq8nY0
1a0s8GKZC1/80BBO+cOSFNvfOr6+SfopL9ECT0YYZsF2ht5azipVbaSyJSWD0zp2
2GyaD2UdJM4AWz8x/OGmv78gu2NOL8fVTkSO0qHYRUkYsZyR25NdepzarjAsZiI1
GHjEsAQJCSQpBCFzWqpnZo3la5sMebgGhvGBVHzuw4JLv9EByTID66mWfV6UJ9Ox
BMTgjzo3RInQQhWid+CQBScItJmqOB6niOrdTxhotwCkagvubUey/HV+xZiszTWo
2gsWYJUfDcAxCzQfGc++9LHI0FAXwS8BYtJcFJOdu1Tbd9WpAHZYbXNrYUO4i0Pu
EsingVO5bQR0lyOFK5uh3VOURIFmzWSkgKPfYNDbTDaQSCFhUzhw/9BgHLmrjgoe
xIQkz10+9bvoy1aUAWWO3I69rx4pvLPHKx4YbYbqgO5urWLaDtqdU5OOuyEvosxp
FcMoEG6LvQnYznpnl113pvc7l89t8AJq1DnWZvIlh2ByBeGnho8Ll+ATVOFWDTxK
QrrRPrKs+rm3R65jlgcIzd7nnBhE3tmaRKxSSzw5fHlVU27AboaqhGo8bGPmbcTO
IURJGXz5YdVwEF9pA/Vfydqd0ECxf/DrhXqA/OIZbNggCAXbHtn/F/dZ+Rf8gGKF
ArkIJcpy6HMsRowjb28e
=iCjv
-----END PGP SIGNATURE-----

--fnSZu+x/QQRjdWqq--
