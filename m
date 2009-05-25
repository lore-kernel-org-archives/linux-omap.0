From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
Date: Mon, 25 May 2009 10:21:12 +0100
Message-ID: <20090525092112.GA28195@n2100.arm.linux.org.uk>
References: <20090520.124814.124079256.Hiroshi.DOYU@nokia.com> <20090522.102114.216733168.Hiroshi.DOYU@nokia.com> <20090524221959.GA6476@n2100.arm.linux.org.uk> <20090525.084442.193700667.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57067 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbZEYJVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 05:21:41 -0400
Content-Disposition: inline
In-Reply-To: <20090525.084442.193700667.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Mon, May 25, 2009 at 08:44:42AM +0300, Hiroshi DOYU wrote:
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
> Date: Mon, 25 May 2009 00:19:59 +0200
> 
> > On Fri, May 22, 2009 at 10:21:14AM +0300, Hiroshi DOYU wrote:
> > > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > > Subject: Re: [PATCH 1/7] omap iommu: tlb and pagetable primitives
> > > Date: Wed, 20 May 2009 12:48:14 +0300 (EEST)
> > > 
> > > > Hi,
> > > > 
> > > > If there's no problem with those patches, please pull them from the following.
> > > > 
> > > > The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1:
> > > >   Linus Torvalds (1):
> > > >         Linux 2.6.30-rc4
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   http://git.gitorious.org/lk/mainline.git iommu
> > > 
> > > Russell, are you okay with this going into the patch system?
> > > 
> > > Kconfig patch is updated with your proposal.
> > 
> > Thanks, can I pull from a git url of the above?
> 
> Yes, you can. Also it's mirrored on:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git iommu

Pulled.  Doesn't gitorious.org have its own git URLs?
