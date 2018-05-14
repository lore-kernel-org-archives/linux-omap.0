From: James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Date: Mon, 14 May 2018 22:42:02 +0100
Message-ID: <20180514214201.GA29541@jamesdev>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
 <20180514213719.o6ceftp2quem3s7f@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180514213719.o6ceftp2quem3s7f@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Sergey Lapin <slapin@ossfans.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Ralf Baechle <ralf@linux-mips.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, May 14, 2018 at 11:37:20PM +0200, Wolfram Sang wrote:
> > diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> > index 4e79dbd54a33..fa75d75b5ba9 100644
> > --- a/arch/mips/alchemy/board-gpr.c
> > +++ b/arch/mips/alchemy/board-gpr.c
> > @@ -29,7 +29,7 @@
> >  #include <linux/leds.h>
> >  #include <linux/gpio.h>
> >  #include <linux/i2c.h>
> > -#include <linux/i2c-gpio.h>
> > +#include <linux/platform_data/i2c-gpio.h>
> >  #include <linux/gpio/machine.h>
> >  #include <asm/bootinfo.h>
> >  #include <asm/idle.h>

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoCqAAKCRA1zuSGKxAj
8nygAQCNvidVKuxZlkvSnxLStRpTqVCTrCRwmEaSQtc5VUpZxQD+MqHBbBboGCpp
2ebujn+XBLyfqCKc2jDW2UT4S6LpPgk=
=zJkS
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
