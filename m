From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Wed, 16 Mar 2016 14:33:19 +0100
Message-ID: <20160316133319.GR8413@pali>
References: <201507251228.27128@pali>
 <201601050034.12810@pali>
 <20160306152339.GA428@earth>
 <201603121342.33099@pali>
 <56E68B71.2030202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E68B71.2030202@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi! We found out that tpa6130a2 device is being initialized before i2c_=
2
bus is initialized. So that is reason why tpa6130a2 fails...

Any idea why kernel first try to initialize one i2c device even before
bus itself is initialized?

On Monday 14 March 2016 11:59:13 Peter Ujfalusi wrote:
> Does the i2c communication breaks with DT _and_ non DT boot?

Yes, for both DT and non DT boot. And this problem is there for a long
time...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
