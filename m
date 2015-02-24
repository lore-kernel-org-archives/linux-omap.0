From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP3-N900: Fix offset for smc91x ethernet
Date: Tue, 24 Feb 2015 10:02:28 -0800
Message-ID: <20150224180228.GC11056@atomide.com>
References: <1424364590-14603-1-git-send-email-pali.rohar@gmail.com>
 <7411731.0J5JRAOyMm@wuerfel>
 <201502201052.47515@pali>
 <20150220152856.GH32521@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150220152856.GH32521@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150220 07:47]:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150220 01:56]:
> > On Friday 20 February 2015 10:24:35 Arnd Bergmann wrote:
> > > On Thursday 19 February 2015 17:49:50 Pali Roh=C3=A1r wrote:
> > > > Offset for smc91x must be zero otherwise smc91x linux kernel
> > > > driver does not detect smc91x ethernet hardware in qemu
> > > > N900 machine.
> > > >=20
> > > > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >=20
> > > Is that the same offset on real hardware, or could this be a
> > > mistake in the qemu model?
> > >=20
> > > 	Arnd
> >=20
> > In original Nokia 2.6.28 kernel is offset also set to 0, see:
> >=20
> > https://gitorious.org/linux-n900/linux-n900/source/629fc5ab00cafb31=
272c478efa2c2b35fabd4c70:arch/arm/mach-omap2/board-rx51-peripherals.c#L=
42
> >=20
> > https://gitorious.org/linux-n900/linux-n900/source/629fc5ab00cafb31=
272c478efa2c2b35fabd4c70:arch/arm/mach-omap2/board-rx51-peripherals.c#L=
274
> >=20
> > Tony already tested offset 0 on real HW and wrote that it is
> > working too, just show some warning. But qemu with offset 0x300
> > does not work.
>=20
> Yes it works with offset 0, except the smc91x warns about not
> using the default offset 0x300 based on the EEPROM. As only
> three address lines seem to be connected, we can use offset
> 0 just fine, and update the EEPROM configuration as needed.

Applying into omap-for-v4.0/fixes with updated comments.

Regards,

Tony
