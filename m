From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH] ARM: dts: Add missing reg, interrupt and dma entries for
 omap3
Date: Mon, 11 Nov 2013 00:47:17 +0100
Message-ID: <20131110234717.GA29968@earth.universe>
References: <20131017221522.GE15154@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:38606 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab3KJXro (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Nov 2013 18:47:44 -0500
Content-Disposition: inline
In-Reply-To: <20131017221522.GE15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

On Thu, Oct 17, 2013 at 03:15:22PM -0700, Tony Lindgren wrote:
> Looks like omap3 is still relying on hwmod data for some basic
> device tree information. Let's add the information to omap3.dtsi
> so we can remove the related hwmod data once omap3 is DT only.

This patch fixes a regression in omap3 DT boot introduced by
commit 2a0b965cfb6efc667228831fc3a30308b4f94a87. This commit
assumes, that interrupts are specified via DT data if booted
via DT.

-- Sebastian

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSgBsFAAoJENju1/PIO/qacIQQAIGYr7/8K0Yd2z25iidX0AC5
favt3P5EHULJCVJd8Iyj2RzsuzRIHnlU08xusGEo7zg+0horh7cxo9E/mTMlo9ce
9/GF1oTGwAl8EWXdN7TzNmCtPUn8LTpNmlg7NJDgB+bY8rb8cRo9a+tnRoXvMG9j
6O5Bz9P5t/I2LrIqcCusJgW6FdpcD9EPD/EWdZtjGPaHnMvPu+QESZrb2uFDVOag
lFsI6ADldW603tOMJ1HzntlCjNWSnwD7X8Ih/DSfaTH5zF4NuXKbJnztEx9G9DqJ
SwTOqNCPkdiXbN7d6GJQypzuw6VaW5ovKklptvuuVXmYVy7gnVdihDhzqnWKAiMb
zOvGTIBOgfihw+qtFzBAo8HXynquAByQ1S6TwyyVUQqjcq9vQspzYhDMVEXodUeq
Oq+yBQQwrKRDKO8RjWNXIHtiDs2wje97UwjIRn6ndL22QSjOzcsYfwY+Rrt4fw4I
nnU7XV3Bfv+lhCAMGRtC+/Z1fWkd3Fubv8PgAPPneYbvcya9Q8FIboh8PJb97V8R
zQrzJM2nYXBWEmpkdUeCQdsHEqbuQBp5blO5Sfqhp6o310uzMVooFgeGQFpxHVbY
BpnTXRdiHXeMdPCFiHjPmQKyEOBRU06JLPMRlrcb1MyK6La7SHa0qWmSq6Vud+eK
v6jgc9fMqWGb7HFfivqE
=sFVN
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
