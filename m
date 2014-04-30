From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev: omap2: Fix format string mismatch in display-sysfs.c
Date: Wed, 30 Apr 2014 11:43:05 +0300
Message-ID: <5360B799.4020701@ti.com>
References: <1398682455-21043-1-git-send-email-standby24x7@gmail.com> <002401cf62d3$634cc1f0$29e645d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4bELrnWf1LjS42wMGbKK6plwGav7o225c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45453 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbaD3InO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 04:43:14 -0400
In-Reply-To: <002401cf62d3$634cc1f0$29e645d0$%han@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Masanari Iida' <standby24x7@gmail.com>
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--4bELrnWf1LjS42wMGbKK6plwGav7o225c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/04/14 14:17, Jingoo Han wrote:
> On Monday, April 28, 2014 7:54 PM, Masanari Iida wrote:
>>
>> Fix two format string mismatch in display-sysfs.c
>>
>> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
>> ---
>>  drivers/video/fbdev/omap2/dss/display-sysfs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/v=
ideo/fbdev/omap2/dss/display-
>> sysfs.c
>> index 5a2095a..5928bc9 100644
>> --- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
>> +++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
>> @@ -184,7 +184,7 @@ static ssize_t display_rotate_show(struct device *=
dev,
>>  	if (!dssdev->driver->get_rotate)
>>  		return -ENOENT;
>>  	rotate =3D dssdev->driver->get_rotate(dssdev);
>=20
> According to 'struct omap_dss_driver', get_rotate() returns 'u8'.
> Then, how about changing the type of 'rotate' variable from 'int'
> to 'u8' as below?
>=20
> --- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
> +++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
> @@ -180,7 +180,7 @@ static ssize_t display_rotate_show(struct device *d=
ev,
>                 struct device_attribute *attr, char *buf)
>  {
>         struct omap_dss_device *dssdev =3D to_dss_device_sysfs(dev);
> -       int rotate;
> +       u8 rotate;
>         if (!dssdev->driver->get_rotate)
>                 return -ENOENT;
>         rotate =3D dssdev->driver->get_rotate(dssdev);
>=20
>=20
> Best regards,
> Jingoo Han
>=20
>> -	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
>> +	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
>>  }
>>
>>  static ssize_t display_rotate_store(struct device *dev,
>> @@ -215,7 +215,7 @@ static ssize_t display_mirror_show(struct device *=
dev,
>>  	if (!dssdev->driver->get_mirror)
>>  		return -ENOENT;
>>  	mirror =3D dssdev->driver->get_mirror(dssdev);
>> -	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
>> +	return snprintf(buf, PAGE_SIZE, "%d\n", mirror);
>>  }

And get_mirror returns a bool, not int, so I guess that could be fixed al=
so.

 Tomi



--4bELrnWf1LjS42wMGbKK6plwGav7o225c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYLeZAAoJEPo9qoy8lh71VREP/iX0kdeXmYlLb7fMHAosn++b
jVF/CG6CcdAWwozEN8BspttPnCEKIm+YBqnyNnxUUsqk0dmn6AXV8hUAyWcOJXNl
T7cuBrZQYwvAf0lWStoNGsSNARkZbXseiWtSOfGDDRucW1gQHyWaX3BBkl/gpK5d
pMXhsvOnUQzC7JIxKoDHDsG5d4ApKGYv+XSYCGY2awg3dxuhhhkpLslfF9FvVlWR
x3M+eUFxn76c72dnOl84q+WxJ7AZG1BzN2bdkwON+j87i8JysKddzgkblfw0Ceo8
uiePgPztJAnFTxYMhnutvvcjFY5qOgq3xFZ1M1++l0NauYdOUwHil6v9VuWbyRZf
la09xk9PtCjGm0SDU5XpCEvekAGsJYv+RFB7dagxUPqjRVawuF8KtB4Xm7AX1n1n
PHdxSbOBj/rEx3+zPkSm2qSlARynksE04Ae+HK0tIJ2WdkvDOsFrYxtTGdD2G19m
ZOOWsEuLamrXWkrBAZiiqOvbHqCKKeZaKqkVFSDMlRz0TkJRuuZOokOflEJ7l3g9
slkQJfTfU5vfwAr8S1CycDH8YazcSa18Af8eCqTKjywh2UPwbiBTgRlEcfTaMbob
Y4gBWiUm5i+Z7D/qBsLAD5FcKRyqXVRpGfwSVEsybtrdHsnr1aIRg1SDVX//9mV8
fI9Ml2A+vBTSjR0WKwwp
=9upy
-----END PGP SIGNATURE-----

--4bELrnWf1LjS42wMGbKK6plwGav7o225c--
