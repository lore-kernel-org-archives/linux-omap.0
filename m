From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: Make some definitions local
Date: Wed, 24 Oct 2012 16:33:18 -0700
Message-ID: <20121024233317.GE11928@atomide.com>
References: <20121018202707.11834.1438.stgit@muffinssi.local>
 <2153737.CkcY4HqKKl@avalon>
 <20121019161743.GD4730@atomide.com>
 <1682925.XTJ8FK6Z8P@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53912 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750894Ab2JXXdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 19:33:24 -0400
Content-Disposition: inline
In-Reply-To: <1682925.XTJ8FK6Z8P@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Ido Yariv <ido@wizery.com>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121024 16:26]:
> Ho Tony,
> 
> On Friday 19 October 2012 09:17:43 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121019 02:45]:
> > > On Thursday 18 October 2012 13:28:48 Tony Lindgren wrote:
> > > > @@ -117,13 +112,6 @@ static inline struct omap_iommu
> > > > *dev_to_omap_iommu(struct device *dev) }
> > > > 
> > > >  #endif
> > > > 
> > > > -/* IOMMU errors */
> > > > -#define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
> > > > -#define OMAP_IOMMU_ERR_TRANS_FAULT	(1 << 1)
> > > > -#define OMAP_IOMMU_ERR_EMU_MISS		(1 << 2)
> > > > -#define OMAP_IOMMU_ERR_TBLWALK_FAULT	(1 << 3)
> > > > -#define OMAP_IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
> > > > -
> > > 
> > > I'll use those in the tidspbridge driver, in patches that I plan to push
> > > soon.
> > > 
> > > I will apply this patch set on top of mine, see what breaks. Would you
> > > like me to propose a modified version of this set, or add additional
> > > patches in my set ?
> > 
> > Sure, let's try to expose only the minimal amount of omap iommu things with
> > this patch set so we don't break things. Then the iommu development can
> > continue on it's own independent of the core omap code except for the
> > platform data.
> 
> I'll rebase my DSP patches on top of this patch set then, it will be easier.

OK sounds good to me.

Once we have the minimal changes acked by you and Joerg, I'll push
it into an immutable branch that we all can merge in as needed.

BTW, after updating patch 3/6 I noticed patches 4 - 6 had trivial merge
conflicts with the includes, so let me know if you want met to repost the
whole set.
 
> > But again, if there are nasty layering violations using this code, I would
> > just remove those features. Those things tend to just get worse unless they
> > are fixed properly to start with.
> 
> The long-term goal is to move the tidspbridge driver to the IOMMU API, but 
> we'll need a step by step approach.

Yes agreed.

Regards,

Tony
