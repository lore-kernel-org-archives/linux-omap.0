From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Problems with 3.4-rc5
Date: Thu, 03 May 2012 16:07:22 +0300
Message-ID: <1336050442.14378.10.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
	 <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BUONxa7y40BKcmfMC1Qe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50839 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959Ab2ECNH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:07:27 -0400
Received: by lbon10 with SMTP id n10so2248474lbo.27
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:07:24 -0700 (PDT)
In-Reply-To: <WC20120503084938.900446@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-BUONxa7y40BKcmfMC1Qe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-03 at 09:49 +0100, Joe Woodward wrote:

> Both patches together results in slightly different behaviour, the displa=
y is still broken-=20
> it flickers on and off with occassional underflows before breaking comple=
tely.

Beagle works fine for me with omap2plus based config, and I think overo
also although I can't test it now as I broke my micro mmc adapter.

Can you send your panel definition? Any other things that could affect
display? Do you have PM enabled? Can you share your kernel config?

 Tomi


--=-BUONxa7y40BKcmfMC1Qe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPooMKAAoJEPo9qoy8lh71HzcQALItzzFxGZ+eUPgbmARkt3DL
+aOL4WqTeqc8G28siPr7glqcfPY9O+H+5+pamki1ahBbs2Pc9n4GiBqX9O+EsNp1
GUdOxHfCRUUe0Jz2yVv2lgslYz2aRU57koL8b7LwhPJPXh7S4sZjs871wW2WAqZI
RktswJZjoijlRzN1iOXMb58ILkMZkFPgB+qrSLPgaA8u3+fsLEGONpqGRF+9TDp2
VIH0iH8am/9O1DeEt5vI6pwW++Ewnkbjan9WZGDm/WcEyDsbRxlthaaJpxYGV4BG
ifGKDuoaNrGIc4advbKwO3J5Xj4EiUxPlqAz9MPU0xJ+Au32vb10wQ2ygDAUa36t
Eig2QQZMXTNgKlF/kV4mEkJSJ7eG+9glNHJsgFTQYPTjmydiFo+QHn5kcSPbbtBr
IR70RMRFI7SELGPnupOEybp/GZgxwMFL/LlBCHVS4n55VELm1aHFQ1jR1n7eUTZE
8o+tsc+HALe308OxI5OBkbQxkaj8w1H/eZJx8BOXhdKaAa3NVmfEpVYQW1BcdYKX
GiYQovgAHhyL9EE3f7XBeUktYYjq7aaL40jzKZLYEEbDdBeknhH/Bj/q3Hrs1z6G
F7HYDigR+WIt9FLG7+IuI8sopYUZO7GFBFEB0vLTdnwnDPFw1MQPI0ouepTzRPxb
hU0+e1Ldhbk5QdN3KN+B
=6U4H
-----END PGP SIGNATURE-----

--=-BUONxa7y40BKcmfMC1Qe--

