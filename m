From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 17:36:07 -0500
Message-ID: <20150713223607.GA23001@deathray>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507140002.44119@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 14, 2015 at 12:02:44AM +0200, Pali Roh=E1r wrote:
> I think nothing special. I just call:
>=20
> export ARCH=3Darm
> export CROSS_COMPILE=3Darm-linux-gnueabi-
> make rx51_defconfig
> rm -f arch/arm/boot/zImage
> make -j12 zImage modules omap3-n900.dtb CONFIG_DEBUG_SECTION_MISMATCH=
=3Dy
> cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > arch/arm/=
boot/zImage.new
> mv arch/arm/boot/zImage.new arch/arm/boot/zImage
>

Where are you getting rx51_defconfig from?

This does not appear to be in the kernel source any longer.

Can you try the above with omap2plus_defconfig?
=20
