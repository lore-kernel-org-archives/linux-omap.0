From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
Date: Tue, 21 Aug 2012 17:38:05 +0100
Message-ID: <20120821163805.GW7995@opensource.wolfsonmicro.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFtM20PmL5gDcvsL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35209 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756147Ab2HUQiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 12:38:08 -0400
Content-Disposition: inline
In-Reply-To: <5033ADC5.4030002@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: AnilKumar Ch <anilkumar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--OFtM20PmL5gDcvsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 09:48:21AM -0600, Stephen Warren wrote:

> This .dtsi file adds a node for every single regulator within the
> TPS65910, which in turn means that of_regulator_match() will find a node
> for every regulator, and in turn every regulator will be registered. On
> some boards, not all of those regulators will be used, and hence we
> don't want all of them to be registered.

This isn't the general view for the regualtor API - we generally want
all regulators to be registered in order to allow us to see what's going
on with things even if we've not figured them out from software.

> If dtc allowed /include/ inside a node rather than just at the
> top-level, that might solve this. Or, #defines to the board .dts could
> define the label name, and the .dtsi reference that label name.

I do constantly wish that more of the people churning out DT stuff would
look at the tooling around it :/

--OFtM20PmL5gDcvsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM7lhAAoJEFJkBDiqVpZ4w/cQALnhfQAWNZczJRqiJqWMf7lP
7V5Npg46RqaDwYq32DwgllBUphEQXZkcMbnf6Qpjd+YEog9Ro2bVVZ29Db09PvOG
3hFgsLaRJafELyFdNjw++TyVWSeDpHrJZj2jE771X81NL6/+3GwwM2sFkCGxCRyn
WzBjaXL+Fg402GhBwhGjCeWWhr03kSytRyyPA7x9QjWMo4dJGS5W88kCN4s66KiA
Kr4xBpNxGKRslwFKKLD6PQmtjb1zu2H+AbG9O/o/PTKybuX5TrHCKPSND+u4hly9
AhVKanj0Ac0pR/bRHnSQSO0Y9vkvTRrekr+tcrDn5V+Y1ESNF4lr2PGbpapgOI4N
wpx80VaqezuMtwvyffvPyjvh1oXGuka5BxhVm6/Pxgpw8X8iphj8TrDyo1D8XqHJ
k1mVm4ETGW8pzDGZs4rUOQhwvzrfZxAL9YuyN97T+EUnAxhWCowDwsczgHnX8/3W
gg23ilhfkJ0utONnfdstie+xCQG9yyHR66lgXMI9yL/RLokEoUDAisBFG2zf0iuM
9tvcdBKGXlPGaV5JqmjOabKp+I5qqT3WWpgMaqILtf2hMYEKIRPhNkcL+l+kh+18
a6kACn73YumxECuQuRK5sj0obqUgZRBOQh0pMU/G3Df1JKZfp8EeejZGd6jX/PGr
huUW0/R+D5z+hbOEROPt
=Nr0I
-----END PGP SIGNATURE-----

--OFtM20PmL5gDcvsL--
