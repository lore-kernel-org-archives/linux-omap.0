From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Thu, 30 May 2013 19:14:59 +0300
Message-ID: <51A77B03.6090608@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com> <20130530110945.GI19468@game.jcrosoft.org> <51A737DC.1010900@ti.com> <20130530154355.GM19468@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2JONIPLSDSIHFIDSFMLES"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758262Ab3E3QPE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 12:15:04 -0400
In-Reply-To: <20130530154355.GM19468@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

------enig2JONIPLSDSIHFIDSFMLES
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/13 18:43, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:28 Thu 30 May     , Tomi Valkeinen wrote:
>> On 30/05/13 14:09, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
>>>> When using DT, dss device does not have platform data. However,
>>>> dss_get_ctx_loss_count() uses dss device's platform data to find the=

>>>> get_ctx_loss_count function pointer.
>>>>
>>>> To fix this, dss_get_ctx_loss_count() needs to be changed to get the=

>>>> platform data from the omapdss device, which is a "virtual" device a=
nd
>>>> always has platform data.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> ---
>>>>  drivers/video/omap2/dss/dss.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss=
/dss.c
>>>> index 94f66f9..bd01608 100644
>>>> --- a/drivers/video/omap2/dss/dss.c
>>>> +++ b/drivers/video/omap2/dss/dss.c
>>>> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
>>>> =20
>>>>  int dss_get_ctx_loss_count(void)
>>>>  {
>>>> -	struct omap_dss_board_info *board_data =3D dss.pdev->dev.platform_=
data;
>>>> +	struct platform_device *core_pdev =3D dss_get_core_pdev();
>>>> +	struct omap_dss_board_info *board_data =3D core_pdev->dev.platform=
_data;
>>>
>>> 	how about store the pdata in the drivers internal struct and if !dt
>>> 	you ust do this
>>>
>>> 	dss_dev->pdata =3D *pdev->dev.platform_data;
>>>
>>> 	to copy it and we do not alloc it for dt
>>
>> It's not quite that simple. We need some OMAP arch functions (like
>> get_ctx_loss_count here) that are not currently exposed via any other
>> method to drivers except passing a function pointer with platform data=
=2E
>> We need that also when booting with DT.
>>
>> We have a bunch of devices for the display subsystem hardware blocks,
>> like the "dss" here. When booting with DT, these blocks are represente=
d
>> in the DT data, and do not have platform data.
>>
>> We also have a "virtual" device, "omapdss", which doesn't match any hw=

>> block. It's created in the arch setup stage. It's really a legacy thin=
g,
>> but with DT it can be used conveniently to pass the platform data.
>>
>> The problem this patch fixes is that we used to pass the arch function=
s
>> for each of those HW block drivers. But with DT, we need to get the ar=
ch
>> functions from the "omapdss" device, gotten with dss_get_core_pdev().
>=20
> ok
>=20
> do not take it bad is it worth the effort those 54 patches?
>=20
> is not better to work on DRM?
> just an open question

Both omapfb and omapdrm use omapdss. omapdss provides the HW level
support, and also panel support. At some point in the future we'll
probably deprecate omapfb, and move wholly to omapdrm. At that point
omapdss and omapdrm can be merged together, simplifying the design.

And regarding the amount of the patches, there has been some bad design
decisions in the history of omapdss, and as it's a big driver (plus the
panel drivers), it takes quite a bit to fix these. There will be more
coming to convert the rest of the panel drivers, and also to implement
DT support. But those all also work for omapdrm, so it's not fbdev-only
stuff.

 Tomi



------enig2JONIPLSDSIHFIDSFMLES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRp3sDAAoJEPo9qoy8lh71QOkQAKIqVvqZmQe7S/5A/ga36KrM
3bEVBaDElcrtJiz9aK1KucuNQUsv4JQyULt7Ssc3PtkUxG3Ce80RaHSnSnKI/XJh
FB/xI9EAGe/ZBgh15S5LUz5LttFUSLokpWGSGAa+9mpvcAhA1WMDMyk3LNf9E0Oj
te3sflDwk2JTRr78v/jrg6Szd26EQNvSyutfncjSMlmyo6i2zVHY2hQpVBSUKZSX
fJn7sAzmbxC5XNrKdQm5nEEMcr/9L6Yce29LhDPVsllvqTgxB8Dz4LrnTQd4UV9Q
gVz8zi73C35/64wws/FQJrhpcH9rUYZ40yly96MOd3kPG7j05BkgIbQgrRQpfymy
jJ3eok4NAvYzYluKbym5JkQFQ55jdDKOCIzGw0iGoUfm4LejwJq9Vphg4Wphw3yE
CMPLpNxfEJtMRL8xNQBktWDNhTtIYD+WottgapFipOnDyIRZyaRqkx5+Tss0tIVL
dqB+1Y161m/iG/1EsOphdvjUULbJl4kYO8SZyuy+gQaiTeBIWE5x3sd81rgt697U
87FobBetuE49Q4PHL93kr7fQqeHFW+YQ++w8sgCpdEUTjEh/Kp/+F13/zOiPlZ8j
XcROsuV8S8LVFGCjtcLhIRzBY9oJCLUOt4dv1VLRrSvL9e4HT9R1g4dWRKKqtgD0
2q/D5r7F4flt0kZX516D
=p/Q3
-----END PGP SIGNATURE-----

------enig2JONIPLSDSIHFIDSFMLES--
