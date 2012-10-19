From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: Make some definitions local
Date: Fri, 19 Oct 2012 09:17:43 -0700
Message-ID: <20121019161743.GD4730@atomide.com>
References: <20121018202707.11834.1438.stgit@muffinssi.local>
 <20121018202848.11834.17893.stgit@muffinssi.local>
 <2153737.CkcY4HqKKl@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60096 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752282Ab2JSQRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 12:17:51 -0400
Content-Disposition: inline
In-Reply-To: <2153737.CkcY4HqKKl@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Ido Yariv <ido@wizery.com>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121019 02:45]:
> On Thursday 18 October 2012 13:28:48 Tony Lindgren wrote:
> > @@ -117,13 +112,6 @@ static inline struct omap_iommu
> > *dev_to_omap_iommu(struct device *dev) }
> >  #endif
> > 
> > -/* IOMMU errors */
> > -#define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
> > -#define OMAP_IOMMU_ERR_TRANS_FAULT	(1 << 1)
> > -#define OMAP_IOMMU_ERR_EMU_MISS		(1 << 2)
> > -#define OMAP_IOMMU_ERR_TBLWALK_FAULT	(1 << 3)
> > -#define OMAP_IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
> > -
> 
> I'll use those in the tidspbridge driver, in patches that I plan to push soon.
> 
> I will apply this patch set on top of mine, see what breaks. Would you like me 
> to propose a modified version of this set, or add additional patches in my set 
> ?

Sure, let's try to expose only the minimal amount of omap
iommu things with this patch set so we don't break things.
Then the iommu development can continue on it's own independent
of the core omap code except for the platform data.

But again, if there are nasty layering violations using this
code, I would just remove those features. Those things tend to
just get worse unless they are fixed properly to start with.

Regards,

Tony
