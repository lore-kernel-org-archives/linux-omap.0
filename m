From: Sebastian Reichel <sre@debian.org>
Subject: OMAP4: crypto acceleration (AES, SHA, ...)
Date: Thu, 13 Sep 2012 23:57:08 +0200
Message-ID: <20120913215707.GA22825@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:52533 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882Ab2IMV5P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 17:57:15 -0400
Received: from comu.ring0.de (unknown [127.0.0.1])
	by ring0.de (Postfix) with ESMTP id C04422C58E64
	for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 23:57:11 +0200 (CEST)
Received: (from spamd@localhost)
	by comu.ring0.de (8.13.8/8.13.8/Submit) id q8DLvBe8020511
	for linux-omap@vger.kernel.org; Thu, 13 Sep 2012 23:57:11 +0200
Received: from sre.ring0.de (unknown [46.22.209.71])
	by ring0.de (Postfix) with ESMTP id 963382C58E5B
	for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 23:57:10 +0200 (CEST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Are there plans to add crypto acceleration support to OMAP4? Has
this hardware component been removed from OMAP4? I tried to load the
code written for OMAP3 on my Pandaboard, but it just outputs
"platform not supported":

[    0.370513] omap_init_sham: platform not supported
[    0.375488] omap_init_aes: platform not supported

-- Sebastian

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQUlazAAoJENju1/PIO/qas8cQAKELXOGgyg4NEagB9GxJWxc3
teKoVc74UxdCZgkS14p9zS0Vx1XJUm2lGWeyIu0JC1ymB6FwpTj2gqFDobrMeZJH
wW0kr6CBH5jSeR1I4n46eyHNmfVXBt5t2LF6+4//FeT7C795Z/HuCF4a5pkZbW+/
OLZFKwTA5wigWCGNbCK3ClilwXSZzhjSH3/VPPOIOZBzvBnDRo+Sk6wMlEOI8Za5
Cf12qamVW/iodqzZKtKRqAVDz5oLepEa1KCT8o8XDQd9T//qiYxUT8c/uvOQGgVV
CQTNYsxzoYUh7CgyM6Ld6Zq2l3wuaOo/8PGVXSprbLQcIWrRn+BlssJjxAzT2Jtw
7leRtSNsB4iO6Lirw2G5MlEQoTuPlt9KAdu51r3s1mXvLPhJ+MedrQKIrHvII2vS
KegbuI1F3VaPiLVO62R9Pz9x80KfjI3ixMU4oxsK9sjMKwbWbpYdZyAtcDTi0o9+
pKFqYxGOQ41MgsHbTeK9xqjMRtZRHcK4dLkMe/j536MVjwm6RHDAJNkAQ5jDvYn9
tTS+9peAflvAlM+K5mJq2wweLTtpRNuQvXV6NcgJuD/2TIojOishiJzCTrHCCdGQ
UqihXBsixV5LyWiTcssYk6JaIg+B+FommIZAEgV6q19SSflgdIgAEL9u9UbJVl2t
8RZiDQp3eWa0ntoCg48J
=s0VG
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
