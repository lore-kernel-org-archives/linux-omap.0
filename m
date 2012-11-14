From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Wed, 14 Nov 2012 19:24:53 +0900
Message-ID: <20121114102452.GI7407@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
 <20121114070046.GE7407@opensource.wolfsonmicro.com>
 <50A36DB1.3010706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41481 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161051Ab2KNKZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 05:25:37 -0500
Content-Disposition: inline
In-Reply-To: <50A36DB1.3010706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Colin Foe-Parker <colin.foeparker@logicpd.com>


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 11:08:49AM +0100, Benoit Cousson wrote:

> I was wondering that, because exposing a pin to control the whole PMIC
> low power mode seems to be something that should be generic enough to be
> handled by the regulator framework.

Having something that's controlled by software is really not at all
generic - suspending a PMIC from a GPIO is generally tied in very
closely with the CPU power sequencing which means it's typically some
combination of very hard coded things that we can't control or part of
much wider control of sequencing.

> In the current situation we do have a pwr_en pin that can be controlled
> by a GPIO or whatever signal from the SoC.
> That's very similar, at PMIC level, to the fixedregulator that allow a
> GPIO binding to enable it.

> Don't you think that should deserve a support in the fmwk?

I'm not seeing a coherent description of a feature here - what exactly
are you proposing that we do?  When and how would this GPIO be set for
example?

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQo3FnAAoJELSic+t+oim9B08P/3WEfoJ23vfINNuZWhTJMe+Q
LLBwn2NFpsfc7lWYizWzeo7NfGYrXnxOlsHz1lRisvv++Hs+H6ArZhqb0ZA+pLGx
CKcPIVTD0bkPa4+P0EGqExnIqXfO0KkqzNwSSFaLHL5MjK9B8sdVIm29gqZJqpS2
9rKgcfemyCWKBTIbI8pPC53Vz0nPeA5LqUzDaV3pf6lbAxjS0pav3cK/9ClV52Hv
YHo81n/oB5zNNTvYdUBZbTJCSQmYeauwixmtuk0FTAYjgMNR3WPQgw1Ioy4nYbkV
GYD4F0cbPuN18TZU+eBv117t0fcC+0sP4Vnxr7yj1WXMgq7TGq2YGdXwLwkKRSPp
owUq5aOtpg3agDn82axFa+LtVdTe9RPsXUBWA00rSYWdZb+SVkJCwpTkg6nomIRR
ErSaTAlSIxnyTia26cndxTvcBnYCHFMLErp1kGtWa8oQpckrL3aPCKGTQvJo0Z2Z
S8JTES8qpd1LQpCXtXvmHUZF1qGazksJ2uJCYLrLKpz3LmV1kfFwVFO/rwZjPCqc
UYxbv8FJX4qUAug4RstuQl2RXyrYOx0UBkQNTjWdzvF0ADKSMLbTUpfltfIsYfYA
xnmmmOaxqs1UvCGr3H3ewJJ41Nzm7CksD3y7suy87CG0BjcAq4FRQ8dlrPMCA5Xf
NntaZ3S5kQnVp7MCQt7G
=MaJN
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
