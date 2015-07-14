From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 14 Jul 2015 00:45:33 -0700
Message-ID: <20150714074532.GI17550@atomide.com>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714071412.GA12844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150714 00:16]:
> On Monday 13 July 2015 17:36:07 Michael Welling wrote:
> > On Tue, Jul 14, 2015 at 12:02:44AM +0200, Pali Roh=C3=A1r wrote:
> > > I think nothing special. I just call:
> > >=20
> > > export ARCH=3Darm
> > > export CROSS_COMPILE=3Darm-linux-gnueabi-
> > > make rx51_defconfig
> > > rm -f arch/arm/boot/zImage
> > > make -j12 zImage modules omap3-n900.dtb CONFIG_DEBUG_SECTION_MISM=
ATCH=3Dy
> > > cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > arch/=
arm/boot/zImage.new
> > > mv arch/arm/boot/zImage.new arch/arm/boot/zImage
> > >
> >=20
> > Where are you getting rx51_defconfig from?
> >=20
> > This does not appear to be in the kernel source any longer.
> >=20
> > Can you try the above with omap2plus_defconfig?
> > =20
>=20
> It is in my linux-n900 repository: https://github.com/pali/linux-n900
> Repository contains more n900 specific patches but SPI code is unpatc=
hed
>=20
> https://github.com/pali/linux-n900/blob/HEAD/arch/arm/configs/rx51_de=
fconfig
>=20
> Later in week I can try to compile also with omap2plus_defconfig...
> But in my opinion kernel should not crash with different configuratio=
n.

After doing git bisect on it, looks like the breaking commit is
ddcad7e9068e ("spi: omap2-mcspi: Fix native cs with new set_cs").

That alone does not seem to revert, have not debugged further.

Regards,

Tony
