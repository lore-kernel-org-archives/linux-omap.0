From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] SDMA: Fixing bug in omap_dma_set_global_params()
Date: Wed, 7 Oct 2009 15:03:54 -0700
Message-ID: <20091007220354.GC29320@atomide.com>
References: <1254732163-3509-1-git-send-email-anuj.aggarwal@ti.com> <20091005094102.1385b418.rdunlap@xenotime.net> <618f0c910910070218q496eeb9dgf200ffd5d6583aef@mail.gmail.com> <20091007083836.89b48fbd.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63635 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbZJGWEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 18:04:41 -0400
Content-Disposition: inline
In-Reply-To: <20091007083836.89b48fbd.rdunlap@xenotime.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Venkatraman S <svenkatr@ti.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@xenotime.net> [091007 08:38]:
> On Wed, 7 Oct 2009 14:48:26 +0530 Venkatraman S wrote:
>=20
> > On Mon, Oct 5, 2009 at 10:11 PM, Randy Dunlap <rdunlap@xenotime.net=
> wrote:
> > > On Mon, =A05 Oct 2009 14:12:43 +0530 Anuj Aggarwal wrote:
> > >
> > >> Argument tparams was not being used to program
> > >> global register GCR.HI_THREAD_RESERVED. This patch fixes the sam=
e.
> > >>
> > >> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > >> ---
> > >> =A0arch/arm/plat-omap/dma.c | =A0 15 +++++++++------
> > >> =A01 files changed, 9 insertions(+), 6 deletions(-)
> > >
> > >
> > > Hi,
> > > Someone please convert all of this source file to correct kernel-=
doc notation.
> > >
> > > Thanks.
> > >
> >=20
> > I now have this on my TODO list. As a bug fix, shouldn't this be
> > pulled in and the doc updates for all the functions can be done as =
a
> > separate patch ?
>=20
> Yes.  Thanks.

Will add this fix to my omap-fixes queue.

Tony

>=20
> > Anuj,
> >  Can you please correct the comments for this function to proper
> > format along with your changes ?
> >=20
> > Thanks,
> > Venkat.
>=20
>=20
> ---
> ~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
