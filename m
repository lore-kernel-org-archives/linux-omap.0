From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
Date: Mon, 25 May 2009 08:44:42 +0300 (EEST)
Message-ID: <20090525.084442.193700667.Hiroshi.DOYU@nokia.com>
References: <20090520.124814.124079256.Hiroshi.DOYU@nokia.com>
	<20090522.102114.216733168.Hiroshi.DOYU@nokia.com>
	<20090524221959.GA6476@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33539 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbZEYFq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 01:46:26 -0400
In-Reply-To: <20090524221959.GA6476@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
Date: Mon, 25 May 2009 00:19:59 +0200

> On Fri, May 22, 2009 at 10:21:14AM +0300, Hiroshi DOYU wrote:
> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
> > Date: Wed, 20 May 2009 12:48:14 +0300 (EEST)
> > 
> > > Hi,
> > > 
> > > If there's no problem with those patches, please pull them from the following.
> > > 
> > > The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1:
> > >   Linus Torvalds (1):
> > >         Linux 2.6.30-rc4
> > > 
> > > are available in the git repository at:
> > > 
> > >   http://git.gitorious.org/lk/mainline.git iommu
> > 
> > Russell, are you okay with this going into the patch system?
> > 
> > Kconfig patch is updated with your proposal.
> 
> Thanks, can I pull from a git url of the above?

Yes, you can. Also it's mirrored on:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git iommu
