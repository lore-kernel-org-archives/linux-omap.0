From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapfb/dss: wait_for_completion_interruptible_timeout
 expects long
Date: Wed, 10 Aug 2016 13:21:46 +0300
Message-ID: <cff34342-3574-d197-df08-dc5b9b6ced80@ti.com>
References: <1469466767-23352-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5H5s06E2cgeOPS40D8p3pIUfLQAbH6QG8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469466767-23352-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Luis de Bethencourt <luisbg@osg.samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--5H5s06E2cgeOPS40D8p3pIUfLQAbH6QG8
Content-Type: multipart/mixed; boundary="PXqIFPkd1beTI8eKi4BSrGnpTFaLdPpE5"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Luis de Bethencourt <luisbg@osg.samsung.com>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <cff34342-3574-d197-df08-dc5b9b6ced80@ti.com>
Subject: Re: [PATCH] omapfb/dss: wait_for_completion_interruptible_timeout
 expects long
References: <1469466767-23352-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1469466767-23352-1-git-send-email-hofrat@osadl.org>

--PXqIFPkd1beTI8eKi4BSrGnpTFaLdPpE5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/07/16 20:12, Nicholas Mc Guire wrote:
> wait_for_completion_timeout_interruptible returns long not unsigned lon=
g.
> an appropriately typed variable is introduced and assignments fixed up.=

>=20
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>=20
> API non-compliance was located by coccinelle
>=20
> This is mostly cosmetic since the returned value is only compared=20
> at present, however if remaining time (completion occurred) where ever =

> used, then a signal received would be interpreted as a large remaining =

> jiffies left, which would be wrong.
>=20
> Compile tested with: omap2plus_defconfig (implies CONFIG_FB_OMAP2_DSS)
>=20
> Patch is against 4.7.0-rc7 (localversion-next -next-20160724)
>=20
>  drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thanks, queued for v4.9. I dropped the "Fixes: " line, as that commit
only does a copy of the files, so the commit didn't really introduce the
bug.

 Tomi


--PXqIFPkd1beTI8eKi4BSrGnpTFaLdPpE5--

--5H5s06E2cgeOPS40D8p3pIUfLQAbH6QG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwA6AAoJEPo9qoy8lh71BNIQAKb30tFcZu21/YOBWtEhfI+8
2XaMoNFXQY8Yr27t0ifZIB+XUEVNGPzdl5gSKqK6LA7m+n10WhU/CNm+1vcwHBqD
/dzKgyxt3EZoP/sGdjEpdZBy6YIKH5ioCeBlKGn8dcehdvFx19evUBS50hyTiOds
KPyyWBMi01tL8ttsShnoZjVl4+kXc7VqVHh2KGN8EdmPzykKuQ6iNrI1XifONWZC
JGyEXIKhnrxerz4e0R7loEnbaoEDPPqJ7jCFogpbEFKR1f6FGW+gw63llpfdogRv
WT+AOuJS85IyMeu086w4s1HQNwmob2dOSGHfWZ3dyr7BEFmeAD8z97QMZjZlZbfv
pQxE9vOQvenLqiYEQzvIK6jzj3+dP7jxy/8ookfOBox7rYaoxEQXi4hNoGhSt09O
Azcr5RLM3VcSuJ734zBU2K7dBD6tQbdJWe5KFtaAR4wrNUZ4L5mk1TxOxoZKlIu2
mhLMiaH4enU+ROiU943UyRDo9Qstc9arhk8HplaUqTq53UbofLJnRUAEy0k+I+cv
dsPr8KH6Iu48fdR8Bxub1jt+NY0TGJy8pOnOfC1nvu/f/R+EAqhcIx+z46ekakj8
sBMKMMnuZCB3H0m2jJb15pibg1gV7Zv11zkHuP1Luke3yPCJwJ24bLQynG7uFUpI
dAebDhGBg5tuy5dqnl+H
=y+8O
-----END PGP SIGNATURE-----

--5H5s06E2cgeOPS40D8p3pIUfLQAbH6QG8--
