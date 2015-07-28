From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 28 Jul 2015 14:32:03 +0200
Message-ID: <20150728123203.GO13765@pali>
References: <201507111405.06048@pali>
 <20150722001741.GA7950@deathstar>
 <20150722020306.GA8379@earth>
 <201507251055.51375@pali>
 <20150728083932.GD13765@pali>
 <20150728122612.GA31794@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728122612.GA31794@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Michael Welling <mwelling@ieee.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 28 July 2015 14:26:13 Sebastian Reichel wrote:
> Hi Pali,
>=20
> On Tue, Jul 28, 2015 at 10:39:32AM +0200, Pali Roh=C3=A1r wrote:
> > Sebastian or Michael: Can you add check for pm_runtime_get_sync()
> > function and send patch for including in mainline kernel?
>=20
> This actually already happened before your Tested-By.
> I accidently did not CC you, sorry for that:
>=20
> https://lkml.org/lkml/2015/7/22/581
> https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?=
h=3Dfor-linus&id=3D5f74db105b1c0980c9863e7a7d1bc0525e0316e8
>=20
> -- Sebastian

Ok, so it will be fixed in 4.2. Thanks!

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
