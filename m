From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Mon, 10 Jun 2013 12:29:39 +0300
Message-ID: <51B59C83.9090701@iki.fi>
References: <51B1C9D2.6060703@ti.com> <51B1D3D6.2020803@ti.com> <51B1D654.9070107@ti.com> <20130607175705.GC3331@atomide.com> <42EC710806A55841BBE342FAEBBEF172D26A1F@DNCE04.ent.ti.com> <20130607183628.GD3331@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XBJMAWIDAIIIDKRIISWK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:49310 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab3FJJ3n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 05:29:43 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so3991668lab.40
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 02:29:42 -0700 (PDT)
In-Reply-To: <20130607183628.GD3331@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XBJMAWIDAIIIDKRIISWK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 21:36, Tony Lindgren wrote:

> Maybe check that the i2c related pins are muxed properly for your board=

> with pinctrl-single?

Reading the bytes individually with i2cget works fine, so I think that
tells us that the pins are configured ok.

 Tomi



------enig2XBJMAWIDAIIIDKRIISWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRtZyDAAoJEPo9qoy8lh71z2YP/jlFe4QQbSXgxqUHdVThOKyJ
jsHJIs/e7FqHauWByFKXVX6nTyDrA8G5rMwfuCv2p/KttI0jw8vFLB4xJNU9QG/G
6HtRmuM+AcMbKy0OhO2lAj+E3AdoizTsStVCFdxaFFm+9eRzAJWbVHeq/+VPAaLH
QLIs9NorimkKcUFuJP5pCNj9ZIBXVptnKNjjLBl9BNwUCK1uFutCReItJLE4r/Iw
Dx2EyXnZUoPcvMNKSZc/TFNLPma4kvG5R9V9sm2uv2MK6FSMy28DD8qr7NJKKqWr
YnldCugyCXF3SmrJFaQFAuLonVdU5iNyhMZXYy7Ls7ZuSi+lGVh2PiNWBTGWI+Rs
F6Q6CCRkWgOBpK+xFOUtlXY8sGId8dXnsF+ltHaZpeDyAITEGNXoeH2uEK1fVQ7A
3/Mg0a2kD5L6FlOZJNNjsVLYnu9iyh7CpEwYJ6n+v8SNgQvFYsdv1G0MxvN0pIXt
ERfvxQ8bzXA5yNMVG4T7CJ4qh2gBI7u957nb3Tp4W++gRhl6+bL4DtiPu2nkhzij
RyPmcAc7RZagBUeeMVTnnrr9xju0AJRetHUMD8op39kVsfbQ/wf9WDjTfkt1rq4B
aI0leUgHpFmpE5b5xKXNA1Pk0NUs8AEMEU+AXlSfecp7OFsl3nOxzsbQ/UMKum1G
oivsrFwP+yGJoAEPlY92
=bo2m
-----END PGP SIGNATURE-----

------enig2XBJMAWIDAIIIDKRIISWK--
