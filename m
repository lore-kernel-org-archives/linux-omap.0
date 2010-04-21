From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3][v2] OMAP:iommu support for OMAP4
Date: Wed, 21 Apr 2010 15:00:05 -0700
Message-ID: <20100421220004.GO18272@atomide.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E5@dlee03.ent.ti.com>
 <w2h94a0d4531004201448s1ad276f5ncf7c0de273481fe2@mail.gmail.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4B3BF8B8@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58615 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab0DUWAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 18:00:09 -0400
Content-Disposition: inline
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF8B8@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

* Kanigeri, Hari <h-kanigeri2@ti.com> [100420 15:03]:
> Felipe,
> 
> > -----Original Message-----
> > From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> > Sent: Tuesday, April 20, 2010 4:49 PM
> > To: Kanigeri, Hari
> > Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Hiroshi DOYU;
> > tony@atomide.com
> > Subject: Re: [PATCH 1/3][v2] OMAP:iommu support for OMAP4
> > 
> > On Wed, Apr 21, 2010 at 12:31 AM, Kanigeri, Hari <h-kanigeri2@ti.com>
> > wrote:
> > > From 9a6f91b0c108fd010afdb6bddcae92579c87fcbd Mon Sep 17 00:00:00 2001
> > > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > > Date: Tue, 20 Apr 2010 12:03:03 -0500
> > > Subject: [PATCH 1/3] OMAP:iommu support for OMAP4
> > >
> > > This patch provides the iommu support for OMAP4 co-processors.
> > > This includes changes to omap3-iommu.c file to make it generic
> > > for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c
> > 
> > This smells like two patches: one that moves omap3-iommu to
> > omap-iommu, and another one that adds omap4 support.
> > 
> > But unfortunately this would break multi-omap support. I think both
> > omap3 and omap4 devices should be there, and selected at run-time.
> > 
> 
> -- I am not sure as why this would break multi-omap support. We would select either OMAP3 or OMAP4 specific structures at compile time based on the platform selected, and rest of the code is same for both OMAP3/4.

We can compile and boot omap2 + omap3 + omap4 with the same
kernel, see omap3_defconfig.

Tony
