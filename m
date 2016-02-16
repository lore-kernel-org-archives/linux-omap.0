From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] omap3: Add cpuidle parameters table for omap3430
Date: Tue, 16 Feb 2016 11:07:52 +0100
Message-ID: <20160216100752.GF1476@pali>
References: <20160215152542.GS19432@atomide.com>
 <1455559328-19783-1-git-send-email-pali.rohar@gmail.com>
 <56C2F387.3040803@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C2F387.3040803@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 16 February 2016 11:01:43 Daniel Lezcano wrote:
> On 02/15/2016 07:02 PM, Pali Roh=C3=A1r wrote:
> >Based on CPU type choose generic omap3 or omap3430 specific cpuidle
> >parameters. Parameters for omap3430 were measured on Nokia N900 devi=
ce and
> >added by commit 5a1b1d3a9efa ("OMAP3: RX-51: Pass cpu idle parameter=
s")
> >which were later removed by commit 231900afba52 ("ARM: OMAP3: cpuidl=
e -
> >remove rx51 cpuidle parameters table") due to huge code complexity.
> >
> >This patch brings cpuidle parameters for omap3430 devices again, but=
 uses
> >simple condition based on CPU type.
> >
> >Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >Fixes: 231900afba52d6faddfb480cde4132d4edc089bc
> >---
>=20
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Tony, Nishanth (or somebody else...) can you test this patch on more
omap3 devices to check if it does not break existing cpuidle code?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
