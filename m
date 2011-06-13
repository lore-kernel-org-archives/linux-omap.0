From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Mon, 13 Jun 2011 06:40:34 -0700
Message-ID: <20110613134034.GE3352@atomide.com>
References: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <201106081248.01793.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:30728 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752968Ab1FMNkh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 09:40:37 -0400
Content-Disposition: inline
In-Reply-To: <201106081248.01793.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, teemu.tuominen@cybercom.com

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110608 03:43]:
> Hi Tony,
> 
> On Monday 30 May 2011 14:47:07 Laurent Pinchart wrote:
> > Hi everybody,
> > 
> > Here are two OMAP3 IOMMU fixes required to support big and/or unaligned
> > memory buffers.
> > 
> > Laurent Pinchart (2):
> >   omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
> >   omap3: iovmm: Support non page-aligned buffers in iommu_vmap
> 
> As per Russell comments, the first patch needs more work (or at least more 
> discussions). Could you apply the second patch already ?

It's getting too late for this cycle as this can be counted as
"features that never worked" type of patch. If it's a regression,
then please specify the commit breaking this suport.

So let's plan on doing the move to drivers and patching whatever is
needed for the upcoming merge window.

Regards,

Tony
