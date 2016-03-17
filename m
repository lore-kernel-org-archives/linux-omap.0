From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 14:01:15 +0100
Message-ID: <20160317130115.GU8413@pali>
References: <20160306152339.GA428@earth>
 <201603121342.33099@pali>
 <56E68B71.2030202@ti.com>
 <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth>
 <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
 <20160317004917.GA6750@earth>
 <56EA6326.4000702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EA6326.4000702@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On Thursday 17 March 2016 09:56:22 Ivaylo Dimitrov wrote:
> Hi,
>=20
> On 17.03.2016 02:49, Sebastian Reichel wrote:
> >
> >mh both, the power gpio is turned off in tpa6130a2_power(0). I guess
> >if you don't see the problem during probe() everything works?
> >
> >I have another idea though: In opposit to the gpio, the regulator
> >may also be referenced by something else/already enabled. I guess
> >adding a sleep after the regulator_enable() is worth a try.
> >
> >Also I wonder if the same happens, if you avoid having the module
> >available during boot and instead load it once everything has
> >settled. That would rule out any side-effects of other modules
> >being probed on the same i2c bus.
>=20
>=20
> Well, I think I've figured it out - input pullups are not enabled
> on i2c bus pins, in stock kernel we have:
>=20
> ./devmem2 0x480021BC
> Value at address 0x480021BC (0x4001f1bc): 0x1180118
>=20
> ./devmem2 0x480021C0
> Value at address 0x480021C0 (0x4001f1c0): 0x1180118
>=20
> in mainline
>=20
> ./devmem2 0x480021BC
> Value at address 0x480021BC (0xb6ff01bc): 0x1000100
>=20
> ./devmem2 0x480021C0
> Value at address 0x480021C0 (0xb6f6d1c0): 0x1000100
>=20
> I wonder how i2c devices work at all :)

Is camera on same bus as tpa? Maybe this is reason why camera is
non-functional too?

> Will fix the board DTS file later on an will report

Thanks for investigation! Is that problem in both DTS and also legacy
board code?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
