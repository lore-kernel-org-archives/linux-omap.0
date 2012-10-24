From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: Make some definitions local
Date: Thu, 25 Oct 2012 01:37:43 +0200
Message-ID: <1467852.FtkNIyyq5l@avalon>
References: <20121018202707.11834.1438.stgit@muffinssi.local> <1682925.XTJ8FK6Z8P@avalon> <20121024233317.GE11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35855 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab2JXXgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 19:36:54 -0400
In-Reply-To: <20121024233317.GE11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Ido Yariv <ido@wizery.com>

Hi Tony,

On Wednesday 24 October 2012 16:33:18 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121024 16:26]:
> > On Friday 19 October 2012 09:17:43 Tony Lindgren wrote:
> > > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121019 02:45]:
> > > > On Thursday 18 October 2012 13:28:48 Tony Lindgren wrote:
> > > > > @@ -117,13 +112,6 @@ static inline struct omap_iommu
> > > > > *dev_to_omap_iommu(struct device *dev) }
> > > > > 
> > > > >  #endif
> > > > > 
> > > > > -/* IOMMU errors */
> > > > > -#define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
> > > > > -#define OMAP_IOMMU_ERR_TRANS_FAULT	(1 << 1)
> > > > > -#define OMAP_IOMMU_ERR_EMU_MISS		(1 << 2)
> > > > > -#define OMAP_IOMMU_ERR_TBLWALK_FAULT	(1 << 3)
> > > > > -#define OMAP_IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
> > > > > -
> > > > 
> > > > I'll use those in the tidspbridge driver, in patches that I plan to
> > > > push soon.
> > > > 
> > > > I will apply this patch set on top of mine, see what breaks. Would you
> > > > like me to propose a modified version of this set, or add additional
> > > > patches in my set ?
> > > 
> > > Sure, let's try to expose only the minimal amount of omap iommu things
> > > with this patch set so we don't break things. Then the iommu development
> > > can continue on it's own independent of the core omap code except for
> > > the platform data.
> > 
> > I'll rebase my DSP patches on top of this patch set then, it will be
> > easier.
>
> OK sounds good to me.
> 
> Once we have the minimal changes acked by you and Joerg, I'll push
> it into an immutable branch that we all can merge in as needed.
> 
> BTW, after updating patch 3/6 I noticed patches 4 - 6 had trivial merge
> conflicts with the includes, so let me know if you want met to repost the
> whole set.

Please do. I'll then ack it (provided I have no more comments to make of 
course :-)).
 
> > > But again, if there are nasty layering violations using this code, I
> > > would just remove those features. Those things tend to just get worse
> > > unless they are fixed properly to start with.
> > 
> > The long-term goal is to move the tidspbridge driver to the IOMMU API, but
> > we'll need a step by step approach.
> 
> Yes agreed.

-- 
Regards,

Laurent Pinchart

