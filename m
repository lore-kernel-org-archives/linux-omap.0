From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Tue, 17 Sep 2013 16:50:28 -0700
Message-ID: <20130917235028.GR9994@atomide.com>
References: <201302171616.50152@pali>
 <20130217190303.GC2317@blackmetal.musicnaut.iki.fi>
 <201303062112.06417@pali>
 <201309062234.05878@pali>
 <20130907230252.GA10700@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130907230252.GA10700@blackmetal.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130907 16:10]:
> Hi,
>=20
> On Fri, Sep 06, 2013 at 10:34:05PM +0200, Pali Roh=C3=A1r wrote:
> > > --- /dev/null
> > > +++ b/arch/arm/mach-omap2/board-rx51-camera.c
> [...]
> > Ping, can you review this patch v2?
>=20
> I don't think Tony will accept any new board stuff for RX-51/N900.
> See for example: http://marc.info/?l=3Dlinux-kernel&m=3D1376296262131=
87&w=3D2
>=20
> There should be initial Nokia N900 DTS file in 3.12-rc1, and we shoul=
d
> continue converting this board fully to DT.

Yes let's plan on making mach-omap2 to be DT only soonish.
AFAIK the only stopper right now for omap3 are the pending
pinctrl changes for the wake-up events as otherwise we would
have sever PM regressions with off-idle.

Regards,

Tony
