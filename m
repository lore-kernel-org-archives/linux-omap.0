From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Wed, 14 Nov 2012 15:21:19 +0900
Message-ID: <20121114062117.GC7407@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47433 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab2KNGV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 01:21:29 -0500
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Colin Foe-Parker <colin.foeparker@logicpd.com>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 06:11:45AM +0000, AnilKumar, Chimata wrote:

> From these two threads we can infer that this is handled in power_off
> sequence only. And this is feature of PMIC to go to shutdown mode nothing
> to be fixed in silicon. PWR_EN line can be connected to any of these like
> PRCM control or GPIO or some other instead of RTC(in this case).

OK, but why are you telling me this?  What are you looking for me to do
with this information?

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQozgUAAoJELSic+t+oim9jhYP/1pleQ+wnY0iCss9aen5UktI
0kyaLvMtWQyw7gq/LR0/YmkGBXvdTZhrNQQJp0V9P57Nm3oe0rNOCdxoWZmAYRXJ
/ZkSa1VtsscG0gdlMOxsM/34gZGTadw8oLxR0nrqsiaDEBCOWRUC/t81wiDY+pH7
3GfNbPOinUSRtkjGs9U8EcIJXsNUw1e68wvZN3hHY6RLHukKAEBjIRFcBMCwievH
Rwrm7e2EAfEvuaKvC0Bma4CX8G+HIG2S1e0fBLcXfoc5UFGI//kxZ2xy83BJzEku
UjgUaId643wnsYGrC6sVE5zUzAUb+nX6aTViIofExsiwfP6KCLv+YJn03/WuHBwY
EhFQYS3neOSMHi3TJpDPo7D/2pYqv5OgKqOxChbngaCf6CZF0UY3HTxecFsBnPfr
v6sqHylv7fxavhxLXlnJ32Egt1xgCjpvNxIposlkv0sqpsJNHA669ACIuv0uQ6kb
K1FilftBqWBnZyTEEqroXCBnibqafrI8lE/E5xiOkn6ErkgBsUZsLSq9UfZ2y1pE
0tYEPcoCADMSRZYv2KdOTwNhUE6cnvYem5R45NwqlZldRQmue1jRmO5t16lYBE1i
D3+DnYbgdD8Agb8HtcoPvLsz0K5jbjipKWoFXPghDy3XNg20YEPUz4X1CGCQCzlF
BytdVt7cEuIZ7bwur+3A
=4ED3
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
