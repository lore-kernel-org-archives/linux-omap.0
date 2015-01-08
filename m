From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Thu, 8 Jan 2015 10:54:48 -0800
Message-ID: <20150108185448.GV13010@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <54AD5447.2070601@ti.com>
 <20150107164005.GD4081@atomide.com>
 <201501081001.34938@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59995 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754785AbbAHS6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 13:58:36 -0500
Content-Disposition: inline
In-Reply-To: <201501081001.34938@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150108 01:04]:
> On Wednesday 07 January 2015 17:40:06 Tony Lindgren wrote:
> > [   1.943] getting value of option 'R&D flags set'
> > [   1.948] SETUP: WR VND DEVICE    req 42 value 0000 index
> > 0000 length 001b
> > [   1.956] Image 'kernel' won't fit to the
> > partition, still loading it (4814592 bytes, while maximum is
> > 2097152 bytes)
> > [   1.967] Receiving kernel (length 4814592)
> > [   2.298] Image successfully received
> > [   2.302] SETUP: WR VND DEVICE    req 82 value 0000 index
> > 0000 length 0000
> > [   2.309] SETUP: WR STD INTERFACE
> > SET_INTERFACE      value 0000 index 0002 length 0000
> > [   2.363] Boot requested (normal mode)
> > [   2.367] Serial console enabled
>=20
> Tony, how did you get above verbose log from NOLO bootloader? Is=20
> there any switch of R&D flag for it?

Probably it was built with some debug flags enabled, at least
I don't think those can be enabled otherwise.
=20
> NOLO in qemu (on serial console) show few messages...
>=20
> [   0.179] Loading kernel image info
> Loading kernel (202 kB)... done in 27 ms (7457 kB/s)
> [   0.202] Loading initfs image info
> [   0.203] Total bootup time 286 ms
> [   0.206] Serial console enabled

Looks like I have:

$ flasher --query-rd-mode
flasher v2.5.2 (Oct 21 2009)

Suitable USB device not found, waiting.
USB device found found at bus 003, device address 060.
=46ound device RX-51, hardware revision 0010
NOLO version 1.4.14
Version of 'sw-release': <no version>
The device is in R&D mode
R&D flags (0x0196): no-omap-wd, no-ext-wd, serial-console, no-charging,=
 force-power-key

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
