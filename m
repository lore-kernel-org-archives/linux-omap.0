From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Setting OMAP DSS fck
Date: Thu, 01 Dec 2011 10:16:22 +0200
Message-ID: <1322727382.16429.4.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6FNuuWqUM4DZa7vl/d24"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39959 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551Ab1LAIQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 03:16:29 -0500
Received: by lagp5 with SMTP id p5so940493lag.30
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 00:16:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-6FNuuWqUM4DZa7vl/d24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Why is it that the rate of DSS functional clock (dss_dss_clk on OMAP4)
cannot be set, but we need to get the parent of the fck, and set the
rate of that? The same is on OMAP3.

=46rom driver's perspective I think this only makes things more complex,
as the driver is not interested in the parent, only about the dss fck.

 Tomi


--=-6FNuuWqUM4DZa7vl/d24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO1zfSAAoJEPo9qoy8lh71+/4QAIIksss34n7OzfvO1NZapwT9
HWO7ZQhGc53oRxe+Mu0UiPu5mkckLecp3hqgsbL4IvDzK6iScXo2Qh1WoY7Tp7wb
oWhPP0STfjdY0mGiLogJoloGsk16NR1psBG2A0jhrjOi+7+GwO/UBMeZpIrAtJag
rrAt6boVAIiffvE2wAYA6NfQzI9NxumJ3jJ5kRBjwrnfr6BiKtCgePAPcQmlEF9a
GIxw3XzrcZaYE5z24QsLEOpPfsJgNRZ5rD5RmW2Bxc5gB1XTik7zVXDxJXT2VFVS
5Kg0aPuFlHwfQxOoxyn28IE6n4BTZeHGimKxnqrbYwflsqFTLn7KHd1g1yZfo8qJ
fAyVsglSxWd/71xUTGmhB5MUy4gcIu7HpeAcLhXGTF88yY6wK7OCc1lGzZ5VbLDn
cr+mwcGIqU+bFhFChcUtJHsCOjTfyT30rysueoNTvfeHShTEnIApN+YetneGA6XT
wq1zZ0BvdjuoUpUbJ0UQd9M43aGY6qpGjHpPQXdCMJcvGWdbaOgq3o7I/JfOUjgr
IbJXDV7wPRaxJDAaxASJgD+xtv2193VBJ/ppOseFblJ3W3q2j2HpLlbd4rbHoEiR
RIoxb29/WT8N6/8r4FSKwJSL8+u1+yH3fayQnaXYoaHHvyS0EIjL61PbF/KnVNh8
NdF7jD6OV6JzrI9CsFAW
=m6bm
-----END PGP SIGNATURE-----

--=-6FNuuWqUM4DZa7vl/d24--

