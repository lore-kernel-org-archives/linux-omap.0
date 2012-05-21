From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 14:36:21 +0300
Message-ID: <1337600181.2078.32.camel@lappyti>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
	 <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com>
	 <4DA41490-EF90-40A5-B3EE-E6281B4F1313@dominion.thruhere.net>
	 <1337598763.2078.28.camel@lappyti>
	 <8607C2E0-C1C0-49C6-9563-4CE1BF291E82@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YNbjbnUiIPCm4qdDEhe/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:36408 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405Ab2EULg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 07:36:26 -0400
Received: by lbbgh12 with SMTP id gh12so3047336lbb.25
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 04:36:23 -0700 (PDT)
In-Reply-To: <8607C2E0-C1C0-49C6-9563-4CE1BF291E82@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


--=-YNbjbnUiIPCm4qdDEhe/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-21 at 13:28 +0200, Koen Kooi wrote:
> Op 21 mei 2012, om 13:12 heeft Tomi Valkeinen het volgende geschreven:
>=20
> > On Mon, 2012-05-21 at 12:59 +0200, Koen Kooi wrote:
> >> Op 21 mei 2012, om 11:41 heeft Tomi Valkeinen het volgende geschreven:
> >>=20
> >>> Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
> >>> remove custom PD GPIO handling for DVI output") moved TFP410 chip's
> >>> powerdown-gpio handling from the board files to the tfp410 driver. On=
e
> >>> gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved i=
n
> >>> the Beagle board file. This causes the tfp410 driver to fail to reque=
st
> >>> the gpio on Beagle, causing the driver to fail and thus the DVI outpu=
t
> >>> doesn't work.
> >>>=20
> >>> This patch removes the gpio_request_one() from the board file.
> >>>=20
> >>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>> ---
> >>> arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
> >>> 1 file changed, 1 insertion(+), 2 deletions(-)
> >>>=20
> >>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> >>> index 8ede8d2..72ad1f6 100644
> >>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> >>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> >>> @@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
> >>> 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> >>> 				  mt46h32m32lf6_sdrc_params);
> >>>=20
> >>> +	/* DVI power down GPIO */
> >>> 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> >>=20
> >> Wouldn't it be an output rather than an input?
> >=20
> > Indeed. Note that I didn't change the line above =3D).
> >=20
> > It seems this was changed last December:
> >=20
> > -       omap_cfg_reg(J25_34XX_GPIO170);
> > +       omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> >=20
> > I wonder if the mux init is even necessary. Shouldn't the bootloader se=
t
> > the muxes?
>=20
> It'd rather have the kernel reset the muxes to the proper value to ensure=
 a known state.

Well, I think all this needs to be handled differently anyway with
device tree. If I've understood correctly the driver using the GPIO
should configure the pin when the driver starts. But if the driver is
not loaded/compiled-in, then it's again up to the bootloader.

Or is there going to be a board specific mux-init with devtree?

 Tomi


--=-YNbjbnUiIPCm4qdDEhe/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPuii1AAoJEPo9qoy8lh711WMP/jJ2deNLoTnYgQ8tS79kcQGx
XQuO4scjrN+VL+wBWnX9tWHT9CE2slRQg9TAzffzyfP/VimSHACkhkQJ5Xaeus8t
Tl5ygzIsqAmmVC0Cxmw70/uoFbj0/EK4/+GSBowrvVh3gHEaVN0jo/ZOX6I0sIvZ
cQXSBHBWo/7H0FyltngX5YVBlLu4031nXr1KsGas6P7fRqVusKXWhR+Xa0KeBRYO
sQBKYAXilcL0aVsACEeHigYu5Y6HccZ4oa/BIZGb9q8NYlYyvE7Y8s/Wovut0qL3
mE/Sx1T/+0HmEYRW4ishMz8iGupEx54izH9z0kSS3oAQ9E11Ae/CjmeMsIRPFgfD
8nvcVgkWjlJ5X/lVmaDNCzXwm2WjKxm7ippko5bMyehruxu2ARGnkK1j/jQ/329h
rkK37bowPtEZHzDFxLV3Tdf49+KXHM2/+GVb5VbOJOf4QPu9rofMwzVjbJrX6Bs8
nqdpXWgiSSn6ysl7ENdD9AzNuRcWAuEcAzQbPrHOCvA4U2xGTZhW8O+xbhFK/s5H
4F9JdqVg9MlVo1E1Njh+c6LAKlqhcXBGvW+ArjetM1ipij/32cMzt2e1x08M7MBV
QymItV75XJCo4apSGB3OVhz98NzvVrVoPhG5Eg3oicD8SA3lDu6IF4ICT4kp4cDo
RlZU9vT5xukyf3vhDsqn
=/6OP
-----END PGP SIGNATURE-----

--=-YNbjbnUiIPCm4qdDEhe/--

