From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Wed, 14 Nov 2012 11:23:42 +0900
Message-ID: <20121114022341.GM4415@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60418 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932375Ab2KNCXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 21:23:51 -0500
Content-Disposition: inline
In-Reply-To: <5097F078.50701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Colin Foe-Parker <colin.foeparker@logicpd.com>


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2012 at 05:59:36PM +0100, Benoit Cousson wrote:
> On 11/05/2012 10:42 AM, AnilKumar Ch wrote:

> > +Optional properties:
> > +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.

> That sounds like a generic functionality to me. Don't we have some more
> generic way to handle that?

> If not, that should probably not be a TI only attribute.

It's pretty unusual to have this configurable as a single thing rather
than as part of flexible power sequencing or something that's just fixed
in silicon.

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQowCmAAoJELSic+t+oim9O/MP/2qhStMOV6TkNPI+3FVa8ea/
0BA82kInQBbRoWgPCWhFxVtChhRtss5UF7GjVSVAop4C92ywSWpiCR58hN14icpB
MEtr3Lbpyf1Ru4P0SZ81JnwJOloNVvrgXuSarQniIbXQeRypnzx/6Ccr2dezBOiz
6GeodKtDQxzGZfOB1R/nCghDciGeY/x2cG7Bkhs11C84sCmcQhdRRN1sAaqL3e1t
bo5wZqXe78WGIoNBVeTmxbJB+FlNL9w8XnAF2nMQ1UsY1PJ2bFDC7g3rgIZmyWQo
Sj2mt6HlBIJVRe5YJKZRUsav6Srf9HKAeUCD7Bbe0EIRW1ei/AiwyzcTOiAwDb0L
MMbvA88p3HSLp2cb6KNZ5bCLENPSR8MWzKTGrsaYfCvr6nljXe6+HH/8pZto9hYV
pbP7DWKPg+Xdzs43CNxVP1b+kdS+TATszCsWW0DEwQWIB7hlz0gfSSACjfQMWkcx
c4ndq9ssknkSatsvDP+r47+H8lhDjkKcZPXFhh7mhaabVipF0gWRG8pd5VNBMGhP
4VXBgvSYF0av9YjItdOpVLUE8cpd5VzrBhiSGWwjjeUt1pisLIBjwIgERGMJtH/O
I4pjhnAqwTeJI6hRHBw+ezQQsb1W3ePCktcFZ1XwpZ9HxtkdwfZyC+bqMylE9vkg
fEqXs+qBxhVp53Uq8z14
=Ygrz
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--
