From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 5/5] OMAP: HWMOD: Unify DSS resets for all OMAPs
Date: Mon, 22 Aug 2011 13:10:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108221308380.10315@utopia.booyaka.com>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>  <1312794914-22894-6-git-send-email-tomi.valkeinen@ti.com>  <alpine.DEB.2.00.1108192327470.24016@utopia.booyaka.com>  <alpine.DEB.2.00.1108200018590.24016@utopia.booyaka.com>
 <1313996453.2168.9.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47740 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab1HVTKO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 15:10:14 -0400
In-Reply-To: <1313996453.2168.9.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, archit@ti.com

Hello Tomi,

On Mon, 22 Aug 2011, Tomi Valkeinen wrote:

> On Sat, 2011-08-20 at 00:26 -0600, Paul Walmsley wrote:
> > On Fri, 19 Aug 2011, Paul Walmsley wrote:
> > 
> > > This one doesn't build when !CONFIG_OMAP2_DSS - the following is the 
> > > updated patch.
> > 
> > Looks like my previous update missed a warning.  This also moves the 
> > omap_dss_reset() prototype from arch/arm/mach-omap2/common-board-devices.h 
> > to arch/arm/plat-omap/include/plat/common.h.
> 
> Related to this, there's also omap_display_init() function in display.c,
> called by the board files, which I would like to move elsewhere from
> include/video/omapdss.h.
> 
> I was thinking of moving it to
> arch/arm/mach-omap2/common-board-devices.h but should I move it to
> arch/arm/plat-omap/include/plat/common.h so that it's in the same place
> with omap_dss_reset() (also from display.c)?

In the long run, it seems good to get rid of 
arch/arm/plat-omap/include/plat/common.h.  What I'd suggest is to move all 
of the OMAP2+-specific integration structures and macros into 
arch/arm/mach-omap2/omapdss.h or something similar.  I would have done 
this in the 3.1-rc patch, but the change seemed too intrusive for the -rc 
series.


- Paul
