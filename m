From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
Date: Wed, 22 Aug 2012 20:11:40 +0100
Message-ID: <20120822191139.GI7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e9fJn+fjquYGkO6l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36679 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757739Ab2HVTLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 15:11:41 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>


--e9fJn+fjquYGkO6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2012 at 04:41:01PM +0300, Peter Ujfalusi wrote:
> On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
> the FIFO for the audio stack.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

I applied this - Tony, from the thread it seemed you were OK even though
you didn't explicitly ack it?

--e9fJn+fjquYGkO6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS7jAAoJEFJkBDiqVpZ4QdwP/1W/Plf3eiW+pIcgcwgKrzx4
XUQJoJemsIUVuQdcmRbocv4YnDdKAQ5TStCnOhb/7+c2sGYQ+tDn5TtMS/ZE53BC
8/RhWXgqVw7CtO8KhQnJ25zq5uFf570lItsjqXv3po1cxXKJWu7Bw3zDJAr9j2+3
IPf7uJNraolQd9IeJ3xdVglvGoFulKsxGeAFMUQ0fmtyMfsMBQ0So6IFnT5ug9L7
Y69gKr0tUoWDy6oPu2HyvX+M5LjOmNgxtBPKp6yz10Zyl6QOkZkb2NG7loPFD40E
QmILDOEHUOTiB18Ks3SFCod7FNxUDUuC9uyqrhBZ5Y/R7SpGPvUl8kKdHx/+8sBj
SrG4MKvBfXjSIgDL/JyGeQv9rT8xNyCMlP6PXZlpPmtZu2Qz37BCLuls1zADcEv6
+e2G7iY3m8T5STUTRigYAZP07w1uJL+u654nIQV2hqqVqOuKJVxzU4tbkLpVfS6a
PLmR7ALOb2NDcOP7P8+tQiZfvTyhsLAjgWcxO2JaUwp1GXr8DZBhdzcWwSFj1s7U
+C/OBUtZLu64O1qWypCRi8iaCcs0d78kA+l7c2Kv48/tMrK0/J7npEMwn6+7ccqO
Kbug/uft67qt/0+9M22jj8kBjDC4f2I9hA6mGaEtsKloPxMyZi95KhqX3AIeAk+o
NuoeCi7e6RqkJRy7wLgC
=Bg39
-----END PGP SIGNATURE-----

--e9fJn+fjquYGkO6l--
