From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Mon, 13 Jun 2011 18:41:08 +0200
Message-ID: <201106131841.08465.laurent.pinchart@ideasonboard.com>
References: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com> <201106081248.01793.laurent.pinchart@ideasonboard.com> <20110613134034.GE3352@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:55730 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab1FMQlC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 12:41:02 -0400
In-Reply-To: <20110613134034.GE3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, teemu.tuominen@cybercom.com, Ohad Ben-Cohen <ohad@wizery.com>

Hi Tony,

On Monday 13 June 2011 15:40:34 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110608 03:43]:
> > Hi Tony,
> > 
> > On Monday 30 May 2011 14:47:07 Laurent Pinchart wrote:
> > > Hi everybody,
> > > 
> > > Here are two OMAP3 IOMMU fixes required to support big and/or unaligned
> > > memory buffers.
> > > 
> > > Laurent Pinchart (2):
> > >   omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
> > >   omap3: iovmm: Support non page-aligned buffers in iommu_vmap
> > 
> > As per Russell comments, the first patch needs more work (or at least
> > more discussions). Could you apply the second patch already ?
> 
> It's getting too late for this cycle as this can be counted as
> "features that never worked" type of patch. If it's a regression,
> then please specify the commit breaking this suport.
> 
> So let's plan on doing the move to drivers and patching whatever is
> needed for the upcoming merge window.

OK. Ohad, could you please apply this patch to your tree and submit it with 
the whole series for 3.1 ?

-- 
Regards,

Laurent Pinchart
