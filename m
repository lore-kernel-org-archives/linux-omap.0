From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Powering OMAP's pins
Date: Tue, 25 Sep 2012 13:21:14 +0300
Message-ID: <1348568474.2342.35.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CRPx/Mji039uTHfmzqFh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60695 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754009Ab2IYKVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 06:21:20 -0400
Received: by lbon3 with SMTP id n3so127983lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 03:21:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--=-CRPx/Mji039uTHfmzqFh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Each pin of OMAP requires a particular power to be enabled for the pin
to function (Ball Characteristics table from data manual). Is there a
plan how this is managed with pinctrl? Currently each driver needs to
make sure the correct regulators are enabled for the pins it uses, which
is platform specific and messy.

As a driver maintainer, I would wish that the pins would just get
enabled automatically when I call pm_runtime_get()...

 Tomi


--=-CRPx/Mji039uTHfmzqFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYYWaAAoJEPo9qoy8lh71zTgQAJrqKh2UtsL9kdf2buTPM1RY
6hTK/Gvdhkgtoe+u7w1h+oKybVCtLdB2KQKf1jowdhy6XYpQ0CFg0bOWcsfX1lxr
sOQnjxBnivRutUPyCxOpaids6tyNdZSHIvYGSnKaxXAFVOqYgLUoSL8L3ioEyQcB
9WhROTCSWU7axUjuRmLulZKgPPCOJzuUFYs1iA1vtQV1Sq8NgXhyRbjdeGM6rkBI
Jr4nKoqyateE5PjCY093I4EUAe9o1biNnc99HgZqEGDEuEn/VzHOqmB75CKB2cx1
zfmhmHGbJ3FTvlI9spOSsqS6CigQ1x6uNsf/HFibOlWSlZZ/QCjz/H49Xffsy9y9
t7yCF5NUeZk9t0B6P2I+l7fXL8NtwJ089Bc6c+VaInjNjK/DRPCd6QEAB83y36hp
+jeHo+2s8HTFM+qAbnNfeOD+CN+YoCdkYfNhzV62CKjokwdIMm3leMzD7Kk9w8FJ
v+4fmOUBP2yfR0q96Ho8JGkqDUoxjZbukXR0QUE8T9nBPjSHXRDHlp46I9jscCQO
HZN/2Je4XPb57hL3cMGGqYv7MIzQ6fLE/fPwxmhRoPF9VrMGITuraLDysyNSAZdZ
ynZLoJxj5c5m9A/aC+S1ehddEf/YgJdwHTI0iX1dgDS+HRma0/Sj9YX16h4vXvmk
Mp6MNpLyIbaELHOhOQ1B
=Ml1x
-----END PGP SIGNATURE-----

--=-CRPx/Mji039uTHfmzqFh--

