From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Mon, 14 Nov 2011 09:05:32 +0200
Message-ID: <1321254332.1931.3.camel@deskari>
References: <1321016900-1714-1-git-send-email-mythripk@ti.com>
	 <1321016900-1714-2-git-send-email-mythripk@ti.com>
	 <1321016900-1714-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8TsH0DrC9EEM17sJOO3H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:34997 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab1KNHFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 02:05:38 -0500
Received: by mail-bw0-f53.google.com with SMTP id q10so7122870bka.40
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 23:05:36 -0800 (PST)
In-Reply-To: <1321016900-1714-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-8TsH0DrC9EEM17sJOO3H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-11-11 at 18:38 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Disables the internal pull resistor for SDA and SCL enabled by
> default as there are expernal pull up's in 4460 and 4430 ES2.3,
> It is done to avoid the EDID read failure.

You told me previously that this problem has nothing to do with OMAP
versions, but the board versions. But this patch only talks about OMAP
versions.

 Tomi


--=-8TsH0DrC9EEM17sJOO3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOwL28AAoJEPo9qoy8lh71X2wP/25s9L7LcCEH3vSQO0D2Gkfh
IxDr/d50SPh+ASHzDxGJcxqWmKCOxH7Qn/i0SpePrXiZWwuidq1dogjfo7sWtrht
IuRXSsGKy8rtRmd6NosZO4MTfx2ZDG7u52C6aQmXOWrNz4lPpLTKXJF6snkA9mOq
jD1BzwMzKyRd9fUd/WQ6Zgu3PiT+uZ4Fqdm+GlPKVNjtWBMmFCn5nb3u+fQ0ph3F
N6x6vl1eQCbt/94D8n/gd3i+DY+D+S8ngcDjNDb2m/A/7FhHL51UMGroLYfO/C1d
IMi8KkELytXExGW8qdX8LTBiT/Hx/hkaD+IJ8PWqRHMxRXQ8h6rbDIs91WPxLMZ5
UV0I1q7lQyTy4HXlC3ad2H5qr4ATqIHuM3P3VcrI6pNO261gchJ9Jmuh4e+apoYE
FbUIF1/F1Yr6mmUoV4MMqPRfzdAmNlSe/QqkzvORDISy+n1cDDRpq1a48j6ZjRaU
Ps66x8r7o7ZppRFkDWI+e83+dOR/oztRPXs4LEUYUcMSyouKdW5D2xKjtfsSLemp
PuGAA4hQPpLlPL82SKMJsrrTDtKqfUN0q3bcz6/FA7XT7T+PSo/6OavqKN2cqExb
TvUKydxaFpYCFvdXlduCqsqiqOaBUben+YWs/Z1gkex8dDk4tbdNUgK+znVwx+ka
jQvApFnYFL0KeTGrgxdN
=SF0F
-----END PGP SIGNATURE-----

--=-8TsH0DrC9EEM17sJOO3H--

