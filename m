From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Wed, 13 Jan 2010 14:00:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com> <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab0AMVAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 16:00:54 -0500
In-Reply-To: <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello Teerth,

another question that just occurred to me.

On Wed, 13 Jan 2010, Paul Walmsley wrote:

> > @@ -147,10 +149,9 @@ void omap_prcm_arch_reset(char mode)
> >  		 * cf. OMAP34xx TRM, Initialization / Software Booting
> >  		 * Configuration. */
> >  		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> > +		omap3_warmreset();

Wouldn't this code need to enable interrupts before calling 
omap3_sram_warmreset()?  Seems like an interrupt could occur after the 
SDRC has been placed into idle which could effectively hang the ARM.  

I wonder if this also needs to make sure that all the other system 
initiators are mute before continuing, for the same reason cited in commit 
18862cbe47e37beba98f22c088fbe6fe029df889 ?  I suppose that, for example, 
if an interrupt occurs on the IVA2.2 or the DMA controller tries to access 
the SDRC, it would hopefully only wedge those initiators and not the whole 
chip?

- Paul
