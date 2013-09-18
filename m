From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Wed, 18 Sep 2013 15:16:44 +0200
Message-ID: <20130918131644.GA2953@amd.pavel.ucw.cz>
References: <201302171616.50152@pali>
 <20130217190303.GC2317@blackmetal.musicnaut.iki.fi>
 <201303062112.06417@pali>
 <201309062234.05878@pali>
 <20130907230252.GA10700@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130907230252.GA10700@blackmetal.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2013-09-08 02:02:52, Aaro Koskinen wrote:
> Hi,
>=20
> On Fri, Sep 06, 2013 at 10:34:05PM +0200, Pali Roh=E1r wrote:
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

That's not reasonable. N900 is pretty far away from working with
device tree. Yes, I was able to get some bits merged, but that should
not be excuse to halt other N900 development.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
