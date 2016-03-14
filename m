From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 14 Mar 2016 11:59:13 +0200
Message-ID: <56E68B71.2030202@ti.com>
References: <201507251228.27128@pali> <201601050034.12810@pali>
 <20160306152339.GA428@earth> <201603121342.33099@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201603121342.33099@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On 2016-03-12 14:42, Pali Roh=C3=A1r wrote:
> Hi Sebastian! Commenting calling lp55xx_reset_device function did not=
=20
> helped. Still getting that error.
>=20
> Tony, Peter, Jarkko: can you reproduce this problem? I'm really stuck=
ed=20
> here... do not know where is problem or how to fix it. What we know t=
hat
>  it happens when rebooting from stock Nokia kernel (2.6.28) to upstre=
am.

I'm sorry, but I can not debug my n900 as I rely on it as primary phone
time-to-time.

I would try to disable one by one the drivers for devices on the i2c_2 =
bus
in the stock kernel and see if this will point to something.
It might worth looking at the driver init codes for the devices we have=
 on
i2c_2 also. Since rebooting to stock kernel does not have issue, it mig=
ht be
the chip init for at least one of the device might cause the i2c bus lo=
ck.
It is also possible that the driver load order is different and we migh=
t
need to load one of the drivers before the others?
In the board file (board-rx51-peripherals.c) the tpa is the last entry =
in
the i2c_board_info, so it is most likely the last one to load among the
drivers for i2c_2 devices. In the dts si4713 and bq24150a is after the
tpa... Try to move the tpa as last one in the dts?

Does the i2c communication breaks with DT _and_ non DT boot?

--=20
P=C3=A9ter
