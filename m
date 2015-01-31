From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.19: Nokia N900 - boot errors
Date: Sat, 31 Jan 2015 13:11:30 +0200
Message-ID: <20150131111130.GG591@fuloong-minipc.musicnaut.iki.fi>
References: <201501311028.46357@pali>
 <20150131110509.GF591@fuloong-minipc.musicnaut.iki.fi>
 <201501311208.31745@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201501311208.31745@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Jan 31, 2015 at 12:08:31PM +0100, Pali Roh=E1r wrote:
> On Saturday 31 January 2015 12:05:09 Aaro Koskinen wrote:
> > Hi,
> >=20
> > On Sat, Jan 31, 2015 at 10:28:46AM +0100, Pali Roh=E1r wrote:
> > > when I boot 3.19 kernel on real n900 device it show these
> > > errors in dmesg:
> > >=20
> > > [    0.256103] hw-breakpoint: debug architecture 0x4
> > > unsupported. [    0.257659] In-band Error seen by MPU  at
> > > address 0 [    0.257720] ------------[ cut here
> > > ]------------ [    0.257781] WARNING: CPU: 0 PID: 1 at
> > > drivers/bus/omap_l3_smx.c:166 omap3_l3_app_irq+0xd4/0x118()
> >=20
> > This should be fixed in 3.16-rc6.
>=20
> Apparently not, still present in 3.19.0-rc5+.

Sorry, I made a typo. I meant 3.19-rc6. The commit is:

	commit 4b149e417463bbb6d1d9b805f729627ca2b54495
	Author: Felipe Balbi <balbi@ti.com>
	Date:   Tue Jan 6 14:38:08 2015 -0600

	    irqchip: omap-intc: Fix legacy DMA regression

A.
