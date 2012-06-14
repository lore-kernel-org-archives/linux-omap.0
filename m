From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Thu, 14 Jun 2012 10:18:10 +0300
Message-ID: <1339658290.2236.5.camel@deskari>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YfhbH1RuSr8agA6xquhr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:50494 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377Ab2FNHST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 03:18:19 -0400
Received: by lboj14 with SMTP id j14so1584319lbo.7
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 00:18:17 -0700 (PDT)
In-Reply-To: <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>


--=-YfhbH1RuSr8agA6xquhr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-13 at 23:58 -0700, Russ Dill wrote:
> On Wed, Jun 13, 2012 at 2:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> > remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> > powerdown-gpio handling from the board files to the tfp410 driver. One
> > gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
> > the Beagle board file. This causes the tfp410 driver to fail to request
> > the gpio on Beagle, causing the driver to fail and thus the DVI output
> > doesn't work.
>=20
> Can you take the one I sent earlier instead?
>=20
> http://www.spinics.net/lists/linux-omap/msg69913.html

Hmm, that probably doesn't apply. The power-down GPIO is now handled in
the tfp410 driver, not in the board files.

Looking more closely at the board file, what are these nDVI_PWR_EN,
DVI_LDO_EN and DVI_PU gpios? There's no "enable line" on tfp410. Only
the power-down gpio, which is none of the above...

 Tomi


--=-YfhbH1RuSr8agA6xquhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP2ZAyAAoJEPo9qoy8lh71NW0P/2SumklXLYZRkCg0k6a2scbt
4HbnBasbWiof0gXUVl4F+CviCizcOfHEtmcV+u0ZJXs3y7sUm3S1RtVxmcBQD+Vn
DZ2B5BoPsI5MOs26l49Dkiv2xtTBTAdJ3nNPh3n2yIcp6Udi38O/eVbvOQ/c0Fdd
1nG9iJA4Ra53e/YTORxl0xS06iMkgUIbg2Oq3wtF85HRbN/BRfqhN1OO4gHBf90o
rGgvd7nz7hYTW1/MYS87zTYO+gSxSUrAa6s5vnRlNffajCRELDKgrPjs0Rr8HO58
Ah5SW0+XaOmJDZ22APm043ATmNiqEug4NNNO1zNl7UU8ZKoU7CevApkMoOJb1nHA
bba/Exwg2wzAKGAC2ZHhIHNuPC31OAcd2MKA2r8iIq4Ysc8v0t7DdbM5zwKoHkuv
4W2PGLMeYh24BR7IqS//CjdkaqXS0KtvzfY8AAKWGzw4ZQw6nkLR0sl2SNz4vdZx
4+4VJoBrtnKsgZpw+iQ73ZXDfQB/syYMFgc94WmXRYBwt6t/BOF+3mtpLMs7329L
ddS61VG6MdyrJokkzHbxjoynZnVRcGt81JE9moTY07+OfAPGAh8clcEq7H4wzjN1
ldw7lwfqX+aSpgD3BOFS9LJ6PQNprlPX21pdAyZcJ0eNb/wsYUDQ7L5QFxa2LAjg
Z4bR4fuZRfWlAW1xnubf
=JV5B
-----END PGP SIGNATURE-----

--=-YfhbH1RuSr8agA6xquhr--

