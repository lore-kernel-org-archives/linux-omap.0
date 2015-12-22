From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: fix omapfb build error due missing feat
 functions declaration
Date: Tue, 22 Dec 2015 09:50:21 +0200
Message-ID: <567900BD.6070907@ti.com>
References: <1450722384-4606-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EBoS8Lof5KcgKnx2sB56BAwk496S2SwlO"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450722384-4606-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--EBoS8Lof5KcgKnx2sB56BAwk496S2SwlO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On 21/12/15 20:26, Javier Martinez Canillas wrote:
> The omapfb is failing to build in -next due missing declarations for
> dss_feat_get_supported_displays() and dss_feat_get_supported_outputs():=

>=20
>  CC [M]  drivers/video/fbdev/omap2//omapfb/dss/dss.o
> drivers/video/fbdev/omap2//omapfb/dss/dss.c: In function 'dss_save_cont=
ext':
> drivers/video/fbdev/omap2//omapfb/dss/dss.c:144:2: error: implicit decl=
aration of function 'dss_feat_get_supported_displays' [-Werror=3Dimplicit=
-function-declaration]
>=20
> Add the declaration for these functions in the dss_features.h header
> file to fix this compile error.
>=20
> Also, remove the functions export since are not used outside the driver=
=2E

Thanks!

Yep, I messed that up. I thought I had tested it, but apparently I only
tested the final for-next only for omapdrm, which does compile and work.

omapdss.h is the the only file still shared between omapdrm and omapfb
after the copy-omapdss-series (I'll work on omapdss.h later), and of
course there was a change to omapdss.h which broke the build.

So I rebased the copy-omapdss-series on top of the rest of the omapdss
patches, and updated the "omapfb: copy omapdss & displays for omapfb" to
make a fresh copy of omapdss for omapfb. I think it's better to update
the series, rather than applying fixes for already confusing series.

I've pushed new version to my for-next branch.

 Tomi


--EBoS8Lof5KcgKnx2sB56BAwk496S2SwlO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWeQC+AAoJEPo9qoy8lh71CfYP/A+1xLqxUAVYcGwTlceZP7nK
+E4y/81UP8pW5VS6UkXNgqUkkPVBgBFAN7flEWh1eN24budXL13UiYojOu6ny6C/
qLC/ywtuLEo17GJ2yzl9HiBE4EZvBLdyyS9BLJoPY8zJK5hcGpDV0lZyr1+lVc0I
JgMbwJsBwFyxEBlIiHEphmADy2cSSge5nCTF8gUtcJw6RyORCNiY/1IkhPKuC2Jg
RUuqBS+7Vzlf3Py5B6yXpGZFOlXj5w3t+zE7V2cgYCYpcJg+Y8e0cN/yUw9A6ydx
XOXgP8uo3lZx51+2TthZNhhHjeWPMBee5HAMHuHqYaC3lVZ/CM5jiDf53Y0D5kCC
24TVjfG516Ro//F6RjbIgNLQBFjAw0i6W42gXxmWSKRlpR6bo2QpIkxUjOIIfg/H
oQkISSHdFou+DpbyzqzDfMjUpy9b83gOLSji0+X60JHQ5rS3JGcwnjMTVEDFz+Dr
tetxNoJfw9tk1KZvOgOZg96WijXnHUr428TOFjuntbSyCqWmA1FNpYXNws85TJE6
gxjNuqQVBXqO7P7y+6kgKZHRvAcBohMGfxnFvtApmvzygk4NHOCv5RPAfB+qBxgp
EOeSJebK/177cFDIVq3fww5mYti5TgiLksnHRJqoaZCQGYH5sJg03lPZSWlR2we3
NqqzbzX/I3Z0qCphIp7i
=wzOn
-----END PGP SIGNATURE-----

--EBoS8Lof5KcgKnx2sB56BAwk496S2SwlO--
