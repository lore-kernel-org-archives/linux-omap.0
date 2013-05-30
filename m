From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Thu, 30 May 2013 14:28:28 +0300
Message-ID: <51A737DC.1010900@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com> <20130530110945.GI19468@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2UUURIXCOHGBXVCKEGBEA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968083Ab3E3L2c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 07:28:32 -0400
In-Reply-To: <20130530110945.GI19468@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

------enig2UUURIXCOHGBXVCKEGBEA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/13 14:09, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
>> When using DT, dss device does not have platform data. However,
>> dss_get_ctx_loss_count() uses dss device's platform data to find the
>> get_ctx_loss_count function pointer.
>>
>> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
>> platform data from the omapdss device, which is a "virtual" device and=

>> always has platform data.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  drivers/video/omap2/dss/dss.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/d=
ss.c
>> index 94f66f9..bd01608 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
>> =20
>>  int dss_get_ctx_loss_count(void)
>>  {
>> -	struct omap_dss_board_info *board_data =3D dss.pdev->dev.platform_da=
ta;
>> +	struct platform_device *core_pdev =3D dss_get_core_pdev();
>> +	struct omap_dss_board_info *board_data =3D core_pdev->dev.platform_d=
ata;
>=20
> 	how about store the pdata in the drivers internal struct and if !dt
> 	you ust do this
>=20
> 	dss_dev->pdata =3D *pdev->dev.platform_data;
>=20
> 	to copy it and we do not alloc it for dt

It's not quite that simple. We need some OMAP arch functions (like
get_ctx_loss_count here) that are not currently exposed via any other
method to drivers except passing a function pointer with platform data.
We need that also when booting with DT.

We have a bunch of devices for the display subsystem hardware blocks,
like the "dss" here. When booting with DT, these blocks are represented
in the DT data, and do not have platform data.

We also have a "virtual" device, "omapdss", which doesn't match any hw
block. It's created in the arch setup stage. It's really a legacy thing,
but with DT it can be used conveniently to pass the platform data.

The problem this patch fixes is that we used to pass the arch functions
for each of those HW block drivers. But with DT, we need to get the arch
functions from the "omapdss" device, gotten with dss_get_core_pdev().

 Tomi



------enig2UUURIXCOHGBXVCKEGBEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRpzfcAAoJEPo9qoy8lh71YykP/2Cfby08qKZGuvXnH4OTS6xl
PtoPdOrwszYeZfDkbvUNPzIb2Pl7oi0sK9/3zew4iYd5sj2MUxwpaM8dh92/Fi3B
/epmrbdK4RcR9kGUpUkPqCE6r6oaSo76UxXVvaPwmxz2z/4CQQ0S+j8g6Su+Q7fl
NumCDfMr7+QLjB5GfAfkYTUqPVEJCR8PBJEZxEYHSH73k3y/TuySwz1vw5+xvdj6
/5wn8LOQV0oZyZegjtn0FYmZf6Wx02V7VcC74PqJJkaIYohbfX0EKPc5cDVx0egI
qIi6jdgLs9Ki0FyBLdyCoeBKDlGmKT3jGDgPXjGlQiMdBlhJMcvhTEoQP+YaMNj7
SanUsdWaChOSya/nU5E/WbyOUzcMDb4dLmhVvVnrMd0b2bkhFZ8ns/LpR7oMXOz0
oIyoJtVBRcpByndZZtKBaVjsCKobfd6dcybTdJBF5BSuRUNT/tSBD1f6zWDTtcog
Q8mitMwxnYW0fyNgcswhBoyfDuzN2pFVXFY7A5SblUifY610ZhdV/ItMe0oXpQ9t
y6hKS9eUg9oafh7vRTUTMWvNVuOsCaGKEfeXg8ysOBF1EHSHDHRlmcz+MYzhWqPH
gWfVGqhWlDsEBgJrGtu1kqfd4ENpB9ihpSk4dvqNUt9p/Aq2c0NvJ9Bp7BQ9ZF9+
5daw0J1ToF66JF1gs0W9
=1kHd
-----END PGP SIGNATURE-----

------enig2UUURIXCOHGBXVCKEGBEA--
