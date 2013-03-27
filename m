From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/26] OMAPDSS: TFP410: convert to platform device
Date: Wed, 27 Mar 2013 13:14:34 +0200
Message-ID: <5152D49A.2090309@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com> <1364304836-18134-17-git-send-email-tomi.valkeinen@ti.com> <5152D3E8.9040603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29A0BA9CB1D0029AE4819A33"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43913 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab3C0LOh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 07:14:37 -0400
In-Reply-To: <5152D3E8.9040603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig29A0BA9CB1D0029AE4819A33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-27 13:11, Archit Taneja wrote:
> On Tuesday 26 March 2013 07:03 PM, Tomi Valkeinen wrote:
>> Convert TFP410 driver from omap_dss_driver to a platform driver. The
>> driver uses the new panel support from omapdss.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/displays/panel-tfp410.c |  205
>> +++++++++++++++++----------
>>   1 file changed, 128 insertions(+), 77 deletions(-)
>>

>> -        ddata->i2c_adapter =3D adapter;
>> +    dssdev =3D &ddata->dssdev;
>> +    dssdev->driver =3D &tfp410_driver;
>> +    dssdev->panel.timings =3D tfp410_default_timings;
>> +    dssdev->name =3D ddata->name;
>> +    dssdev->phy.dpi.data_lines =3D ddata->data_lines;
>> +    dssdev->panel_dev =3D &pdev->dev;
>=20
> Some of the omap_dss_device fields populated here(like data_lines) are
> not going to be used anywhere. Are you populating all of them just for
> the sake of clarity, so that they can be removed in another series late=
r
> on? Or is there some other reason?

Unfortunately the datalines are used in
omapdss_default_get_recommended_bpp(). So there are some fields
populated just to keep things working, and I expect that they are
removed later.

 Tomi



--------------enig29A0BA9CB1D0029AE4819A33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUtSaAAoJEPo9qoy8lh71jgAQAIrmFufZN5oOk4APfdItNXzD
V9TXFIsvGyPtIA3TZQgVNs5OaiDk2jMizCeqeGAob5slA/lHdxWH7eiqtgjD4j/i
6FSlSvDY/7NSY9rJHsRSxpwbQVqTa0M1J6cg9UWsgY7o9OCMH7Yq9wpukckcOl91
C6rdskZOF1zJUs/RpyW6vDKyqL74tkfohcHctuJf52XrAXo2VzWr2p85KuJJ0Smv
ul2SnYEwAOnXz/X9RPUNM6P/UURCtFdGaWd3fECbHx2AoE1jtTRpWc6iDm5SWDZd
NUIHlSK1hJ0W4DoX3CtmS+y/4pPouLIytxvhHFmTSa3VLz4xO9gNblhyVwy8LtRA
H2j3uQfEVqMnEZ/anu1o0hLfnEjPn1FB0WrcymLIRSgOE34OPirL6sRNtxkjsHVP
h4d//BuZtag0+AX8sgm+N0ttM09QCliTrYy53lP5yXiX12TqPgY3pWEw1h5l5VJR
ASb1b5GxaqrO9aOvBt/tPYAni5BC25jpx1mVHyZp7Po09Q7zc8avqwDfJ3bAwCLc
xS2duEHaA6RnTTHUTWMLby+THsDeYc192qKDqrc6LslmvDShwWSSMGhGL2NfksP7
tZAWkCVEY0nvawHnojFsG9punVaSA/UNVV9kvx1ebxD9gpsR5MtnVmA5rZxIoR2n
qSnC0fnLAG2H1SgHQrix
=/+r2
-----END PGP SIGNATURE-----

--------------enig29A0BA9CB1D0029AE4819A33--
