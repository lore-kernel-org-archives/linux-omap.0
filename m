From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Wed, 11 Nov 2015 13:37:19 -0800
Message-ID: <20151111213718.GH3218@atomide.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [151030 09:11]:
> Hi P=C3=A9ter
>=20
> On Fri, 30 Oct 2015, Peter Ujfalusi wrote:
>=20
> > Changes since v2:
> > - DTS patch added which is needed because of the clock handling cha=
nges
> >=20
> > Felip Balbi reported that linux-next is broken right now since the =
DTS part of
> > the earlier series has been applied, but we do not have the mcasp h=
wmod in the
> > kernel:
> > ...
> > [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3=
'
> > ...
> > [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resum=
e: FIXME: missing hwmod/omap_dev info
> > [    6.130790] ------------[ cut here ]------------
> > [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.=
c:147 l3_interrupt_handler+0x220/0x34c()
> > [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_P=
ER2_P3 (Read): Data Access in User mode during Functional access
> > ...
> >=20
> > This is the followup series for the hwmod changes needed to get aud=
io working
> > on DRA7xx family based boards.
> > The DTS patches has been applied by Tony from the original series:
> > http://www.spinics.net/lists/linux-omap/msg121473.html
> >=20
> > I have addressed your comments in the hwmod data and did some resea=
rch also
> > regarding to the use of ahclkx as fclk in the original submission.
> > It turned out that McASP _needs_ all clocks to be enabled (fclk, ic=
lk and
> > ahclkx/r) to be able to access registers. The original patch where =
we handled
> > the ahclkx as fclk worked, because the fclk clock got enabled in th=
e HW w/o
> > any SW interaction.
> > All in all, the McASP found in DRA7 needs all clocks to be enabled.
> > To satisfy this I have introduced a new flag to hwmod, which means =
that the
> > listed optional clocks need to be handled alongside with the fclk c=
lock.
>=20
> Thanks.  I'm happy with your series and appreciate the indepth=20
> investigation.  As you probably saw last week, we've hit the limit fo=
r=20
> v4.4-rc1:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D144564929721826&w=3D2
>=20
> This is why I haven't done anything with this series at this time. =20
> Unfortunately I don't have a DRA7xx board, so I can't do any testing.=
 =20
> But if this series fixes a problem with DRA7xx in linux-next, we shou=
ld=20
> definitely merge it.
>=20
> Tony, if you want to take this now, you can either take it with my ac=
k, or=20
> I can send a pull request.  Or, if you'd prefer to take it for v4.4-r=
c2,=20
> I can send a pull request after v4.4-rc1.

OK I'll add your ack to the hwmod patches and apply all theree patches =
into
omap-for-v4.4/fixes as it fixes the splat on beagle x15 Felipe reported=
=2E

Regards,

Tony
