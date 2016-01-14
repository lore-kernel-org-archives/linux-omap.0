From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
Date: Thu, 14 Jan 2016 09:44:37 +0200
Message-ID: <569751E5.40204@ti.com>
References: <20151224072926.GE29642@mwanda>
 <20160113232230.GQ12600@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1520446709=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160113232230.GQ12600@atomide.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1520446709==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SSFlP1H7sPpHDfX5FDVdNoBVBhddee6OI"

--SSFlP1H7sPpHDfX5FDVdNoBVBhddee6OI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 14/01/16 01:22, Tony Lindgren wrote:
> Hi,
>=20
> * Dan Carpenter <dan.carpenter@oracle.com> [151223 23:29]:
>> [ It's weird that I'm just now getting this warning from 2014...  Oh
>> well, looks legit. -dan ]
>=20
> Sorry for the delay on this one, got distracted few times with
> other bugs to deal with. This seems like a valid warning yeah.
>=20
> Tomi, do we really need two copies of the the same panels
> files in kernel?
>=20
> For example:
>=20
> $ find . -name panel-sharp-ls037v7dw01.c
> ./drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
> ./drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c

Strictly no, but I think this is the best way forward. Longer story:
http://comments.gmane.org/gmane.comp.video.dri.devel/143151

>> The patch 9522f9fe86f9: "OMAPDSS: panel-sharp-ls037v7dw01: update to
>> use gpiod" from Apr 28, 2014, leads to the following static checker
>> warning:
>>
>> 	drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c:213 sharp_=
ls_get_gpio()
>> 	warn: 'gd' isn't an ERR_PTR
>>
>> drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
>>    200  static int sharp_ls_get_gpio(struct device *dev, int gpio, uns=
igned long flags,
>>    201                    char *desc, struct gpio_desc **gpiod)
>>    202  {
>>    203          struct gpio_desc *gd;
>>    204          int r;
>>    205 =20
>>    206          *gpiod =3D NULL;
>>    207 =20
>>    208          r =3D devm_gpio_request_one(dev, gpio, flags, desc);
>>    209          if (r)
>>    210                  return r =3D=3D -ENOENT ? 0 : r;
>>    211 =20
>>    212          gd =3D gpio_to_desc(gpio);
>>    213          if (IS_ERR(gd))
>>    214                  return PTR_ERR(gd) =3D=3D -ENOENT ? 0 : PTR_ER=
R(gd);
>>                                ^^^^^^^^^^^^^^^^^^^^^^
>> gd can be an ERR_PTR if gpio_to_desc is defined out but it's never
>> -ENOENT.
>=20
> Seems like we can just remove the check for -ENOENT here.

Yep. Writing a patch for this and the other panel-sharp-ls037v7dw01
error Dan reported is on my todo.

 Tomi


--SSFlP1H7sPpHDfX5FDVdNoBVBhddee6OI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWl1HlAAoJEPo9qoy8lh710rEQAIGYgGPC9lCrNK0v8eMAtVps
1DNBWVWDOavG14iEa7R2Y0NEj79K5ObRyHSy8pHJQ1HhCO9Jj3/KX5dxJmOtcj+6
9Ed7ZOc2Oto4gxisn1MMCcyUkNJIGESoXw6Tm0s40ijiL0Dbei7a/fI8v2Szgh/5
0NATMOTnxFsXLkkr8tCsahwTCTdGSn1fVJriUjuyGKjJ4nJ6JNcGcjiyIx2dXw9o
E9HTSSW0oSR/T6OFIN79ngpxedOePlQGLOkAa4sIm4pkTW6yOEpzRYHZai5iAuqa
HVfnwTqPl1doWwrKvA+kM7xVV2X4p2GbQv6eFIsFpSBAvsqz3+lpHu2mfSAnt6IJ
ml94U+xXm2oh3apf+aWHJeaUguDl0vkR8L3PVHXyN11p6ezcDY/YdYsK6s7Cb7tH
l3YA0bqOKGVLgkpCLq+m9jujvuTspk+ToTmzmzzFqbftfDIC2yPTzSJtIoQR3yLg
GEVgk4X3ec6Te0ZQLT+kl2WN0z9wVSwFSD5Y3Dm6kCEem3ICC/BwSCodPvUbx6Sx
dMkeWA9Aaq4gMf+uXIEatD9eGbTlT6LR6z3Lf2cCOpQ3XF20pAm5F6EScqcHCvB5
n1ZZBPdJvDeYlmbC5gkpCkZbWusETjRI9+2mzUxUnN4Fai2md199A6WziR18My33
nkd0jAEUCJayUuUudasZ
=FULn
-----END PGP SIGNATURE-----

--SSFlP1H7sPpHDfX5FDVdNoBVBhddee6OI--

--===============1520446709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1520446709==--
