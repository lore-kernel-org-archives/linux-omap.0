From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Mon, 25 Jan 2010 22:42:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001252234130.18597@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com> <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com> <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E3F145D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45777 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0AZFmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 00:42:54 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F145D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello Teerth,

On Mon, 25 Jan 2010, Reddy, Teerth wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> >
> > I wonder if this also needs to make sure that all the other system
> > initiators are mute before continuing, for the same reason cited in commit
> > 18862cbe47e37beba98f22c088fbe6fe029df889 ?  I suppose that, for example,
> > if an interrupt occurs on the IVA2.2 or the DMA controller tries to access
> > the SDRC, it would hopefully only wedge those initiators and not the whole
> > chip?
>  Do you think we need to take care of the system initiators if we are 
> disabling all the interrupts before going for a warm reset?

Are you disabling _all_ the interrupts, or just the MPU's interrupts?  
Even if you did disable all of the system interrupts, couldn't DMA be 
ongoing from/to another system initiator, independently of interrupts?

> I think this doesn't seem to hold good here.

You may be right, but I'd like you to describe your reasoning on this 
point. 

> Please let me know if you understanding is wrong.

My concerns here are twofold:

1. If other system initiators are interacting with the SDRC during this 
process, is there a danger that the interconnect could enter a state that 
would prevent the warm reset from occurring, thus wedging the system?

2. When the warm-reset occurs, will it also completely reset other 
initiators that may be wedged waiting for some SDRC access to complete?


- Paul
