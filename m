From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 3/8] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return
 value
Date: Fri, 15 Feb 2013 14:01:52 -0300
Message-ID: <20130215170151.GC2442@localhost>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360682305-20935-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <CABYxbz6tZJjuz0NKorPSz_tWD42+HuHL3kwW0cegWW5QTDxH8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60598 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab3BORB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 12:01:58 -0500
Content-Disposition: inline
In-Reply-To: <CABYxbz6tZJjuz0NKorPSz_tWD42+HuHL3kwW0cegWW5QTDxH8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>

Hi Anil,

On Fri, Feb 15, 2013 at 09:49:21PM +0530, Anil Kumar wrote:
> Hi,
>=20
> On Tue, Feb 12, 2013 at 8:48 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > Currently gpmc_cs_reserved() return value is somewhat inconsistent,
> > returning a negative value on an error condition, a positive value
> > if the chip select is reserved and zero if it's available.
> >
> > Fix this by returning a boolean value as the function name suggests=
:
> >   * true if the chip select is reserved,
> >   * false if it's available
> >
> > Suggested-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> > Changelog from v1:
> >  * As suggested by Felipe Balbi, fix return code to a boolean
> >
> >  arch/arm/mach-omap2/gpmc.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.=
c
> > index bd3bc93..fa4764f 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -452,10 +452,10 @@ static int gpmc_cs_set_reserved(int cs, int r=
eserved)
> >         return 0;
> >  }
> >
> > -static int gpmc_cs_reserved(int cs)
> > +static bool gpmc_cs_reserved(int cs)
> >  {
> >         if (cs > GPMC_CS_NUM)
> > -               return -ENODEV;
> > +               return true;
> >
> >         return gpmc_cs_map & (1 << cs);
> >  }
>=20
> commit "6797b4fe0e554ce71f47038fd929c9ca929a9f3c"
> Marking all the chip-selects as reserved by default.
>=20
> In this case gpmc_cs_map is 0xff. So it will return 0x1 if cs is 0.
> So gpmc_cs_request() function will fail in nand (gpmc-nand.c) case.
>=20
> I am taking reference, branch "omap-for-v3.9/gpmc" of git tree
> http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>=20
> I am sorry if this question is very vague.
>=20

If I understand correctly your concern, I believe you've missed this
patch submitted by Jon Hunter and not yet merged:

  ARM: OMAP2+: Fix-up gpmc merge error

With this patch every chip-select is cleared on gpmc_probe()
as soon as GPMC driver initializes, and before we can request any
NAND/NOR child.

I hope this answers your question.

=46eel free to test the series and send your Tested-by!

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
