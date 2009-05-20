From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] OMAP4: Create board support for OMAP_4430SDP, v3
Date: Wed, 20 May 2009 08:19:55 -0700
Message-ID: <20090520151955.GD8308@atomide.com>
References: <1242739888-12428-1-git-send-email-santosh.shilimkar@ti.com> <20090519211756.GH19742@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B49CBF0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61002 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbZETPUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 11:20:03 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CBF0D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090519 21:57]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Wednesday, May 20, 2009 2:48 AM
> > To: Shilimkar, Santosh
> > Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> > linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 2/7] OMAP4: Create board support for 
> > OMAP_4430SDP, v3
> > 
> > Hi,
> > 
> > I rebased these patches on top of the for-next branch in linux-omap
> > tree, some comments and the updated patch below.
> > 
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [090519 06:32]:
> > > (patch is rebased on 2.6.30-rc6. The older version was 
> > based on 2.6.30-rc2)
> > > 
> > > This patch creates the bare minimal board files  to support
> > > OMAP_4430SDP. Additinaly new omap44xx.h is created which contains
> > > the base addresses for OMAP4430. File omap34xx.h is adapted to avoid
> > > multiple definitions of common omap base address definitions.
> > > 
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/board-4430sdp.c        |   94 
> > ++++++++++++++++++++++++++++
> > >  arch/arm/plat-omap/include/mach/hardware.h |    1 +
> > >  arch/arm/plat-omap/include/mach/omap34xx.h |   10 ++--
> > >  arch/arm/plat-omap/include/mach/omap44xx.h |   61 
> > ++++++++++++++++++
> > >  4 files changed, 161 insertions(+), 5 deletions(-)
> > >  create mode 100644 arch/arm/mach-omap2/board-4430sdp.c
> > >  create mode 100644 arch/arm/plat-omap/include/mach/omap44xx.h
> > 
> > In general, considering this whole series is less than 750 
> > lines of changes,
> > I suggest collapsing them into following three patches:
> > 
> > 1. Add minimal support for omap4
> > 
> > This patch would be everything in your series, except what's 
> > in patches
> > two and three below.
> > 
> > 2. Add support for 4430 SDP
> > 
> > This patch would be just the board-4430sdp.c the changes to 
> > mach-omap2/Makefile
> > and mach-omap2/Kconfig.
> > 
> > 3. Add defconfig for 4430 SDP
> > 
> > This patch would just contain the defconfig.
> > 
> > To make things easy, I rebased two of your patches on top of 
> > the for-next
> > branch in the linux-omap tree. Some comments and the updated 
> > patch below.
> > 
> > Please do any more changes on top of this version so we can get things
> > queued up nicely for Russell.
> 
> Cool :)
> I am fine with merging the patches but the clock stub patch should be kept separate. This patch should be reverted once clkdev is ready and in that case it would be easy to remove it.
> Series would be like this
>  1. Add minimal support for omap4
>  2. Add support for 4430 SDP
>  3. Clock stubs 
>  4. Add defconfig for 4430 SDP
> 
> I will rebase on 'for-next branch' on linux-omap and test it.

OK, sounds good to me!

Tony
