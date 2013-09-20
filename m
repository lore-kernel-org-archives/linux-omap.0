From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Fri, 20 Sep 2013 09:33:18 -0700
Message-ID: <20130920163318.GT9994@atomide.com>
References: <201302171616.50152@pali>
 <201309181800.10486@pali>
 <20130918174211.GU9994@atomide.com>
 <201309200030.36606@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309200030.36606@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130919 15:38]:
> On Wednesday 18 September 2013 19:42:12 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 09:08]:
> > > On Wednesday 18 September 2013 15:16:44 Pavel Machek wrote:
> > > > On Sun 2013-09-08 02:02:52, Aaro Koskinen wrote:
> > > > > Hi,
> > > > >=20
> > > > > On Fri, Sep 06, 2013 at 10:34:05PM +0200, Pali Roh=C3=A1r=20
> wrote:
> > > > > > > --- /dev/null
> > > > > > > +++ b/arch/arm/mach-omap2/board-rx51-camera.c
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > Ping, can you review this patch v2?
> > > > >=20
> > > > > I don't think Tony will accept any new board stuff for
> > > > > RX-51/N900. See for example:
> > > > > http://marc.info/?l=3Dlinux-kernel&m=3D137629626213187&w=3D2
> > > > >=20
> > > > > There should be initial Nokia N900 DTS file in 3.12-rc1,
> > > > > and we should continue converting this board fully to
> > > > > DT.
> > > >=20
> > > > That's not reasonable. N900 is pretty far away from
> > > > working with device tree. Yes, I was able to get some
> > > > bits merged, but that should not be excuse to halt other
> > > > N900 development.
> > > >=20
> > > > 									Pavel
> > >=20
> > > Right. So Tony, will you accept future patches for board
> > > files?
> >=20
> > Only fixes to board-*.c files please unless there's a _really_
> > good reason to make things more complex with the platform
> > data. Let's not make the DT conversion any more complex than
> > it already is.
> >=20
> > Getting things working with DT for the devices is pretty
> > trivial in most cases. And we can also still initialize the
> > legacy devices using platform data the same way as earlier.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> So, what to this with this patch v2 (it was sent 06.03.2013)?
> It adding board support for ADP1653 flash torch which is part of=20
> rx51 camera code. Driver itself is already in kernel tree.
> Can you comment/review this patch?

Yeah I'm not taking any more of new platform data like this,
this all is already very trivial to do with device tree
directly in the driver. Adding this would make the pains of
moving to device tree based booting just more of a pain and
guess who has to deal with all of that.

=46or the hwrng platform data makes still sense even for the
device tree as we don't have any better way currently to do
the SMC callbacks.

Regards,

Tony
