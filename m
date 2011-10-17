From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/27] cbus: tahvo: convert spinlock into mutex
Date: Mon, 17 Oct 2011 21:04:12 +0300
Message-ID: <20111017180411.GA31828@legolas.emea.dhcp.ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
 <20111017172035.GB27515@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:42861 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760Ab1JQSEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 14:04:16 -0400
Received: by mail-bw0-f44.google.com with SMTP id s6so3742061bka.3
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 11:04:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111017172035.GB27515@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2011 at 10:20:35AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [111013 01:01]:
> > GPIO operations can sleep, so move to a
> > mutex.
>=20
> Great, seems to boot on n800 so pushing all into
> cbus branch.

cool thanks. I think this is pretty much ready for mainline. At least
retu. Unless you have any other plans for these little guys.

They have been missing from mainline for a loooong time though. I'm
still concerned about the whole cbus bus implementation. Maybe we should
the i2c framework (which already supports a few buses) and implement
i2c-cbus-gpio.c ?? What do you think ?

--=20
balbi

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOnG4bAAoJEIaOsuA1yqREBCgQAKcas56n2uWFJeB2J4/zJCJp
g8UcN/9SxKXNKGyT6R2bz4NCGLpbOy2S0rIYYuzqme5bBGoBun+CkBL8/+Rz0Mpy
av2vuKRVuI8om+sMKJS6qR6mV1JRlQaz3Ck6xphJ2OOQvI/x9bTNG2j0dGtvHaO8
+HzJuMQA7zrB7YfGzmf5FTq4IPmq6ha5oV0X328wZgx3EEUtfcGQbf4Yo4BIrFpF
L3WnOIrumUuSd4a7aChictg4M4ifBzcRp7GEXXDgws/xEo2m9guW24n5t6VtDbc7
XCU0apgUtnPwkCPV4UrGTrXc2Ug35fL0wtHLYQst/oMZsquYrq0w34X2uWrHl/ED
5dw6A4hhzx8cx80Kq6G1hbzi7rsJWneu6YOfTr+bwntFYdMaIhQom96DeX4zU2pk
rpgyUCgjShmkYmuzsC4wweXgfzNfrbeueV31Hc/yLHDr6OGrElIlpH3i90pgmrBO
b0SnV85fgBqtpkylg2C+ihY6Tp8kds7FdsZJ3p1lGPk1K6Lv1qQBybECnXYRVGIV
WARTYK3cja2kmSGHFS+vZssn+c6vsEkCOHnPTpObXT+RGhXH4PJHNM8Ekb/6/qaf
TKvQqDaqocT0//eqPWDTo+pZCDG1Wye5H4/Z5smMJUaL6IOiKDb6yysKuM9QKTve
a5EHxxs7loqnSVZQMbzQ
=it+B
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
