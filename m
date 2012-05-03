From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAP: DSS2: Remove suspicous and unused TAAL
 regulator API usage
Date: Thu, 03 May 2012 16:11:00 +0300
Message-ID: <1336050660.14378.12.camel@deskari>
References: <1336042634-28486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-fFcRtc9waKDrVOqUOSQz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33159 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753382Ab2ECNLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:11:05 -0400
Received: by lahi5 with SMTP id i5so2100313lah.39
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:11:03 -0700 (PDT)
In-Reply-To: <1336042634-28486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-fFcRtc9waKDrVOqUOSQz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-05-03 at 11:57 +0100, Mark Brown wrote:
> The TAAL driver contains some regulator support which is currently unused
> (the code is there but the one panel supported by the driver doesn't have
> any regulators provided). This code mostly looks like an open coded
> version of the regulator core bulk API.
>=20
> The only additional feature is that a voltage range can be set once when
> the device is opened, though this is never varied at runtime. The general
> expectation is that if the device is not actively managing the voltage of
> the device (eg, doing DVFS) then any configuration will be done using the
> constraints rather than by drivers, saving them code and ensuring that
> they work well with systems where the voltage is not configurable.
>=20
> If systems are added needing regulator support this can be added back in,
> though it should be based on core features rather than open coding things=
.

I've already applied this and the three other patches that you sent in
March to my omapdss tree. Have there been any changes?

 Tomi


--=-fFcRtc9waKDrVOqUOSQz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPooPkAAoJEPo9qoy8lh71Sb0P/RtrMpoEocvw8FUm0H2H2Tkk
DT1QNRLXWZVFrB7KiQC8ZhOsnwhQIgOnIKxxiANV3LjW+QRLXSYsmb6or6koQQrh
IGNs3wQAZchQ9UAWO83My0E33yPgmDV33VYc8KurZsxnLnTiGq/RUZ4m4NgkzZ/f
j58zUCXEVMQKX4wgGb1Ucf5oTmtQXrHQakBfBfVlHLeWE7X2FoNqD6Plh4770Asn
WM1zw2UL3h95hl8VaVL3S5K4q5VslyAp6j7Q7Fe7eCpburDc/Fb2Mj+HTz4cQ+vg
4sD5ef696Vw4bZqh+9e8CWplrpNYzudZAX+bTFt6SqxL3ljgTrSP1AE67n1KVUtl
6mfyFAiRZomH/J9DKA3LIEuoKbhH+Y+cYFFJM0UezNz55TOZdtQQr01HoRepK8ne
XXV5Pr6YDiWbCzVh4HDalLiUYjcYUih6otAImLl+M+mvzbYFGT5H4V28XelDM3Wd
HYW3I3Vquznmfltk+hIeK8cxTDorf7EvL41+NrwK1o2e0jP404JSma/lSE/jx+2s
l4RwVFeFWdKjfBdyJ/2nyW+0vkX7rbMJv54JncO+fIiVEW4aMXHIk0sG6Pb/ua8P
DCcDSHMXiIa1Z9jLzEJFPD5LkVwRECGaNvb25jsgD7/45+tj3ncc6EsXTOsJlVOy
o85PGPU9R3kT23GFsMsx
=Egr6
-----END PGP SIGNATURE-----

--=-fFcRtc9waKDrVOqUOSQz--

