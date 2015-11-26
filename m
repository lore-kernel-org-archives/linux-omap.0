From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Thu, 26 Nov 2015 10:07:39 +0100
Message-ID: <20151126090739.GD14190@pali>
References: <20150713131902.GH26485@atomide.com>
 <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com>
 <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com>
 <56568849.5080103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56568849.5080103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 November 2015 20:19:21 Frank Rowand wrote:
> > Or populate /proc/atags only for the ones that need it from machine
> > specific init_early?
>=20
> This is circling back to the first comment from Russell King where
> he suggested a legacy file for the N900 which calls save_atags():
>=20
>     Are the ATAGs at a fixed address on the N900?  Can that be handle=
d in
>     some kind of legacy file for the N900 which calls save_atags() on=
 it, so
>     we don't end up introducing yet more stuff that we have to mainta=
in into
>     the distant future?  If not, what about copying a known working a=
tag
>     structure into a legacy file for the N900?
>=20
> It seems to me that patches 1, 2, 4, and 5 could be replaced by this
> approach.

Hi Frank, in this case I will ask my question again: It is possible to
read atags from that legacy file. And if yes how? I was not thinking
about this approach because somebody in past wrote that this is not
possible...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
