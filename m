From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/32] OMAPDSS: DPI: cleanup pll & regulator init
Date: Fri, 7 Jun 2013 11:45:39 +0300
Message-ID: <51B19DB3.3060106@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-16-git-send-email-tomi.valkeinen@ti.com> <51B182F7.7050002@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2OXGGJHKKWUXRSNBMHNLI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37870 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FGIpl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 04:45:41 -0400
In-Reply-To: <51B182F7.7050002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

------enig2OXGGJHKKWUXRSNBMHNLI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 09:51, Archit Taneja wrote:

>> -static int dpi_init_display(struct omap_dss_device *dssdev)
>> -{
>> -    struct platform_device *dsidev;
>> -
>> -    DSSDBG("init_display\n");
>> -
>> -    if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
>> -                    dpi.vdds_dsi_reg =3D=3D NULL) {
>> -        struct regulator *vdds_dsi;
>> -
>> -        vdds_dsi =3D dss_get_vdds_dsi();
>> -        if (IS_ERR(vdds_dsi)) {
>> -            vdds_dsi =3D regulator_get(&dpi.pdev->dev, "vdds_dsi");
>=20
> same comment about devm_ usage here, and the next few patches.

Yes, good point. And that allows us to get rid of the 'vdds_dsi_from_core=
'.

 Tomi



------enig2OXGGJHKKWUXRSNBMHNLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsZ2zAAoJEPo9qoy8lh71TVcP/0a9iOb/w/QZo4vFqoWl1u+a
sZOhrWnZ/5iP8zz93sE58n/UyaEbFmgUE9pXhD2IQnJS7gm0ViwWuGGXeomyjWyJ
CgFFsqD9lRy0tCuQ5gQ+mKbp2xfUFc3W42tHYCW/n6cV/cNIFp67TUKIlVKPJsDJ
cElMxSRzcMeHvi+z9ZhZwWiTswIjL9WKt3hsy/tPeCmToj8gzkB9s5D69D1/cIAD
vTyRtsxJPKxwi4LOvgsKJITGQgNlgaxRfOzXQUWG6/+EpgChM3n9/wBci/gUv6DB
0NUb5eHHlsOhR8ydIKeaKKnvJeoo8oTQkpKcCM/d+ckrGmaBzkWU70r4QQFJ28Ky
eLOiOeXs5lXUUN1+56vr0n2FT+VfkRNrQiAlQl/fO1i0/JKXXKIvVOp/VsVxz53S
K97Fv2/RCVw7W6UG3aGrscOg/NzodE16SRczTjk5AqEBaFfVoY+UR0ZNTF3PcmQa
KGJMhRzp0kh8y5TP0UXghTKX+T8adl8hcBPgD3JiBumf8xK01mE/PTW8MeyzvBhe
qxDWICpMDpFXtNiXQuX1Vh90bLBFr0NeLQELgkf6uwgRY9qmAKxXgPtVEGc8r4GY
xstQqT2z3lb4zcxtu1H+SfnFPRta2ZrJfUy17Kdl5K+h+/NXDBSbhmQpTl2EsCzJ
WFUqGgNQcEg0JqYYkmUe
=5NOT
-----END PGP SIGNATURE-----

------enig2OXGGJHKKWUXRSNBMHNLI--
