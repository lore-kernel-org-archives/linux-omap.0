From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Fri, 2 Nov 2012 12:49:20 +0200
Message-ID: <5093A530.5050302@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1C4A96E28020D6FF6BC54C35"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36294 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab2KBKt0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 06:49:26 -0400
In-Reply-To: <5093A3FB.1060806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enig1C4A96E28020D6FF6BC54C35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-02 12:44, Archit Taneja wrote:

> Hmm, that makes sense. Anyway, I don't think it's really bad if we refe=
r
> to dssdev->channel for now.

It is, because dssdev->channel doesn't exist with DT.

With DT we either need to figure out the channel in omapdss at runtime,
or add a property to the DT data telling the channel. And adding such a
property is not correct, as DT should be about describing the HW.

 Tomi



--------------enig1C4A96E28020D6FF6BC54C35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQk6U0AAoJEPo9qoy8lh71tO0P/RhXs92N+TdwUyyZCIqgy/aU
sMOrgc9DGHwft5hbvhUA0+apYci/DV2aIS0gxaGmujiXX+JoP6gNJsueMdqICguY
NuhJPUXJM6B2DyMNulcYqp9hUQ0Kdo934yDv/kJFQq7xgiqTiZ0awdYWHlkIcWHt
fenPyCukA1jVb0cBENTutSdinfFSwYZaxXz0a4kdJuqcTNwUn5FX/TPhm+Lp8wdq
9l8vWI/CA0VzZV6A1mY95jGYIdAuuesYarVjIT29hmuml1jr8nRjKaGrJt/9jCMZ
aB5uvIb6QJhlBhjnq0FomtxUSacESRmM6DZwtxWYv1YKmCPED0ad3Sfp2IDbi95G
H/MEhyvC6hIhIQQqU84Ws0y60y68lc6WKfPhn5z8TNpJJN9501t935+s/3cbU+4G
FmRuBF+NxZ1eDIrRlZVtDQfsMeUPQm4tA+EVmgrSI28eAjM5umhdelKIeGIsUQEE
cCml9LKxjnOiv+sKRhROBHOIs5KHcsNiSkJUUipPHRpEZgroGhwauMkpKbKkUfbH
9Ig4HUPlCe7r2j0lNWBRbj2ZlJNt7UvAEDK9n3G/NDm0kmqSOkdo+u96NqEYqxjZ
uvyV1xiCZs6rqEYz7lHNCf7a2u096RhYuClpuju9yJFN2IzqfxlxpYwcn1yBgNku
wW9oRiRsf+sLth52NFjN
=Gajc
-----END PGP SIGNATURE-----

--------------enig1C4A96E28020D6FF6BC54C35--
