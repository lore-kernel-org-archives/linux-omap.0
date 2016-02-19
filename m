From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Add cpuidle parameters table for omap3430
Date: Fri, 19 Feb 2016 10:36:47 -0800
Message-ID: <20160219183647.GL21202@atomide.com>
References: <20160215152542.GS19432@atomide.com>
 <1455559328-19783-1-git-send-email-pali.rohar@gmail.com>
 <56C2F387.3040803@linaro.org>
 <20160216100752.GF1476@pali>
 <20160216160859.GE19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160216160859.GE19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160216 08:11]:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160216 02:09]:
> > On Tuesday 16 February 2016 11:01:43 Daniel Lezcano wrote:
> > > On 02/15/2016 07:02 PM, Pali Roh=C3=A1r wrote:
> > > >Based on CPU type choose generic omap3 or omap3430 specific cpui=
dle
> > > >parameters. Parameters for omap3430 were measured on Nokia N900 =
device and
> > > >added by commit 5a1b1d3a9efa ("OMAP3: RX-51: Pass cpu idle param=
eters")
> > > >which were later removed by commit 231900afba52 ("ARM: OMAP3: cp=
uidle -
> > > >remove rx51 cpuidle parameters table") due to huge code complexi=
ty.
> > > >
> > > >This patch brings cpuidle parameters for omap3430 devices again,=
 but uses
> > > >simple condition based on CPU type.
> > > >
> > > >Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > >Fixes: 231900afba52d6faddfb480cde4132d4edc089bc
> > > >---
> > >=20
> > > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >=20
> > Tony, Nishanth (or somebody else...) can you test this patch on mor=
e
> > omap3 devices to check if it does not break existing cpuidle code?
>=20
> Seems to work for me on a ldp, which is GP 3430 ES3.0.

OK applying this into omap-for-v4.6/fixes-not-urgent considering
we've already lived with it for years.

Regards,

Tony
