From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP PM constraint to disable OPP50
Date: Thu, 23 Feb 2012 09:28:52 +0200
Message-ID: <1329982132.1820.24.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-iucX8dQ4StcXRAggqwf3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57858 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753175Ab2BWH24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 02:28:56 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id p5so2087234lag.16
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 23:28:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>


--=-iucX8dQ4StcXRAggqwf3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is an old issue, and I've mentioned earlier, but I think we should
finally do something about this. Or perhaps this can already be done,
but I don't know the solution.

The problem is that various DSS clocks have max frequencies that depend
on whether we are at OPP100 or OPP50 (e.g. table 10-4. DSS Clock
Frequencies in OMAP4 TRM). Some of these clocks come from the PRCM (like
DSS_CLK on OMAP4), but some are generated internally by DSS (like pixel
clocks).

While the clocks coming from PRCM could perhaps be handled automatically
(from DSS's point of view) by the PM/clock framework so that OPP50 would
be disabled if the clocks are over the OPP50-limit, I guess that's not
quite correct. The max freq limitation is inside DSS HW, not in the PRCM
side (well, I'm guessing so). And as we anyway need to handle some of
the clock limits inside DSS, I guess it's simpler to handle them all in
DSS.

But the main question is, how should it be done? Afaik the dss driver
cannot say "stay in OPP100" to the PM framework. I guess the closest
thing is to set a constraint to memory throughput with an arbitrarily
high value, thus forcing OPP100.

But even if it's quite easy to come up with an arbitrary value that
should be high enough for years to come, this approach feels rather
hacky. Can it have side effects? May it cause overclocking, as the PM
framework thinks we need as much bandwidth as possible? Does it cause
higher power consumption because something in L3/Core/somewhere is kept
in a high perf mode for the high mem throughput, even if we don't
actually need high throughput?

 Tomi


--=-iucX8dQ4StcXRAggqwf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPReq0AAoJEPo9qoy8lh71zJoP/08cIDUyCgsw5ciPGqt0hH3C
0lnAiO/9yn3bHNXpRkIKB2qJVdxbL53F8n05pxGv/eGA8Uqv51Wk1Sngk6DzJhx2
JP68MB+AnUmpTiCRdkT6H3jurwdZmnKHoAYQrpWiQRcCYXHlzAS71w4YM12kcrGh
3yGONqYRD9staS1eQ8MTgmipPbRMgQRCsVGuOCCGxpq9DRlLFTTo55AGn8Lnp+Qu
2+ETfQ6K7mbuXxj9p6uz+caVt2rBL4LrlH07vFCMCSjl0AvCtv/3rwyq91tPxUYw
ccIU/6mvFUFTpMOShHyiIl28MHzncNYbE16wMJVB4ZxDema2pY4+Ta6EV1dOCbuA
NDurvV21oKQEvnC04C6Dr+ORJNcA0xuEiIrY/3DZQx0QyItcuGtb1G6QIigkDhQp
nGkRXkhiiVcvTSMWzDjYdxM96D8T4M9BcKq/bzxafkgdKo7Bf7jf+Q9vyWeL1y+H
IcDOW1hbnJzj2imNXz+gb1fcfQJJQqA1RPGmirToBvgr8KMc1Ufb40CUzesiboAR
8iYl8zPIkIop4NSL0C/nUyiRRVaE9ji/mUmQKDFW80WRUq+8DWdaVizts+/qCz80
susUogMkijyO9k6EpO7Z99tVesgp0GizZ+7EXjlQ6soBcaFpTyudgCNOF+/JyB7d
6HWhLGkPwCUSmwB/zols
=kLGN
-----END PGP SIGNATURE-----

--=-iucX8dQ4StcXRAggqwf3--

