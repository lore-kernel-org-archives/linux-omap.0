From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 06:33:14 -0700
Message-ID: <20160317133313.GL9329@atomide.com>
References: <56E68B71.2030202@ti.com>
 <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth>
 <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
 <20160317004917.GA6750@earth>
 <56EA6326.4000702@gmail.com>
 <20160317130115.GU8413@pali>
 <56EAACF4.2040005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EAACF4.2040005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160317 06:11]:
> Hi,
>=20
> On 17.03.2016 15:01, Pali Roh=C3=A1r wrote:
> >On Thursday 17 March 2016 09:56:22 Ivaylo Dimitrov wrote:
> >>Hi,
> >>
> >
> >Is camera on same bus as tpa? Maybe this is reason why camera is
> >non-functional too?
> >
>=20
> It doesn't matter, all the i2c busses are missing the pullups.
>=20
> >>Will fix the board DTS file later on an will report
> >
> >Thanks for investigation! Is that problem in both DTS and also legac=
y
> >board code?
> >
>=20
> I guess legacy board code does not set i2c pull-ups either, as we
> have that problem since the beginning of time. Anyway, let me first
> check if enabling pullups really solves the issue, I hope to test tha=
t in a
> couple of hours when I am back home.
>=20
> Or you can do it yourself, it is just a matter of replacing PIN_INPUT=
 with
> PIN_INPUT_PULLUP in https://git.kernel.org/cgit/linux/kernel/git/torv=
alds/linux.git/tree/arch/arm/boot/dts/omap3-n900.dts?id=3Drefs/tags/v4.=
5#n199
> for all the 3 ic2 busses

Check the schematics. If the hardware has external pull-ups on a
line then don't enable the internal pull-ups. Otherwise both the
external and intenal pulls are parallel the pull value will be
wrong. My guess is that on n900 all the i2c lines have external
pulls.

Regards,

Tony
