From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Mon, 25 Jan 2010 12:52:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F145D@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com>
 <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59876 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab0AYHXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jan 2010 02:23:01 -0500
In-Reply-To: <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, January 14, 2010 2:31 AM
> To: Reddy, Teerth
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Kevin Hilman
> Subject: Re: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR
> stall in SDRC after a Warm-reset
> 
> Hello Teerth,
> 
> another question that just occurred to me.
> 
> On Wed, 13 Jan 2010, Paul Walmsley wrote:
> 
> > > @@ -147,10 +149,9 @@ void omap_prcm_arch_reset(char mode)
> > >  		 * cf. OMAP34xx TRM, Initialization / Software Booting
> > >  		 * Configuration. */
> > >  		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
> > > +		omap3_warmreset();
> 
> Wouldn't this code need to enable interrupts before calling
> omap3_sram_warmreset()?  Seems like an interrupt could occur after the
> SDRC has been placed into idle which could effectively hang the ARM.

I agree with you. I ll add the changes to disable interrupts before going for a warm reset.
 

> I wonder if this also needs to make sure that all the other system
> initiators are mute before continuing, for the same reason cited in commit
> 18862cbe47e37beba98f22c088fbe6fe029df889 ?  I suppose that, for example,
> if an interrupt occurs on the IVA2.2 or the DMA controller tries to access
> the SDRC, it would hopefully only wedge those initiators and not the whole
> chip?
 
Do you think we need to take care of the system initiators if we are disabling all the interrupts before going for a warm reset? I think this doesn't seem to hold good here. Please let me know if you understanding is wrong.


Regards
Teerth


