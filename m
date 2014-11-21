From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH] i2c: omap: fix i207 errata handling
Date: Sat, 22 Nov 2014 02:02:03 +0300
Message-ID: <B174E67D-9CCF-48B6-A5E5-911668161823@gmail.com>
References: <1416529011-21803-1-git-send-email-al.kochet@gmail.com> <20141121160828.GP7508@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141121160828.GP7508@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org


21 =CE=CF=D1=C2. 2014 =C7., =D7 19:08, Felipe Balbi <balbi@ti.com> =CE=C1=
=D0=C9=D3=C1=CC(=C1):

> Tested on BBB and AM437x Starter Kit
>=20
> Tested-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>

21 =CE=CF=D1=C2. 2014 =C7., =D7 0:10, Aaro Koskinen <aaro.koskinen@iki.=
fi> =CE=C1=D0=C9=D3=C1=CC(=C1):

> I could not see any breakage or anything wrong on OMAP2 & OMAP3.
> On OMAP1 I don't have anything on the OMAP I2C bus, so cannot really
> test anything there.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>


21 =CE=CF=D1=C2. 2014 =C7., =D7 21:11, Wolfram Sang <wsa@the-dreams.de>=
 =CE=C1=D0=C9=D3=C1=CC(=C1):

> The errno for AL is -EAGAIN. Curly braces are not needed.


Guys, I really appreciate you help.
So much testing and review.
I could not have done one.
Thank you!

Alexander.
