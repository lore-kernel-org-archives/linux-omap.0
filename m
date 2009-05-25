From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
Date: Mon, 25 May 2009 13:47:31 +0300 (EEST)
Message-ID: <20090525.134731.193686667.Hiroshi.DOYU@nokia.com>
References: <20090525092112.GA28195@n2100.arm.linux.org.uk>
	<20090525.123027.112616146.Hiroshi.DOYU@nokia.com>
	<94a0d4530905250236h1c901968o694782d2eea134dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30526 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbZEYKsI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 06:48:08 -0400
In-Reply-To: <94a0d4530905250236h1c901968o694782d2eea134dc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
Date: Mon, 25 May 2009 11:36:03 +0200

> On Mon, May 25, 2009 at 12:30 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
> > Date: Mon, 25 May 2009 11:21:12 +0200
> >
> >> On Mon, May 25, 2009 at 08:44:42AM +0300, Hiroshi DOYU wrote:
> >> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> >> > Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitive=
s
> >> > Date: Mon, 25 May 2009 00:19:59 +0200
> >> >
> >> > > On Fri, May 22, 2009 at 10:21:14AM +0300, Hiroshi DOYU wrote:
> >> > > > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >> > > > Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primi=
tives
> >> > > > Date: Wed, 20 May 2009 12:48:14 +0300 (EEST)
> >> > > >
> >> > > > > Hi,
> >> > > > >
> >> > > > > If there's no problem with those patches, please pull them=
 from the following.
> >> > > > >
> >> > > > > The following changes since commit 091438dd5668396328a3419=
abcbc6591159eb8d1:
> >> > > > > =A0 Linus Torvalds (1):
> >> > > > > =A0 =A0 =A0 =A0 Linux 2.6.30-rc4
> >> > > > >
> >> > > > > are available in the git repository at:
> >> > > > >
> >> > > > > =A0 http://git.gitorious.org/lk/mainline.git iommu
> >> > > >
> >> > > > Russell, are you okay with this going into the patch system?
> >> > > >
> >> > > > Kconfig patch is updated with your proposal.
> >> > >
> >> > > Thanks, can I pull from a git url of the above?
> >> >
> >> > Yes, you can. Also it's mirrored on:
> >> >
> >> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-=
2.6.git iommu
> >>
> >> Pulled. =A0Doesn't gitorious.org have its own git URLs?
> >
> > Right, the gitorious has the git version url,
> >
> > =A0 =A0 =A0 git://gitorious.org/lk/mainline.git iommu
>=20
> How about having a project (in gitorious) for all our repos? I cloned
> the 'linux-omap/mainline' repo to my personal repo, maybe you can do
> the same? Or maybe we should create a new 'linux' project.

Not bad idea generally, but just for kernel patches, I'd rather work
more closely/directly with the mainline than keeping changes some git
repositories locally for some time.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
