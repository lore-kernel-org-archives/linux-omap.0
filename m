From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Mon, 21 Jul 2014 23:19:29 -0700
Message-ID: <20140722061929.GD18374@atomide.com>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <9251918.dhlInzvbvO@avalon>
 <20140721093336.GR18374@atomide.com>
 <5717663.qOZzl7syrN@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60224 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaGVGVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 02:21:00 -0400
Content-Disposition: inline
In-Reply-To: <5717663.qOZzl7syrN@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Suman Anna <s-anna@ti.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140721 11:17]:
> Hi Tony and Joerg,
> 
> On Monday 21 July 2014 02:33:36 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140721 02:16]:
> > > Hi Suman, Joerg and Tony,
> > > 
> > > On Friday 18 July 2014 11:53:56 Suman Anna wrote:
> > > > On 07/18/2014 05:49 AM, Laurent Pinchart wrote:
> > > > > Hello,
> > > > > 
> > > > > The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now that
> > > > > is has been ported to the DMA API, remove the unused virtual memory
> > > > > manager.
> > > > > 
> > > > > The removal is split in three patches to ease upstream merge. The
> > > > > first patch removes the omap-iovmm driver, the second patch removes
> > > > > setting of now unused platform data fields from arch code, and the
> > > > > last patch cleans up the platform data structure.
> > > > 
> > > > Thanks for the revised series, it looks good. I have also tested the
> > > > series on OMAP3, OMAP4 and OMAP5.
> > > > 
> > > > For the changes in the entire series,
> > > > Acked-by: Suman Anna <s-anna@ti.com>
> > > 
> > > Thank you.
> > > 
> > > > > I'd like to get at least the first patch merged in v3.17. To avoid
> > > > > splitting the series across three kernel versions, it would be nice to
> > > > > also merge at least the second patch for v3.17. If there's no risk of
> > > > > conflict everything could be merged in one go through the ARM SoC
> > > > > tree. Otherwise a stable branch with patch 1/3 will be needed to base
> > > > > the arch change on.
> > > > > 
> > > > > Joerg, Tony, how would you like to proceed ?
> > > 
> > > The v3.17 merge window is getting close, it's probably too late to merge
> > > patch 2/3. Joerg, could you please take 1/3 in your tree for v3.17 ? 2/3
> > > and 3/3 would then get in v3.18. Tony, how would you like to proceed for
> > > those ?
> >
> > How about Joerg maybe do an immutable branch against v3.16-rc1
> > with just these three patches and merge it into your tree?
> > 
> > That way I too can merge the minimal branch in if there are conflics.
> > If that works for Joerg, then for arch/arm/*omap* changes:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> I've created an immutable branch (or, rather, immutable until the changes 
> reach mainline, at which point I will remove the branch) on top of v3.16-rc1 
> with just the three patches from this series. You can find it at.
> 
> 	git://linuxtv.org/pinchartl/media.git omap/iommu
> 
> Tony, is there still time to get this (and especially patch 2/3, which touches 
> arch/ code) in v3.17 ?

Yes as long as Joerg is OK to merge that branch in :)

Regards,

Tony
