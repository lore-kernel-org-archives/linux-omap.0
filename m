From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 06:26:31 -0700
Message-ID: <20150713132630.GI26485@atomide.com>
References: <201507111405.06048@pali>
 <20150713064425.GB26485@atomide.com>
 <20150713111031.GC30452@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713111031.GC30452@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150713 04:13]:
>=20
> Ok, and any idea what is with rtc?

Probably one of these:

$ git log --pretty=3Doneline v4.1..v4.2-rc2 drivers/mfd/*twl* drivers/i=
2c/busses/i2c-omap.c
24867481b8c0a3bc3ab53b634e3cc03680ac3ac6 Merge branch 'i2c/for-4.2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
7d5b1ed89bbb3614830c96420050088f3e0fb886 mfd: twl4030-irq: Pass the IRQ=
=46_ONESHOT flag
5c188d748216f67c928d67a42f14b5569b6404a5 mfd: twl4030-power: Fix pmic f=
or boards that need AC charger disabled
7ce7b26f84cfcbcb04f526f56f685a56ccddf355 mfd: Constify regmap and irq c=
onfiguration data
9dcb0e7b999db6c420c70fd32497a979a044fcdf i2c: omap: implement bus recov=
ery
096ea30c91b521c77964ee8c214f7ce3b9d08e7b i2c: omap: Add calls for pinct=
rl state select

Regards,

Ton
