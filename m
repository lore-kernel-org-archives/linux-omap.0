From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 02/11] omapdss: HDMI: create a HDMI PLL library
Date: Tue, 17 Sep 2013 13:02:15 +0300
Message-ID: <523828A7.8050204@ti.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com> <1379401597-27222-3-git-send-email-archit@ti.com> <20130917093813.27384.67975@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ct7tEPPNtHgl7eOidBlxjohXdVbWTeKvL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42687 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab3IQKCW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Sep 2013 06:02:22 -0400
In-Reply-To: <20130917093813.27384.67975@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--ct7tEPPNtHgl7eOidBlxjohXdVbWTeKvL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 17/09/13 12:38, Mike Turquette wrote:
> Quoting Archit Taneja (2013-09-17 00:06:28)
>> HDMI PLL is a block common to DSS in OMAP4, OMAP5 and DRA7x. Move the
>> existing PLL functions from ti_hdmi_4xxx_ip.c and hdmi.c to a separate=
 file.
>> These funcs are called directly from the hdmi driver rather than hdmi_=
ip_ops
>> function pointer calls.
>>
>> Add the PLL library function declarations to ti_hdmi.h. These will be =
shared
>> amongst the omap4/5 hdmi platform drivers. Remove the PLL function poi=
nter ops
>> from the ti_hdmi_ip_ops struct. These will be shared amongst the omap4=
/5 hdmi
>> platform drivers and other libraries.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>=20
> Would be cool to see this convert to the common clock framework
> implementation (include/linux/clk-provider.h). It appears that this PLL=

> only needs to support .enable, .disable and .recalc_rate callbacks at
> first glance.

We've got a (very) long term plan to use CCF for DSS. And, if I'm not
mistaken, the PLL used for HDMI and DSI is the same as used elsewhere in
OMAP (I don't remember the PLL type name).

I think the main issue with DSS clocks is that we require as exact
clocks as possible, and there are multiple dividers/multipliers on the
clock path. So we iterate over the divider/multiplier ranges, trying to
find as good freq match as possible.

So if the clock path is composed from "black boxes", and we can only ask
for a certain frequency, and get back probably some other frequency, it
gets quite difficult to find good clock matches. Well, at least I
imagine so, I have not tried to implement that.

 Tomi



--ct7tEPPNtHgl7eOidBlxjohXdVbWTeKvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSOCirAAoJEPo9qoy8lh71yU8P/0yYX3tE08Z6LHU1CycNerW4
UaZTucCKbigZujtohBVDHT9iip9YSwHJP7jUwmrXCXcCfm0k9OhlPtHsToeJjjhz
PkHGoJ7WV9CHu+ydDa+vQDUigjnFlftnt3/9vqX8EiNICx6MeNIQVXsHfc56ADDf
RGujdLyssjpKxtPmxj6PTaO45iyDKwwoTRCzDPd0ULgg/Chr9xMxvjAqHMqwiXzr
TejA7mEQuMIqmzp0UKVyw171Ze/bBMyc6Laxt5SHJYz8KEPS3m/Nv83C60T900TE
O2wcKrlDx/7eS6DC9CD9fXwsbf2EzIJwwrHNEsIl3+Ho80EHM/A3qD9orBrApBqE
Vg9RkVv2Tmfg8mBmlXK57Z/6e8ecOIpW8kdRn7qE7y3dJeYfVEKVV3gyZ873E4ju
mpGla/0iHcdojsDq1Gh2G+jX3hpfhu2AgYlNE5vKHYyYXrakjyjN4dJ59lS8clqL
GDU6xMn5As02utPYSjuxxE8GFehm+rs2Lh/7sUTnLBAotjIErtqlinzVFlj4+ok2
Wi8ceLZ3JHxFcDQpb+D/b3k69v7ij2Fcf6gulLrXoECiiY5hdfqP0XVEbrzXnC0q
an2qWKBD3cBqZfMo5/XJWsyRuw8fjKo6lXAdgAU5taLmim62/RMUcxzX+INmwLvp
5iQM2JCVG/ATrsQWUNwS
=Gv13
-----END PGP SIGNATURE-----

--ct7tEPPNtHgl7eOidBlxjohXdVbWTeKvL--
