From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: acx565akm: Fix module autoload for OF platform
 driver
Date: Thu, 24 Sep 2015 14:37:54 +0300
Message-ID: <5603E092.6050707@ti.com>
References: <20150918184457.GA32636@goodgumbo.baconseed.org>
 <5603CDD1.7030709@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PoCi9RvPGAiRHmCN9FVUm9c9vvGSWlUFG"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5603CDD1.7030709@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>, linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

--PoCi9RvPGAiRHmCN9FVUm9c9vvGSWlUFG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 24/09/15 13:17, Tomi Valkeinen wrote:
>=20
>=20
> On 18/09/15 21:44, Luis de Bethencourt wrote:
>> This platform driver has a OF device ID table but the OF module
>> alias information is not created so module autoloading won't work.
>>
>> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>> ---
>>
>> Hello,
>>
>> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
>> that information so modules have the correct aliases built-in and
>> autoloading works correctly.
>>
>> A longer explanation by Javier Canillas can be found here:
>> https://lkml.org/lkml/2015/7/30/519
>>
>> Thanks,
>> Luis
>>
>>  drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565a=
km.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
>> index 90cbc4c..c581231 100644
>> --- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
>> +++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
>> @@ -898,6 +898,7 @@ static const struct of_device_id acx565akm_of_matc=
h[] =3D {
>>  	{ .compatible =3D "omapdss,sony,acx565akm", },
>>  	{},
>>  };
>> +MODULE_DEVICE_TABLE(of, acx565akm_of_match);
>> =20
>>  static struct spi_driver acx565akm_driver =3D {
>>  	.driver =3D {
>>
>=20
> Thanks, queued for 4.3 fixes.

Oh, there was an earlier patch from Javier already posted. So I'll pick
that one instead.

 Tomi


--PoCi9RvPGAiRHmCN9FVUm9c9vvGSWlUFG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA+CSAAoJEPo9qoy8lh717c4P/iQhxqiGQYv0VEaKmhUzoemU
qdmP6u2MEiEO8r2QKpUMYIFoHutPyWqX1AmAwNt79ODed3vvhoANwSozZksolR41
aovQmy8T0li7hNhwgDrcoCZGcTQ5Gd9zJ2GFVQPsYChVFu+UEq9ZfS/yta3i1XSf
6kRM0OtJch+EFydZ2B6n0Q2ogLFZD9NDCVQdwZIAFmWRM/I6uhuffMlAyMXuQpo9
QoKSVfq3laqZxHlpr7Wz1ON9SMJVFr3PCM5Tvyxsa9YIOvHgoLUSNflE9OqWb3km
Rspz3LvwwTW9ZElgInt0h+RNM0dMFXkXJoUvLV9WokW+8DlFYgxrCCtST52iMpuX
RetRnTp+trruXYeuj5BE3Nejp3slfpi2pJSIZ/3ZJl0PucfxmjDPpKJYEO4v/TK9
nlD6yrU02LT8xYMohR5/UboOOB4YAigw+zwCc+jt3ZwMeAk0yBjBl5efcxbJKYoC
XHgYl7G1EKjCBNnDKQnSZ/74MXSamgwZyhpbkng5EV9p3geeEirYj7bIWP+4A0Tw
2Fk6Nm5Deu8e2dEQAZkjIvy5tXWI111NsWQNGDhDE9thedreWnDwxn+8Zs8clNtn
KnUqwmq7lySrvYjdyB64B2bhE9zD9rvOwilhVe2LWo+eEdSSdFbq3+Fjx7rRmkI3
RQmNKxSrdfVTI8k6ClMS
=DUZg
-----END PGP SIGNATURE-----

--PoCi9RvPGAiRHmCN9FVUm9c9vvGSWlUFG--
