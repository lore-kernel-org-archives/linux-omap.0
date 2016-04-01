From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Race condition in TPA6130A2 (Was: Re: Nokia N900 - audio TPA6130A2
 problems)
Date: Fri, 1 Apr 2016 12:43:33 +0200
Message-ID: <20160401104333.GC8413@pali>
References: <201507251228.27128@pali>
 <201601050034.12810@pali>
 <20160306152339.GA428@earth>
 <201603121342.33099@pali>
 <56E68B71.2030202@ti.com>
 <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160316144709.GA3389@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 16 March 2016 15:47:10 Sebastian Reichel wrote:
> I just had another look at the driver and I think there is a race
> condition for tpa6130a2_add_controls() and tpa6130a2_stereo_enable().
>=20
> As far as I can see both functions check for "tpa6130a2_client !=3D
> NULL". tpa6130a2_client is set before the probe function has finished=
,
> though. Simplified probe:
>=20
> ...
> tpa6130a2_client =3D client;
> set_default_regs();
> acquire_power_gpio();
> acquire_regulator();
> tpa6130a2_power(1); // needs tpa6130a2_client
> check_device();
> tpa6130a2_power(0); // needs tpa6130a2_client
> ...
>=20
> If tpa6130a2_add_controls() or tpa6130a2_stereo_enable() is called
> after tpa6130a2 probe has started, but before probe has completed,
> tpa6130a2_client is set, but not yet initialized. The race condition
> can be fixed easily by moving the tpa6130a2_client assignment directl=
y
> after the regulator acquisition.
>=20
> -- Sebastian

Is this race condition really relevant? If yes, then it should be fixed=
=2E

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
