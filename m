From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: Adjust MPU OPP values
Date: Tue, 5 Jan 2016 09:53:58 +0100
Message-ID: <20160105085358.GH22661@pali>
References: <201601021531.10424@pali>
 <20160102171641.GD12622@atomide.com>
 <5688354C.4070505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5688354C.4070505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <menon.nishanth@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Saturday 02 January 2016 14:38:36 Nishanth Menon wrote:
> On 01/02/2016 11:16 AM, Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:31]:
> >> Hello,
> >>
> >> MPU OPP table table (omap36xx_vddcore_volt_data) defined in
> >> opp3xxx_data.c does not match Nokia N900 phone. For a long time we=
 have
> >> dirty patch in linux-n900 tree for it, see:
> >>
> >> https://github.com/pali/linux-n900/commit/4644c5801d7469e2be01d847=
c61df3d934dadd8c
> >>
> >> Now when doing transition to device tree, is there any way how cor=
rect
> >> MPU OOP table for Nokia N900 could be defined in DT file?
> >=20
> > Hmm I'd assume we can just define this in the dts.. Nishanth, got
> > any comments on this one?
> >=20
>=20
> We already have definitions in dtb for omap3 OPPs. I think we should
> start using device tree as default. the oppxx_data.c is sticking arou=
nd
> waiting for legacy boot to go away, then those files should be delete=
d.
>=20

=46reemangordon, maybe... would it be possible to add (now stable and
tested by lot of users) OPP table from Maemo kernel-power to DTS?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
