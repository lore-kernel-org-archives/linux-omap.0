From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Thu, 11 Feb 2016 15:50:43 +0100
Message-ID: <20160211145043.GZ30075@pali>
References: <20141019090107.GA19132@amd>
 <20150707074626.GB12087@pali>
 <20150707114658.GT10705@atomide.com>
 <201601192158.19810@pali>
 <20160211144347.GY30075@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211144347.GY30075@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 11 February 2016 15:43:47 Pali Roh=C3=A1r wrote:
> On Tuesday 19 January 2016 21:58:19 Pali Roh=C3=A1r wrote:
> > On Tuesday 07 July 2015 13:46:59 Tony Lindgren wrote:
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150707 00:48]:
> > > > On Monday 06 July 2015 06:53:18 Tony Lindgren wrote:
> > > > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150706 06:27]:
> > > > > > On Tuesday 28 October 2014 23:26:41 Tony Lindgren wrote:
> > > > > > > * Pavel Machek <pavel@ucw.cz> [141028 15:22]:
> > > > > > > > On Tue 2014-10-28 23:04:50, Pavel Machek wrote:
> > > > > > > > > Networking now works against 3.17-based kernel. Thank=
s!
> > > > > > > >=20
> > > > > > > > It works on 3.18-rc1 kernel, too. (I had to hand-modify
> > > > > > > > patch to apply to 3.17, no changes needed for 3.18-rc1.=
)
> > > > > > > >=20
> > > > > > > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > > > > > >=20
> > > > > > > Whatever we decice to do to fix this regression, it shoul=
d
> > > > > > > probably be backported to at least v3.16 stable for distr=
o
> > > > > > > use, maybe earlier too. I'd assume this is broken on
> > > > > > > multiple platforms currently.
> > > > > >=20
> > > > > > it looks like this patch was not included into any kernel
> > > > > > version... I'm still using it on top of 4.x kernels. Are yo=
u
> > > > > > going to send this patch into upstream? Or do you have anot=
her
> > > > > > fix for this problem?
> > > > >=20
> > > > > I think Felipe mentioned a better built-in gether fix that's =
been
> > > > > reviewed on linux-usb list.
> > > >=20
> > > > Do you have link to that email thread? Or was Felipe's fix alre=
ady
> > > > merged into mainline kernel?
> > >=20
> > > Sorry I don't have a link, maybe Felipe can point you to the righ=
t
> > > patch.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > Felipe, ping
> >=20
>=20
> PING?
>=20

Ok, Felipe address is dead:
550 Invalid recipient <balbi@ti.com> (#5.1.1)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
