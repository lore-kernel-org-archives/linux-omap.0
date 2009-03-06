From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rft 2.6.29-rc3-omap-git] omap3 evm: MMC switch support
Date: Thu, 5 Mar 2009 16:13:50 -0800
Message-ID: <20090306001350.GE6784@atomide.com>
References: <200902041523.07767.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403FA81AD36@dbde02.ent.ti.com> <200902081225.14286.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56030 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbZCFANz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 19:13:55 -0500
Content-Disposition: inline
In-Reply-To: <200902081225.14286.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Pillai, Manikandan" <mani.pillai@ti.com>, OMAP <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090208 12:25]:
> On Wednesday 04 February 2009, Pillai, Manikandan wrote:
> > I tested the patch on the OMAP 3 EVM. I still find that the
> > hotplug feature does not work on the OMAP3 EVM. The issue is
> > that if I read the gpio_cd, I am getting the correct value
> > on the gpio pin(INSERT =3D 0, PLUGOUT =3D 1) but the interrupts
> > are not generated. =20
> >=20
> > The mmc0 interrupts always shows 0.
>=20
> Are you getting any other IRQs through the twl4030 code?
>=20
> There's not a lot of debugging I can do with this, since
> I don't have an EVM ... and since this seems to work OK
> on other boards.  (Testing on SDP being easiest, since
> it's got a slot not tied down with MMC root.)
>=20
> This patch was basically sent as a seed, since nobody
> else seemed to be filling in the missing MMC/SD pieces
> on that board.

I've pushed this, looks like the mux.[ch] changes had already
been applied in another patch.

Tony
=20
> - Dave
>=20
>=20
> > root@172.24.190.49:~# cat /proc/interrupts=20
> > =A0 =A0 =A0 =A0 =A0 =A0CPU0
> > =A011: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0INTC =A0prcm
> > =A012: =A0 =A0 =A0 =A0 =A04 =A0 =A0 =A0 =A0INTC =A0DMA
> > =A025: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0INTC =A0dispc
> > =A037: =A0 =A0 =A0 1724 =A0 =A0 =A0 =A0INTC =A0gp timer
> > =A056: =A0 =A0 =A0 =A0267 =A0 =A0 =A0 =A0INTC =A0i2c_omap
> > =A057: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0INTC =A0i2c_omap
> > =A061: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0INTC =A0i2c_omap
> > =A072: =A0 =A0 =A0 =A0178 =A0 =A0 =A0 =A0INTC =A0serial idle, seria=
l
> > =A073: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0INTC =A0serial idle
> > =A074: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0INTC =A0serial idle
> > =A083: =A0 =A0 =A0 =A0 43 =A0 =A0 =A0 =A0INTC =A0mmc0
> > =A092: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0INTC =A0musb_hdrc
> > =A093: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0INTC =A0musb_hdrc
> > 335: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0GPIO =A0ads7846
> > 336: =A0 =A0 =A0 3565 =A0 =A0 =A0 =A0GPIO =A0eth0
> > 369: =A0 =A0 =A0 =A0 =A00 =A0 =A0 twl4030 =A0twl4030_keypad
> > 378: =A0 =A0 =A0 =A0 =A00 =A0 =A0 twl4030 =A0twl4030_usb
> > 384: =A0 =A0 =A0 =A0 =A00 =A0 =A0 twl4030 =A0mmc0
> > Err: =A0 =A0 =A0 =A0 =A00
> >=20
> > Regards
> > Mani
> >=20
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of David Brownell
> > > Sent: Thursday, February 05, 2009 4:53 AM
> > > To: OMAP
> > > Subject: [patch/rft 2.6.29-rc3-omap-git] omap3 evm: MMC switch su=
pport
> > >=20
> > > Update OMAP3 EVM board support to support the MMC/SD switches,
> > > when used with the twl4030 based power card.
> > >=20
> > > Also, less usefully, LEDB as a GPIO LED ... it's on the underside
> > > of the board, so it's probably not very useful to most folk. =A0T=
he
> > > LCD backlight is controlled by LEDA though; more useful, though
> > > its PWM mode might not be practical on this board (I don't know
> > > how that inductor will affect things).
> > >=20
> > > This is done from schematics, so it needs testing (and maybe some
> > > bugfixes) from folk with an EVM board.
> > >
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
