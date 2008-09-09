From: Tony Lindgren <tony@atomide.com>
Subject: Re: Error compiling for OMAP 5912
Date: Tue, 9 Sep 2008 11:29:17 -0700
Message-ID: <20080909182917.GT29054@atomide.com>
References: <48C6BF1F.5020203@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56245 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbYIIS3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 14:29:22 -0400
Content-Disposition: inline
In-Reply-To: <48C6BF1F.5020203@instramed.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ram=F3n?= Finger Lilienthal <ramon@instramed.com.br>
Cc: linux-omap@vger.kernel.org

Hi,

* Ram=C3=B3n Finger Lilienthal <ramon@instramed.com.br> [080909 11:24]:
> Dear friends,
>
> I am trying to compile the kernel for omap5912, and it's not working.
> My current kernel version is:
> VERSION =3D 2
> PATCHLEVEL =3D 6
> SUBLEVEL =3D 27
> EXTRAVERSION =3D -rc5
> NAME =3D Rotary Wombat
>
> I got this error from compiler:
> ---------------------------------------------------------------------=
--------------------------------------
> LD drivers/hwmon/built-in.o
> CC drivers/i2c/i2c-boardinfo.o
> CC drivers/i2c/i2c-core.o
> CC drivers/i2c/i2c-dev.o
> LD drivers/i2c/algos/built-in.o
> CC drivers/i2c/busses/i2c-omap.o
> LD drivers/i2c/busses/built-in.o
> CC drivers/i2c/chips/tps65010.o
> LD drivers/i2c/chips/built-in.o
> CC [M] drivers/i2c/chips/tlv320aic23.o
> drivers/i2c/chips/tlv320aic23.c: In function =E2=80=98omap_mcbsp3_aic=
23_clock_init=E2=80=99:
> drivers/i2c/chips/tlv320aic23.c:113: error: implicit declaration of =20
> function =E2=80=98OMAP_MCBSP_WRITE=E2=80=99
> drivers/i2c/chips/tlv320aic23.c:113: error: =E2=80=98SPCR1=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:113: error: (Each undeclared identifi=
er =20
> is reported only once
> drivers/i2c/chips/tlv320aic23.c:113: error: for each function it appe=
ars =20
> in.)
> drivers/i2c/chips/tlv320aic23.c:114: error: =E2=80=98SPCR2=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:117: error: =E2=80=98PCR0=E2=80=99 un=
declared (first use =20
> in this function)
> drivers/i2c/chips/tlv320aic23.c:120: error: =E2=80=98SRGR1=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:121: error: =E2=80=98SRGR2=E2=80=99 u=
ndeclared (first =20
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:124: error: implicit declaration of =20
> function =E2=80=98OMAP_MCBSP_READ=E2=80=99
> drivers/i2c/chips/tlv320aic23.c: At top level:
> drivers/i2c/chips/tlv320aic23.c:287: error: redefinition of =20
> =E2=80=98aic23_power_down=E2=80=99
> arch/arm/plat-omap/include/mach/aic23.h:122: error: previous definiti=
on =20
> of =E2=80=98aic23_power_down=E2=80=99 was here
> drivers/i2c/chips/tlv320aic23.c:296: error: redefinition of =E2=80=98=
aic23_power_up=E2=80=99
> arch/arm/plat-omap/include/mach/aic23.h:118: error: previous definiti=
on =20
> of =E2=80=98aic23_power_up=E2=80=99 was here
> make[3]: *** [drivers/i2c/chips/tlv320aic23.o] Error 1
> make[2]: *** [drivers/i2c/chips] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> ---------------------------------------------------------------------=
--------------------------------------
>
> Any help will be welcome!

Sorry, we're in process of getting rid of the old audio drivers to
move to the omap ASoC, and the old drivers will then be removed.

Please search for the mailling list archives for ASoC and osk,
there's some work in progress to make the omap ASoC to work with osk.

Alternatively, there's a patch that still allows direct messing of
McBSP registers that you can use as a temporary fix.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
