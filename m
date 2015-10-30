From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
Date: Fri, 30 Oct 2015 16:11:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510301603530.7580@utopia.booyaka.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1323759807-1446221477=:7580"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1323759807-1446221477=:7580
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter

On Fri, 30 Oct 2015, Peter Ujfalusi wrote:

> Changes since v2:
> - DTS patch added which is needed because of the clock handling changes
>=20
> Felip Balbi reported that linux-next is broken right now since the DTS pa=
rt of
> the earlier series has been applied, but we do not have the mcasp hwmod i=
n the
> kernel:
> ...
> [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
> ...
> [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume: FIX=
ME: missing hwmod/omap_dev info
> [    6.130790] ------------[ cut here ]------------
> [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c:147 =
l3_interrupt_handler+0x220/0x34c()
> [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3=
 (Read): Data Access in User mode during Functional access
> ...
>=20
> This is the followup series for the hwmod changes needed to get audio wor=
king
> on DRA7xx family based boards.
> The DTS patches has been applied by Tony from the original series:
> http://www.spinics.net/lists/linux-omap/msg121473.html
>=20
> I have addressed your comments in the hwmod data and did some research al=
so
> regarding to the use of ahclkx as fclk in the original submission.
> It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
> ahclkx/r) to be able to access registers. The original patch where we han=
dled
> the ahclkx as fclk worked, because the fclk clock got enabled in the HW w=
/o
> any SW interaction.
> All in all, the McASP found in DRA7 needs all clocks to be enabled.
> To satisfy this I have introduced a new flag to hwmod, which means that t=
he
> listed optional clocks need to be handled alongside with the fclk clock.

Thanks.  I'm happy with your series and appreciate the indepth=20
investigation.  As you probably saw last week, we've hit the limit for=20
v4.4-rc1:

http://marc.info/?l=3Dlinux-omap&m=3D144564929721826&w=3D2

This is why I haven't done anything with this series at this time. =20
Unfortunately I don't have a DRA7xx board, so I can't do any testing. =20
But if this series fixes a problem with DRA7xx in linux-next, we should=20
definitely merge it.

Tony, if you want to take this now, you can either take it with my ack, or=
=20
I can send a pull request.  Or, if you'd prefer to take it for v4.4-rc2,=20
I can send a pull request after v4.4-rc1.


- Paul
--843723315-1323759807-1446221477=:7580--
