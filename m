From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: Adjust MPU OPP values
Date: Sat, 2 Jan 2016 09:16:41 -0800
Message-ID: <20160102171641.GD12622@atomide.com>
References: <201601021531.10424@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601021531.10424@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:31]:
> Hello,
>=20
> MPU OPP table table (omap36xx_vddcore_volt_data) defined in
> opp3xxx_data.c does not match Nokia N900 phone. For a long time we ha=
ve
> dirty patch in linux-n900 tree for it, see:
>=20
> https://github.com/pali/linux-n900/commit/4644c5801d7469e2be01d847c61=
df3d934dadd8c
>=20
> Now when doing transition to device tree, is there any way how correc=
t
> MPU OOP table for Nokia N900 could be defined in DT file?

Hmm I'd assume we can just define this in the dts.. Nishanth, got
any comments on this one?

Regards,

Tony
