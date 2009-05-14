From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/2] PM: OMAP3 SDRC: fix some SDRAM settings for
 Qimonda parts
Date: Thu, 14 May 2009 14:54:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905141454350.17514@utopia.booyaka.com>
References: <20090514194728.20623.60039.stgit@localhost.localdomain> <20090514205157.GS5593@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48901 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZENUyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 16:54:43 -0400
In-Reply-To: <20090514205157.GS5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, khilman@deeprootsystems.com

On Thu, 14 May 2009, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [090514 12:52]:
> > Hi,
> > 
> > This series updates some SDRAM parameter settings for the Qimonda parts
> > used on some 3430SDP boards.
> > 
> > Drop the 133.3MHz/66.6MHz rates from the Qimonda SDRAM file - these were only
> > used on some early Labrador boards with slower SDRAM parts.  Thanks to
> > Richard Woodruff <r-woodruff2@ti.com> for help with this patch.
> > 
> > Finally some 3430SDP boards are using bootloaders with rounded DPLL3 rates
> > (e.g., 166000000 Hz rather than 165941176 Hz); update the Qimonda SDRAM
> > parameters.  This resolves -EINVALs during boot-time "Reprogramming SDRC"
> > on 3430SDPs with updated bootloaders.  Thanks to Kevin Hilman
> > <khilman@deeprootsystems.com> for reporting this issue and testing
> > the patch.
> > 
> > These patches will be queued up into the omap-clock-testing branch at the
> > next opportunity.
> 
> I've merged these two patches already into your older sdram patches
> in the omap3-upstream queue.

Sweet!  Thanks!

- Paul
