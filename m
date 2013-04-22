From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Mon, 22 Apr 2013 13:24:56 +0300
Message-ID: <51750FF8.6000401@ti.com>
References: <20130419171318.GK10155@atomide.com> <5174FE16.6080307@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig175DFFE8B652AC417A0E3CF8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab3DVKZE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Apr 2013 06:25:04 -0400
In-Reply-To: <5174FE16.6080307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

--------------enig175DFFE8B652AC417A0E3CF8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-22 12:08, Tomi Valkeinen wrote:
> On 2013-04-19 20:13, Tony Lindgren wrote:
>=20
>> 3. DSS fails with DT booting
>>
>> Works with legacy booting but fails with DT. I'm almost certain
>> the DT booting was working last week or so?
>>
>> This is what I now get with DT booting:
>>
>> omapdss DSI error: can't get VDDS_DSI regulator
>> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
>> omapdss HDMI error: device hdmi init failed: -517
>> omapdss CORE error: driver probe failed: -22
>> ...
>=20
> I think this is the issue Christoph Fritz reported earlier, DSS is bein=
g
> initialized before TWL, and thus DSS doesn't find the regulators.
>=20
> The proper fix is of course to make DSS support EPROBE_DEFER, but that'=
s
> easier said than done. I'll have a look if I can get it working enough
> to fix this issue.

Yes, it seems delayed regulator initialization brought up this issue.

I hacked DSI driver of omapdss and Taal panel driver to somewhat work
with EPROBE_DEFER. But then the issue was with omapfb.

omapfb is currently set to start at late_initcall, so that omapdss and
panels are loaded before omapfb. But even that's not late enough to get
the regulators for omapdss. It seems the regulators get also initialized
at the late_initcall level. Changing omapfb to late_initcall_sync was
late enough to get things working.

Again, making omapdss, panel drivers and omapfb support EPROBE_DEFER and
dynamic panel driver insertion is the proper fix, but it's a big job,
and there are "interesting" issues with it (like how to know if a panel
device will ever get a driver loaded).

But is there something wrong with the TWL and regulators? late_initcall
sounds rather late for such a core resource. Even if all drivers
supported EPROBE_DEFER, won't it cause extra delays in the boot as
drivers are getting probed multiple times?

As for fixing the DSS problem for 3.10, I don't have any ideas except
pure hacks. I'll continue studying this.

 Tomi



--------------enig175DFFE8B652AC417A0E3CF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRdQ/4AAoJEPo9qoy8lh71H/YP/3P7Q9Ckz0pq2gqmRlk7JQUr
w8pDGKO57i4aIuLUroEM6jxUdIZjlei4PaINH0jGW/P4V1FSfNbwfH+2wAAeAogY
vmxZFK24Z8OzCpas02C51zF3NeNsJmCPCSQNKyXXlKGQf7WHvsT+FLzG+BUNx6eE
gPsQLQqfTF0Nk0TY26EOBirydADg6squY2siANWJWahp3AQPO8rFIHaDzvynWv5j
NfJylhWpbZ/WR/43M3iju2OKB2HmYzNGO/g6YyUa3fP5RaJtBpnB3q3lL6oda+lP
HXA6ow68rDjDfivE7ZmCufGCjPRjq8/bzhmnHXZvJ0DwE2r4S3wWoUMZviA6jZqR
x0C3FazqsqieUBnlqa3sbLll8Kz8E8FwBDawfhHX60iy4vs06M3+YZ7RrvrHk66z
NRg9B9o1Dhb5QbciUiNBEBbiby6TDfaTF3IJlvG8Ob/V59BxwnDAH02Gzg7Lj9EC
uwOf+tJZkKwfWBQZNYIo1zPFr1x7/ml6ruD/+4hVq19Xt4DpWpx5e+ULrzDriNeX
ev2rDbtVgaSWIo+fTdGvIMptDWOpTqLao8iHK5CwBU8AkS2X5M8CqXuMM1++XZ8v
Ob+NE1+jEM6gQjN9WPiJaPJgkYjhW8FzTPMQKeZtw2+UfwdPg+1069nk+oP9m7CZ
68lb5yiWHN+bRHAnOFBq
=sfV4
-----END PGP SIGNATURE-----

--------------enig175DFFE8B652AC417A0E3CF8--
