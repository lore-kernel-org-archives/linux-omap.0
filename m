From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Fri, 23 May 2014 14:02:37 +0300
Message-ID: <537F2ACD.6030603@ti.com>
References: <cover.1399884780.git.jsarha@ti.com> <20140512150616.GF31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="oiPfMWKmiB6kXRrMgOXOCOqKeJjHKB8cb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaEWLDE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 07:03:04 -0400
In-Reply-To: <20140512150616.GF31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

--oiPfMWKmiB6kXRrMgOXOCOqKeJjHKB8cb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 18:06, Tony Lindgren wrote:
> * Jyri Sarha <jsarha@ti.com> [140512 02:13]:
>> Since RFC version of the patch set:=20
>> - Split callbacks removal patch away from "Integrated ASoC DAI
>>   component driver implementation" patches for easier reading
>>
>> This set of patches fixes OMAP4+ HDMI audio. The structure of the
>> implementatin looks a bit different than before. Instead of creating a=

>> driver specific API for a separate ASoC component driver to connect
>> to, this implementation integrates an the component driver into the
>> HDMI driver.
>>
>> The idea is to use an existing ASoC component driver API instead of
>> creating a new custom API for each HDMI IP and to avoid splitting the
>> driver to half for separate video and audio parts connected with the
>> API.
>>
>> The new implementation also uses simple-audio-card for a machine
>> driver instead of having its own HW specific machine driver.
>=20
> Can you guys please post this split into the following separate
> parts for the maintainers to merge:
>=20
> - ASoC changes
> - DSS changes
> - DTS changes
>=20
> And once those are all in, please post the defconfig changes.

Tony, this series will get delayed until 3.17, but I'd like to merge the
HDMI DMA channel changes to omap4/omap5.dtsi already to 3.16. They are
patches 13 and 15.

Those are very trivial, but I'd rather have acks from you for all the
=2Edts changes I'll be sending.

 Tomi



--oiPfMWKmiB6kXRrMgOXOCOqKeJjHKB8cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfyrTAAoJEPo9qoy8lh71ROgP/iOog0kAlegSyAHuak6SOcYl
N7ZXQMzlnU6Yc1GjDyOJmIdSx3fYXtWdolYQTGR4QRN9hXm4xBiQIGTL+LIBAngD
YgPhwQQzJCTdsweoyMH5RRPHV6rAJ4uwDA/8PEnjbilctM/tLt+QGQhXucWepd1+
jbA1+2IeduTmoqaAKkXWNJrkduVJGSw7+KTEao/fT342NI/UHmVu7dT/YMz6FyVn
iwA+PMbKAnNnZddLAC6H8QWMr3oY5rDQFu6tT3/AeVCT2J0nGZWwy+6bXhbRCCJI
59am90u+hAaqmdTXRkLKrceZO15pE8Iaf6EvfNyITM0e2+t9oGUnWpyMO0pLF9pZ
u9I7VmTvsSH3alMwH1yORj+mU4VmEtRpwbHkN3WRI11XJzZz1UovEN0lnogC7opD
KXiLYWbx344ILxJhxSItBUujX7FzEiTTyrSWUh30vjVgw9I+6TDsb2JckR8Xzz4B
48hJFC1AdNNV+ktYe4fAe1RbGASzitOFf3o8xiVE8TajpeVWV9rpwWOyi65bLo9s
ysshfrAModJSHdevgZ9K9AL0LMkG1cbHxQlucDAStL5G0Cv4hhdYrFkTRP3z5d2h
UEwy+MqRZSv75yDnDaNXlUoY1+r0/h8+Snbv9al1W8oTsY0TSxsBEOwkTAxgofy3
zvZxejbOW+8/8peLICSh
=Md8W
-----END PGP SIGNATURE-----

--oiPfMWKmiB6kXRrMgOXOCOqKeJjHKB8cb--
