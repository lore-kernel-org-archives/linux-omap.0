From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Fri, 25 Apr 2014 14:18:08 +0300
Message-ID: <535A4470.2000509@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com> <535A42D6.5090107@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mwJQAOWw6ArPKskQQ04RJsxi79mqL7GAX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbaDYLSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2014 07:18:33 -0400
In-Reply-To: <535A42D6.5090107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

--mwJQAOWw6ArPKskQQ04RJsxi79mqL7GAX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/04/14 14:11, Archit Taneja wrote:
> Hi,
>=20
> On Thursday 24 April 2014 03:47 PM, Tomi Valkeinen wrote:
>> Add support to set OMAP5 DSI pin muxing.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>>   arch/arm/mach-omap2/display.c | 35 +++++++++++++++++++++++++++++++++=
+-
>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/display.c
>> b/arch/arm/mach-omap2/display.c
>> index 16d33d831287..974461441fc3 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -137,11 +137,42 @@ static int omap4_dsi_mux_pads(int dsi_id,
>> unsigned lanes)
>>       return 0;
>>   }
>>
>> +#define CONTROL_PAD_BASE    0x4A002800
>> +#define CONTROL_DSIPHY        0x614
>> +
>=20
> I guess this is something we can move to our driver, and use sysconf to=

> get the register from DT.

I just copied the same method as used for OMAP4.

I guess sysconf is an option. But I really dislike the idea of moving
omap control module code to a display driver... I'm not sure what other
options we have, though. Maybe an OMAP DSI specific pinctrl driver?

 Tomi



--mwJQAOWw6ArPKskQQ04RJsxi79mqL7GAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWkRwAAoJEPo9qoy8lh71lC8P/0kKNxN8e8esOYhh9HcPMOkD
zE5mb7Izio1K1sDUUKj/M7av++6ahV7VqPxG72V7s0BBeu//70rPz+bdLFl49kMP
LEonr57mXCb/Nr+KCJwdAsUnZrTP9+r3texRNfaXc2zIScIzJ9rWuEIg6AFKidIp
RQW/PPWqmkzbIDtFxRQJGp/VKEcHclQviAEK0w0bJzKNj65RZNtEa2X2QoXa0+C4
avP63heGvT7hnQb/yy2MHWa3k0BIRNTM9WA397izhfh+UivevWBQUz8VJByDXhJl
8pUlR2Xc1NHMMwyyic4iYeumZF1149uKHf4g6rvfdMcDELS/Om2GSyKseIch7U/M
21l6+4gH6QTqgAI2EaRGE8W0CZ+QXCTdWMD/xbKvp8GeplTYUuNAwRge87KLT1AW
N41iIE4jtNX9uhdhpYf2L/KoXRvrjJxZoDCRBtMnJOxXYr2pnsTC/lo85wWXzyKI
Q8RStrx7OX+tCPLut+IcLhH5gGVRpb545edFAIdajahLYYU6dkNASUF4frDaIk1m
fuq6YZRtnWK/9z6c/3FZnZyNgwIBAmnjFUebWBaQkiZa1wWwmbuiaT+r2yonDuRM
p1EgsnL4tdsD2Vk3Xq0HCtUByN2WcMolwBh43GxORCfw3qPV9Z4413Gf4rQOdZFu
Sk9eRtT44RkoYdRws6/H
=Ue7D
-----END PGP SIGNATURE-----

--mwJQAOWw6ArPKskQQ04RJsxi79mqL7GAX--
