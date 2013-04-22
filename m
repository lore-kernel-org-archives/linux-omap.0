From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Mon, 22 Apr 2013 12:08:38 +0300
Message-ID: <5174FE16.6080307@ti.com>
References: <20130419171318.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B561FB1F4CE59A19294C863"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40771 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab3DVJIp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Apr 2013 05:08:45 -0400
In-Reply-To: <20130419171318.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

--------------enig8B561FB1F4CE59A19294C863
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-19 20:13, Tony Lindgren wrote:

> 3. DSS fails with DT booting
>=20
> Works with legacy booting but fails with DT. I'm almost certain
> the DT booting was working last week or so?
>=20
> This is what I now get with DT booting:
>=20
> omapdss DSI error: can't get VDDS_DSI regulator
> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
> omapdss HDMI error: device hdmi init failed: -517
> omapdss CORE error: driver probe failed: -22
> ...

I think this is the issue Christoph Fritz reported earlier, DSS is being
initialized before TWL, and thus DSS doesn't find the regulators.

The proper fix is of course to make DSS support EPROBE_DEFER, but that's
easier said than done. I'll have a look if I can get it working enough
to fix this issue.

 Tomi



--------------enig8B561FB1F4CE59A19294C863
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRdP4WAAoJEPo9qoy8lh71WZAP/jwgoFOKba5HUV5eElP1JuXC
F0Dyk03W/oquTnTblSDd253PLu199NOxTYImiLsAwUImwQtly9H485Q9ClsI1l8m
HP6MMKXNmoq9EFqguLn9PxRz2xqPInR2xocjcxYZs4//YWcn2EMojviVad7zdzEG
JTwGNatZZEHiT1vRwLqgJzJIUvqI9T9C/TOCJiFaCIvaNqI+w1lpXS4NZMqwIqUo
uvQdbbW98kiyXZGSMCx3s5hgsDg1o4o+xGIN55Os4DStqrMkeWv+xNTp+UmlxlJp
ztBL6IubXsrXnO+mB1ld427jOeY43c8BD6ARsfo762f6Yzlo1R5BAQls2NovYlAz
p7E+ydES+xU5U8pjVoG7SEJcXAl8xIQuWAHpob3tHaCs+s+jkDhOa7djTZLxJb8O
BT9zjNqaYHHsoqpHX5FcIsoC2VzpkGSC4CJpe3n07BlqZ4sMq5b4ljMvaO4pDYxh
u5QZzXmAA8tZHDt1hEkN0KnoI9Ceajbd6of687CAhdvg+KvRLuC2Nccu23RkJGyr
EQGhdc4DTEVFk07vMkr/QgVjIo9hP4Yjw4Z7ryIm0xnara5C7onAkNsBNeRfzvJg
yhMSq2VH6V/D3wIvPpqjz9EnjBLXoJVLgc1mN6wxp0fz9DkbNx/fZrlbDTn1NTd7
7WpIZPGFKaH2MLS1ctAm
=7/ll
-----END PGP SIGNATURE-----

--------------enig8B561FB1F4CE59A19294C863--
