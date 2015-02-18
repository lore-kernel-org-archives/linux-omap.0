From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 18 Feb 2015 14:42:06 -0800
Message-ID: <20150218224206.GC32521@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <201502181619.46278@pali>
 <20150218163352.GB32521@atomide.com>
 <201502182004.03195@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery7.ore.mailhop.org ([54.149.205.143]:52028 "EHLO
	pmta2.delivery7.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751676AbbBRXGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2015 18:06:40 -0500
Content-Disposition: inline
In-Reply-To: <201502182004.03195@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150218 11:07]:
> On Wednesday 18 February 2015 17:33:53 Tony Lindgren wrote:
> > > */ +//		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at=20
> offset
> > > 0x300 */ +		reg =3D <1 0x0 0xf>;		/* 16 byte IO range=20
> at
> > > offset 0x300 */
> > >=20
> > >  		bank-width =3D <2>;
> > >  		pinctrl-names =3D "default";
> > >  		pinctrl-0 =3D <&ethernet_pins>;
> >=20
> > Oh cool, the 0x300 offset is there mostly to suppress warnings
> > about non-standard location.
=2E..

> > OK that's good news. Care to do a patch to set the offset 0x0
> > with added comment that qemu needs it? I'll test to make sure
> > it works on the real hardware as well.
>=20
> Yes, I can send proper git format-patch, but first let me know if=20
> that change does not break your HW...

Yes using reg =3D <1 0 0xf> works, it just adds this extra warning:

smc91x 2000000.ethernet (unnamed net_device) (uninitialized):
smc91x: IOADDR d09d6000 doesn't match configuration (300).

And I'm pretty sure that can be fixed by setting the EEPROM
offset to 0 instead of the default 0x300. People with smc91x
most likely want to write at least the MAC address to the
EEPROM, so might as well set the offset to zero then too.

Of course it's always possible to do do a omap3-n900-qemu.dts
if larger changes are needed :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
