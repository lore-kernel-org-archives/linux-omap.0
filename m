From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/21] ARM: tegra: irq: nuke leftovers from non-DT
 support
Date: Thu, 8 Jan 2015 09:56:06 +0100
Message-ID: <20150108085605.GC1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-2-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:63154 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbbAHI4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 03:56:12 -0500
Content-Disposition: inline
In-Reply-To: <1420652576-22309-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 05:42:36PM +0000, Marc Zyngier wrote:
> The GIC is now always initialized from DT on tegra, and there is
> no point in keeping non-DT init code.
>=20
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-tegra/irq.c | 8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUrkYlAAoJEN0jrNd/PrOhL7EQAKs3j7kvWYfsnGffEG5PWQJ4
6HRlyte5RnoxUN5zIevARKdYivGPZM1aldv8alP7I7UhPVNZujs4qcTG5g13zvSK
B+0f8MrljnYF53wM99DPyO6o+sr1VrVGc3lS+SPr5T8JIyc0WDCiuswn9/8YFExt
d8r6zRUvSs+Xa8WDuU+jmUJN65FiGBj1F68pM0BE0LGs7oyHrs+5INIQd7N8HJUQ
M/2Ab/5JyhUzuaQbrnQ7pbE8ClpKv3z1Gl9isUjlU6BKpFEGjipsblrMEMeXCuaS
4yAOUUq5DqJU0D0JBZfXgduqRCo8saP6Hafk751Ge0c7n0Fs5JniJA7WiQmh7wbF
Dvy4KyY41TW9RTjvzB6JyFzMTI6Mu9HqlPWilVz0JUGTMpGXSA7E+I7Ont31QWI2
sQVBC90kJYk9ZCNTKmmqGkLPKyn+fptDmem36D+1zirysoGVnWJoe5HMJkRkWr7G
6bDdQ5fry053g2Rb5DjQxFt/mbnNCTz7Dd1/Z7cCKTTgtx4zjoC8t9DkT3iwa2IJ
UEalotgGijnbdQH/e+Vc6mP78F1gbSnUrK99hUovHI6vrBYm1OoA5oxwoktK3VL2
iePnX74lFEJa8NmQv361y7U+AQwR4xmyaGVkEimtSsmu1vJG1D5VnaERj8N7mByG
Ik8g/amaWtyrSArlNrka
=pPUy
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
