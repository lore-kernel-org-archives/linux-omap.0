From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v3 0/4] OMAP: McBSP: Use register cache
Date: Thu, 3 Dec 2009 13:31:20 +0100
Message-ID: <200912031331.21446.jkrzyszt@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <20091203094905.4c4fec7b.jhnikula@gmail.com> <200912031135.37985.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41236 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084AbZLCMbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 07:31:17 -0500
In-Reply-To: <200912031135.37985.peter.ujfalusi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thursday 03 December 2009 10:35:37 Peter Ujfalusi napisa=C5=82(a):
> Hello,
>
> On Thursday 03 December 2009 09:49:05 ext Jarkko Nikula wrote:
> > On Tue, 1 Dec 2009 04:10:07 +0100
> >
> > Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > > Change the way McBSP registers are maintained: store values writt=
en to
> > > the device in a cache in order to  make use of those cached value=
s when
> > > convenient.
> > >
> > > This could help for developing the McBSP context save/restore fea=
tures,
> > > as well as solve the problem of possible register corruption
> > > experienced on OMAP1510 based Amstrad Delta board, at least.
> > >
> > > Janusz Krzysztofik (4):
> > > 	OMAP: McBSP: Use macros for all register read/write operations
> > > 	OMAP: McBSP: Prepare register read/write macros API for caching
> > > 	OMAP: McBSP: Introduce caching in register write operations
> > > 	OMAP: McBSP: Use cache when modifying individual register bits
> > >
> > >  arch/arm/plat-omap/include/plat/mcbsp.h |    5
> > >  arch/arm/plat-omap/mcbsp.c              |  397
> > > ++++++++++++++++++++++++--------------------------- 2 files chang=
ed,
> > > 198 insertions(+), 204 deletions(-)
> >
> > Looks good to me and audio works fine with the Beagle. One minor
> > comment to the patch 3.
>
> Sorry, but I have totally missed the discussion about this in l-o..
> It looks good for me as well, the only comment I have is the same as =
Jarkko
> for patch 3.
> I was about to give it a try, but since Jarkko already tested it on B=
eagle,
> I'm OK with this series (with the comment for patch 3).

Hi Peter,

That's probably my fault, I've dropped you from CC: at some point, sorr=
y.

I'm still learning whom I should CC: and whom I shouldn't in order to r=
ise my=20
chances on patches being commented, acknowledged and applied in a reaso=
nable=20
time ;). Initial version of this one was waiting since August, that's w=
hy I=20
tried to narrow the audience in hope it could help getting it rejected =
or=20
accepted finally.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
