From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: tiler: add hibernation callback
Date: Fri, 20 Mar 2015 13:43:55 +0200
Message-ID: <550C07FB.3060104@ti.com>
References: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org> <55099207.3060006@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tHDsEDjNTVJugDhdmL9AiiTRAKhEF64sD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41049 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbCTLoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 07:44:04 -0400
In-Reply-To: <55099207.3060006@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: David Airlie <airlied@linux.ie>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>

--tHDsEDjNTVJugDhdmL9AiiTRAKhEF64sD
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18/03/15 16:56, Grygorii.Strashko@linaro.org wrote:
> Hi All,
>=20
> On 02/25/2015 08:08 PM, grygorii.strashko@linaro.org wrote:
>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>
>> Setting a dev_pm_ops resume callback but not a set of
>> hibernation handler means that pm function will not be
>> called upon hibernation.
>> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
>> assigns the suspend and hibernation handlers and move
>> omap_dmm_resume under CONFIG_PM_SLEEP to avoid build warnings.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>> ---
>>   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> index 56c6055..afb8cfc 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> @@ -941,7 +941,7 @@ error:
>>   }
>>   #endif
>>
>> -#ifdef CONFIG_PM
>> +#ifdef CONFIG_PM_SLEEP
>>   static int omap_dmm_resume(struct device *dev)
>>   {
>>       struct tcm_area area;
>> @@ -965,12 +965,10 @@ static int omap_dmm_resume(struct device *dev)
>>
>>       return 0;
>>   }
>> -
>> -static const struct dev_pm_ops omap_dmm_pm_ops =3D {
>> -    .resume =3D omap_dmm_resume,
>> -};
>>   #endif
>>
>> +SIMPLE_DEV_PM_OPS(omap_dmm_pm_ops, NULL, omap_dmm_resume);
>> +
>>   #if defined(CONFIG_OF)
>>   static const struct of_device_id dmm_of_match[] =3D {
>>       { .compatible =3D "ti,omap4-dmm", },
>> @@ -986,9 +984,7 @@ struct platform_driver omap_dmm_driver =3D {
>>           .owner =3D THIS_MODULE,
>>           .name =3D DMM_DRIVER_NAME,
>>           .of_match_table =3D of_match_ptr(dmm_of_match),
>> -#ifdef CONFIG_PM
>>           .pm =3D &omap_dmm_pm_ops,
>> -#endif
>>       },
>>   };
>>
>>
>=20
> Any comments on this?

Sorry, I missed this. I'll add it to my omapdrm branch.

 Tomi



--tHDsEDjNTVJugDhdmL9AiiTRAKhEF64sD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDAf8AAoJEPo9qoy8lh71hc0QALBDBe8uLqDxkdDz2TXBrOeL
MoxsFTYiDGwbsfzazdIWp/JZkyi65D1lHn2yHfkrRtRedU9fbNWH39ozCCsU7PIg
s4z9FfD00P8WbbPKz6eHcXK6WmACzNkR8WdafXqS13D57jo+mPR3m0IYX3oQFjhW
qgNZUY24CMIX6gFMdCQXpqYW05lKBbXZOpoNMSmHd3PamFSAIyrGqU8qlSiArtoj
+KqZgWQQy/PA8eP6tdFs3nh9L7edVA6IaLSdEVglTlisGnVl0uOGa8n24Bo8C2Ks
c9c0CHcFsl/tP2C5qYabdoAzBFjlp+K3+W7mK9A7p/RC7zc5LVa+nmMvy5pTEd8W
qKybEWtNGzaNxtLKykYuC8GHCIxh6t09LJd+KjLw6I+cHcr7TbPZaHf1P6FPnFG9
v9KWD557qyf5TnT9hsUO2nDGpB0OclQ8HzqYcRzZcbitRGsI11oPL8i3fr5vkgx+
wxIiXtXSagAiwWLClFVl8xWL7VkNc/mP5r/Av0LzuxvewVzxzzstawPAFj86odW4
Z+SomuLLa9fD7e7+3EnM+FTJR7dqGfLRA40PIoNCXmj5W6tOWeGH/p03ms9QymkJ
jy3+ct4gvrvNWtZAgcIE6+hVya9Mr6Cnvw5cG1l9/yzjMLEj+24XLHwlGIdc1j26
ZLoZRnn5D0uLuIgYLei+
=8gl3
-----END PGP SIGNATURE-----

--tHDsEDjNTVJugDhdmL9AiiTRAKhEF64sD--
