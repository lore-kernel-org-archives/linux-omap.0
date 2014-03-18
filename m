From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Tue, 18 Mar 2014 07:29:34 +0200
Message-ID: <5327D9BE.80503@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il> <532692A7.7000509@ti.com> <5326F71C.1060602@compulab.co.il> <5326F893.3080607@ti.com> <53270510.1030301@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EWjiCmDsQPg9KxTk3NS27cKa0FTHxkjgu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40739 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbaCRFaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 01:30:10 -0400
In-Reply-To: <53270510.1030301@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--EWjiCmDsQPg9KxTk3NS27cKa0FTHxkjgu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/03/14 16:22, Dmitry Lifshitz wrote:
> Hi Tomi,
>=20
> Unfortunately, I have a lack of experience with DT DSS stuff.
>=20
> How should I define the endpoints and the connector in my case?
> Please, could you provide some reference.

See Documentation/devicetree/bindings/media/video-interfaces.txt for a
description of the ports and endpoints.

If your board is similar to uevm except you don't have the tpd12s015,
then you just need to remove the tpd12s015 from the .dts file, and
connect the OMAP's HDMI output directly to the connector.

> Regarding omapfb, is it sufficient to turn it on in the Kernel config?

Yes.

 Tomi



--EWjiCmDsQPg9KxTk3NS27cKa0FTHxkjgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJ9nCAAoJEPo9qoy8lh71UQ0QAIem9Hkj9lF0tQDZBY5RKboW
vtPimjyrUQHTHDZuY7HLe9e83ZLbtr16+cjNHSESGXRd1+Qf2t3MO8F2zA25sqLo
9z2aTLNYeABKH4KAKLWXcCLEANtHq4Uki+FzzCDWkQnQmIbedyxp+0tfGxGiv5YT
Jhgkk/XBUrpUjCgOaGUE0j/Fxriv/sZLiC8OQ0uWMccOGN/NZrzpZ0VMKltOkiaR
8r07fvSyQ0GN79L5ksQfiul9xejB+pJC49AxLEKzKdVw8xZ4p8URHF7UXztb6ejr
zqkDktX7MCfIQLVvUM/sQPzFh/nQxT2JWJAv38Mv+yG+zwscyktJlsJrTBTqXSnF
HhOWfi/9+A+KFBS3SKGbZtebyWVgCzjDmJDTZozp0uOWVOjgavTBPW6MHf5gi/O+
e2yiOjUhxARiEURG82olFa4oS0BGTzHvbjqIokimSQAEqCEd9bv8XPA64+GCuMjK
cBGJIWkGc6J+YXbErphRf31sAEEWSj/8z8HAKvkmwPolalIs07pIh8lmOwiM3Adp
anDKkiV5MTJVzhN99+6VyJ9j0ZFVgG2xDUUWlLJA/r6yQy/pFBcu3muHRY7i4cVQ
0Ly6j09ChuAGD+CYMaouLdTkDSJWOtt23KhQX5uHpc9/vpMJphZc5UR4Y9nyl0YJ
05gKE02mATdg4/m8n5Dj
=eyOs
-----END PGP SIGNATURE-----

--EWjiCmDsQPg9KxTk3NS27cKa0FTHxkjgu--
