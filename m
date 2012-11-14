From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Wed, 14 Nov 2012 16:00:48 +0900
Message-ID: <20121114070046.GE7407@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com>
 <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43286 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074Ab2KNHBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 02:01:00 -0500
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Colin Foe-Parker <colin.foeparker@logicpd.com>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 06:49:58AM +0000, AnilKumar, Chimata wrote:

> Earlier you have a comment on this thread, I am adding my comments
> on top of it. Sorry if I am in wrong direction.

Ah, I see.  I was just commenting because Benoit was asking if this
should be supported with a standard framework feature - I'm not
convinced that it should right now as there's not any clear patterns in
hardware behaviour.  I've no specific interest in this system.

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQo0GXAAoJELSic+t+oim9ZoMQAICMNJaR2FCijaJ2rlB5kIsh
+REyBtSdryvSbR0iXw/bfAZuSpnFxbcMVtMffMIIFWonkCXC+LHRRAZ1EtRx/co+
ajLSd5q8byQir2gcUvcqyf/LH9LJlEEd8bMF7l5tIBpu+w4Ay6oNZb8lFoop1RYN
NmsoK0gllhy9tH/xr0sW0cWDTGsiHVz92u6aqVd0bHTpzyY0Pmol1RpxnLsqTN2y
06TkAWLr8Wol30q+f0UX8cXXvOIKYGKPsprwxoi8Y+e0JhTSkT7wliOf626ZVZcI
9e9ii239EGmfz91Kncit+3z90rL5apXxB/LI1OdZqufXy5Y6wj1Fcy3g5kL9qH0I
z/J0ggMP5kTdSx51Uc4X33ZAlnhCF2NwGGMxoQ5F4/VCdh583YyJxnv2lnZyQ1Ci
aK+8jx5DUacBTTCZZGbywCcHZL8kc67AwK0eM+BR0NulJMPtTZe2xrYrgcJfvzA1
N/n5577AK07Jxqwh7Szpumzt4MPBr/FGbUvDJWcjvds01BHDyqiKpvbdJFlcw2tj
SjTM0fFZTGKzyZ34cAqNb3AkozjOoCDJRXzn7QDe3n1yNPPQsAM7CKKa7KstSVsM
3UVXYo4ptMU4Tgw8NUqPZPkosXumucAJncRniOm04dV8N2qnUnElnravEOwVCCj7
+pqJHIcy5pFoerq6/+f5
=8kZz
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
