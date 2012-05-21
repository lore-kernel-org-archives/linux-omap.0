From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 14:12:43 +0300
Message-ID: <1337598763.2078.28.camel@lappyti>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
	 <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
	 <4DA41490-EF90-40A5-B3EE-E6281B4F1313@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-d90cr5he4C5ozjlui9hI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53761 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119Ab2EULMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 07:12:48 -0400
Received: by lbon10 with SMTP id n10so4125219lbo.41
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 04:12:45 -0700 (PDT)
In-Reply-To: <4DA41490-EF90-40A5-B3EE-E6281B4F1313@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


--=-d90cr5he4C5ozjlui9hI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-21 at 12:59 +0200, Koen Kooi wrote:
> Op 21 mei 2012, om 11:41 heeft Tomi Valkeinen het volgende geschreven:
>=20
> > Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> > remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> > powerdown-gpio handling from the board files to the tfp410 driver. One
> > gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
> > the Beagle board file. This causes the tfp410 driver to fail to request
> > the gpio on Beagle, causing the driver to fail and thus the DVI output
> > doesn't work.
> >=20
> > This patch removes the gpio_request_one() from the board file.
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> > arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-om=
ap2/board-omap3beagle.c
> > index 8ede8d2..72ad1f6 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
> > 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> > 				  mt46h32m32lf6_sdrc_params);
> >=20
> > +	/* DVI power down GPIO */
> > 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>=20
> Wouldn't it be an output rather than an input?

Indeed. Note that I didn't change the line above =3D).

It seems this was changed last December:

-       omap_cfg_reg(J25_34XX_GPIO170);
+       omap_mux_init_gpio(170, OMAP_PIN_INPUT);

I wonder if the mux init is even necessary. Shouldn't the bootloader set
the muxes?

 Tomi


--=-d90cr5he4C5ozjlui9hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPuiMrAAoJEPo9qoy8lh71JqEP/AuqXCLqJKfSX41Pqcf5syEh
lVbWPToUTiVjIycO0akj4RhUkxL8HE7G5b8zHuzUfGQsoTYM8GW69R8GU9N/ze2r
SXtd1pXbuZDBDQxopjToucm9r73pAVgDZ8iX8cEmzeVEafVj/sr528lcU/Jmvyjl
70UffIxMcc+AcHwsUrbcYY+/dhoCPzrBijPxmbloAAEAbuDM2E2ZXjlv5IME7tca
p4NrdQKk/i1XvrKtIq/68c6fh1ZsjqcSDKucWSU7lZCed/WXnDm4nSgAWhSD91SF
aoRLB6jQ0mCZS4UaUZPzSVPlBDh0ydw5qdcJ9Ac7MbG+Rw/MXndadpkVhMAdkdTp
kNNrCfJkKuBBGNaQ/LZi5F4Np1wH0WcVbkps6lVpPc/qy3g3FxqaHDwLNE81OOtc
A32SRcpZPpLoU8vrKC0YuLf+IIYHPxAaEEv0WZFM1GTZN6/ptTbUDlr1JX0Hf302
BzClqqwzb0x7Z6FF8g7fyyex8AJldw42yC7ZIWXF1nBaQu7kzrdkUDqdb/FTMo9G
UYMg6pHuTH5reiATvX1j2Ets8LmfBgkFoup+OJ0EaI+gD+kVDSwt2gNwPXeY+84K
NEsB5o2yMMW+zDDrfc+TN4272+ZDAfJ1SkTjCqsGKrKZpOAJKl0jqZZeFCjpQs5Y
LKsmrSmW7i7gOesIwEGM
=nvPQ
-----END PGP SIGNATURE-----

--=-d90cr5he4C5ozjlui9hI--

