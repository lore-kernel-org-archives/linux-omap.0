From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Device tree binding documentation
 update
Date: Wed, 22 Aug 2012 20:18:35 +0100
Message-ID: <20120822191835.GQ7995@opensource.wolfsonmicro.com>
References: <1345559636-23370-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="10AxbcBAbBOxkJp7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49749 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965080Ab2HVTSh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 15:18:37 -0400
Content-Disposition: inline
In-Reply-To: <1345559636-23370-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>


--10AxbcBAbBOxkJp7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 05:33:56PM +0300, Peter Ujfalusi wrote:
> To reflect the final devicetree node structure of McBSPs.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied, thanks.

> the initial OMAP McBSP DT structure was not able to describe the IP (and =
it's
> versions) correctly.
> The main issue was the sidetone block of McBSP2/3 on OMAP3.
> With this change in the DT description the OS can get the needed informat=
ion
> about the IP.
>=20
> The sidetone is still not supported when the Linux kernel is booted with =
DT
> since we still depend on hwmod to fill the resources.

I pasted this into the changelog to explain what's going on.

--10AxbcBAbBOxkJp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNTCFAAoJEFJkBDiqVpZ4CDYP/2+R2ulLM85xxrxm45a0pe5y
4otTF69/+fmHfusfgdITkPNzuN2Y7kv4nbDrg9Lhxh6EUSdhMKRARfD50g1mVPCf
GyL9l6PRnAGtffS72Je3dmk0xtn+BrKslaNZQ0XcOeKcgUs3c4fn9ZV5cQLFfsIn
+Jh/gtZWqo/k7iD53Y6wViVAtdyzkbknP56V74WGx48b0n8nF0cSUE8asUNAsyUQ
KZ1ygaPKp4cp0dqFuHz0g7atZpqLDw+dM5TSAsmo8uFWfEFqOU8EbQPyOpwk9I7M
40+VA/DTn5emzVobBPlSpnTB7l5/0AxFAKtgHyYUS4xfTamyxPH91r8MDnw7l7z/
0UJQqRaIR2xiTCPdQupevuvXVfvang9z+4wh7ym6K7lUSla3LJwVvAX1AiZGPQ31
BMCYtIjEc4tVAJFls3drLqdmuxqOt4dgzVrzgXSR2hmG7CWqokR2b1kRWc/yYJwj
2wNJtiC+favMZ59YwK3W7F9+wfkWMJTHga5bn123/m9FMuRKq5gEZtA+S1TruYX0
1CqPriGB76w2Iq6awLPQY0SdPpzDXyYGCG3p6wkoCO0+FMnulz/8b5IoS6i7hJyA
Q85UIk/2x2vDpKXh5n+b2DwThiOk0U2gtktUdV0zAV3cMk5OPB7CA3lzdWdxRKLZ
XVczokaqyHQMmOc1t6el
=Ig/+
-----END PGP SIGNATURE-----

--10AxbcBAbBOxkJp7--
