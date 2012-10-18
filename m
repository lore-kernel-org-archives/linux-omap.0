From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP2+: Move iommu/iovmm headers to
 platform_data
Date: Thu, 18 Oct 2012 13:30:29 -0700
Message-ID: <20121018203028.GE30550@atomide.com>
References: <20121016003513.19701.71718.stgit@muffinssi.local>
 <20121016003640.19701.51749.stgit@muffinssi.local>
 <1418726.Yza1yb71Ul@avalon>
 <20121018162512.GD30550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:15396 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754659Ab2JRUag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 16:30:36 -0400
Content-Disposition: inline
In-Reply-To: <20121018162512.GD30550@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, linux-omap@vger.kernel.org, Ido Yariv <ido@wizery.com>, Mauro Carvalho Chehab <mchehab@redhat.com>

* Tony Lindgren <tony@atomide.com> [121018 09:27]:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121018 06:45]:
> > Hi,
> > 
> > On Monday 15 October 2012 17:36:40 Tony Lindgren wrote:
> > > From: Ido Yariv <ido@wizery.com>
> > > 
> > > Move iommu/iovmm headers from plat/ to platform_data/ as part of the
> > > single zImage work.
> > 
> > Is that really where those headers belong ? iommu-omap.h contains far more 
> > than platform data, and iovmm-omap.h contains no platform data at all.
> 
> Hmm I though that was already fixed by Ido but looks like there are
> non-platform data things still remaining there.
> 
> Looking at arch/arm/mach-omap2/iommu2.c it seems that it should moved to
> drivers/iommu/omap-iommu2.c and that way most of the header can be local
> in drivers/iommu/omap-iommu.h. I'll do some patches for that and repost.

I ended up solving the iovmm-omap.h issue by adding include/linux/omap-iommu.h
like intel and amd have.

Reposted the series as "[PATCH v3 0/6] omap iommu changes to remove plat includes".

Regards,

Tony
