From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Powering OMAP's pins
Date: Tue, 25 Sep 2012 20:05:00 +0300
Message-ID: <1348592700.2342.49.camel@deskari>
References: <1348568474.2342.35.camel@deskari>
	 <20120925153806.GC4840@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-FRX0w9nSUMImn2mOZASH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37148 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757401Ab2IYRFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 13:05:06 -0400
Received: by lbon3 with SMTP id n3so443246lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 10:05:02 -0700 (PDT)
In-Reply-To: <20120925153806.GC4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--=-FRX0w9nSUMImn2mOZASH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-09-25 at 08:38 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 03:22]:
> > Hi Tony,
> >=20
> > Each pin of OMAP requires a particular power to be enabled for the pin
> > to function (Ball Characteristics table from data manual). Is there a
> > plan how this is managed with pinctrl? Currently each driver needs to
> > make sure the correct regulators are enabled for the pins it uses, whic=
h
> > is platform specific and messy.
> >=20
> > As a driver maintainer, I would wish that the pins would just get
> > enabled automatically when I call pm_runtime_get()...
>=20
> Hmm can you clarify a bit what exactly do you want to do there
> with pm_runtime_get()? Call the regulator framework?

Well, I'm not very familiar with pinctrl, but if I've understood right,
a set of pins are assigned to a driver in DT data (or wherever, that's
not relevant). Those pins should be automatically configured and enabled
when the driver uses pm_runtime_get() to enable its hardware.

And if I've also understood right, the pinctrl discussions related to
omap have only dealt with pin muxing itself. But that's not enough to
get the pin functional, but the relevant regulator needs to be enabled
also.

So when I call pm_runtime_get in the omapdss driver, I imagine that the
runtime PM and pinctrl would together handle muxing the pins for
omapdss's use, and also enable the relevant regulators to make the pins
usable.

 Tomi


--=-FRX0w9nSUMImn2mOZASH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYeQ8AAoJEPo9qoy8lh719lUP/ittg2y8jh/cnpuoAVwJka0G
FNjMpcTcYKThomaiNeJJtgKI64UHn3ovTW5n8hcUtIWjFT+qkCBXVOOt/TjlwuvM
AzQPTiPgWx1BVhjScHw4B+UycJ+lKubkxsQlZhZBSgG4HfUtAJ6b4MF0gV5VUoO5
GLHLofRcrgxQR+1NtLYh2l8HVvi+VizagYv9Gb7d5diqY0dtEVgeQMFGqAYm1TS8
+gR2UVGDXzXXHPKur78HQNBtceP82x+ApFdGLiN3B5AOHxWF6KIoeWDduPcChIhc
CN1q9gMJ3plOa1GbyCjckjxfMiyBgfBxCYxzl2KzIqA/skq8PhShsgIJoqVR6/3Y
OtI/Gv43M2NDflVYCue8ui4D7RihO0xuWv/lo8ml9QgxcsKOP8CNxy4gwLxcZR6j
AaYDOdBwFJGBNPwu4sVddpKAJdRAFRC1Zl7BnTWzO6M2zdAtYujJm2QxeisZM7nj
hXKfo7pxxwRgDo0FCXM+09pSY9pCMir3QDRk4fg2ujvhkNoIiqaS1t5axm2plV2p
O29F0Xd2HlPv7Eza6JelyV6+A8r6bo6QOUSyOYMtPhqMa6KmL6YV2CBKhUyf0mTe
fiUulY96T9SxvV7FW3TUrjNQpYsHCp/W9iGS4J4C37oBHDKfyZpvw4VVB3/vD+xF
lRn7h8xbcigj99498aXP
=gBXn
-----END PGP SIGNATURE-----

--=-FRX0w9nSUMImn2mOZASH--

