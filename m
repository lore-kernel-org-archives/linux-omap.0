From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 01/23] ARM: MMU: add a Non-cacheable Normal executable
 memory type
Date: Mon, 15 Dec 2008 12:58:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812151257280.26754@utopia.booyaka.com>
References: <1229010762-3150-1-git-send-email-tero.kristo@nokia.com> <1229010762-3150-2-git-send-email-tero.kristo@nokia.com> <20081215190620.GA10664@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45420 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbYLOT6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:58:03 -0500
In-Reply-To: <20081215190620.GA10664@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org

On Mon, 15 Dec 2008, Tony Lindgren wrote:

> * Tero Kristo <tero.kristo@nokia.com> [081211 07:59]:
> > From: Paul Walmsley <paul@pwsan.com>
> > 
> > Add a Non-cacheable Normal ARM executable memory type,
> > MT_MEMORY_NONCACHED.  This is needed for the OMAP3 SDRAM clock change
> > code, which must run from SRAM.  The SRAM must be marked as
> > non-cacheable memory to avoid dirty cache line writebacks to SDRAM
> > while the SDRAM controller is paused.
> 
> This should be discussed on LAKML.

Yeah, it's my understanding that these patches are targeted for the PM 
branch.


- Paul
