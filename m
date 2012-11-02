From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
Date: Fri, 2 Nov 2012 11:54:53 -0700
Message-ID: <20121102185453.GY15766@atomide.com>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224828.2103.82950.stgit@muffinssi.local>
 <50936A6E.3020202@ti.com>
 <5093891D.6070302@ti.com>
 <50938A69.9040908@ti.com>
 <20121102154901.GU15766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:18873 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932260Ab2KBSy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 14:54:58 -0400
Content-Disposition: inline
In-Reply-To: <20121102154901.GU15766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [121102 01:56]:
> > On Friday 02 November 2012 02:19 PM, Tomi Valkeinen wrote:
> > >On 2012-11-02 08:38, Santosh Shilimkar wrote:
> > >>
> > >>Lets not move this in DMA code since the above is really related
> > >>to frame buffer. It reserves more DMA area for dma_alloc_coherent()
> > >>etc than default 2 MB. Infact, we should no longer need this with
> > >>CMA and memblock in place.
> > >>
> > >>Tomi,
> > >>Can we not get rid of the above memory reservation ?
> > >
> > >Yes, I think so. This one is only used for the old omapfb, i.e. omap1,
> > >and I have no means to test it out, though. But below is a patch to
> > >remove it. I also attached the patch, as it looks like thunderbird wants
> > >to reformat the pasted patch... I'll remove the
> > >CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE from the omapfb driver's Kconfig file
> > >in my tree later.

Hmm actually, is it safe to remove for omap1, or should we
still keep it around for omap1?

Regards,

Tony
