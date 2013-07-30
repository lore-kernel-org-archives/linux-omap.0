From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/21] ARM: OMAP: devkit8000: use new display drivers
Date: Tue, 30 Jul 2013 09:01:52 +0300
Message-ID: <51F756D0.3050009@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com> <1374822504-28949-10-git-send-email-tomi.valkeinen@ti.com> <51F753BD.5040509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="W7OdsVPtR7Rbf7N2kPeuu1JX4WesU98GE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55976 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487Ab3G3GCR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 02:02:17 -0400
In-Reply-To: <51F753BD.5040509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, weber@corscience.de

--W7OdsVPtR7Rbf7N2kPeuu1JX4WesU98GE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/07/13 08:48, Archit Taneja wrote:
> Hi,
>=20
> On Friday 26 July 2013 12:38 PM, Tomi Valkeinen wrote:
>> Use new display drivers for devkit8000 board.
>>
>> The new OMAP display drivers were merged for 3.11, and we can now chan=
ge
>> the board files to use the new ones and phase out the old ones.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm/mach-omap2/board-devkit8000.c | 96
>> +++++++++++++++++++++++-----------
>>   1 file changed, 65 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-devkit8000.c
>> b/arch/arm/mach-omap2/board-devkit8000.c
>> index f1d91ba..cdc4fb9 100644
>> --- a/arch/arm/mach-omap2/board-devkit8000.c
>> +++ b/arch/arm/mach-omap2/board-devkit8000.c
>> @@ -112,50 +112,81 @@ static struct regulator_consumer_supply
>> devkit8000_vio_supply[] =3D {
>>       REGULATOR_SUPPLY("vcc", "spi2.0"),
>>   };
>>
>> -static struct panel_generic_dpi_data lcd_panel =3D {
>> -    .name            =3D "innolux_at070tn83",
>> -    /* gpios filled in code */
>> +static const struct display_timing devkit8000_lcd_videomode =3D {
>> +    .pixelclock    =3D { 0, 40000000, 0 },
>=20
> This is unrelated to the work being done here, but noticed that the
> pixel clock for this panel seems to be too high for the given timings.
> It puts the refresh rate around 90 Hz, which is odd.

So it does... Quick googling found the specs for the panel, but even
with the typical values in the spec I get somewhwat odd refresh rate.

Well, as you said, it's unrelated to these changes. I guess it's better
not to touch it.

 Tomi



--W7OdsVPtR7Rbf7N2kPeuu1JX4WesU98GE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR91bQAAoJEPo9qoy8lh71/g8P/0c8Sao+VIALJg+0DlXaaWKM
UeQSe4oA1c3U9KVArBAFwM9EJixTopLeGEAeRfQ+dc1lqX27wPGwVnChQ8l6aegX
GEMnieGc0xe4mlzn5H8ybnJxAdWyoM8QnNHQ7wsMX5TT08gMoGnXgEY/0+I7pwxW
CmFI1gd3QmdSNyPXnV4B5NpcfJQAGHVVmcoJ1Gy6PUmlPMyi2w1ZUIyQweQuS9hA
QXbezs3K9Rt5/00FPCsVwA6Al2b7EpeYeaOrUtfqZe6lNq3kiQK8Awsjpx22mf46
QVzjCNUnCQRQ210hfOdcdI4Vv0RkwtiSmoBA07KJDMmyOiUaJKvahL52jcB5hwH2
r8UlFcRQb80DBpgVbC0jFZRY/6QVA3KDmSFPoSCsPzuUAgO6hJTrXuiHZiqM5UOa
JUxrS3bqItJ7nhYTtCzqkgR3uIDjp9Yn4md51QCzDgCfhCPDzYAK3c5iMZKFf8Uq
PVmvON52vFjdzLteh1fHrFUMjLiAsEP1T6PcigpP8GKrpg/PZLFRaTrz2sfBEAUT
FIbP6gJ9UElOdQqi/Jy4P7rC4rNV47sLwDAnoUjLjk3my0NU+ouo1+/hnmeOVYDH
qtSeeHHU5Sc6KWYwO3KohbGI63E7ZhBIS0nn/e39Ktl52om2s2GGCNVYTMUyqDXZ
bK3dYwFrS879N6qbJUQH
=AV6r
-----END PGP SIGNATURE-----

--W7OdsVPtR7Rbf7N2kPeuu1JX4WesU98GE--
