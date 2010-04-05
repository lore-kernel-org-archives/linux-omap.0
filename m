From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Mon, 5 Apr 2010 17:05:48 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703049B66A2@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D798A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001131051210.20437@utopia.booyaka.com>
 <alpine.DEB.2.00.1001131355210.20437@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB031E3F145D@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001252234130.18597@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60131 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab0DELgA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 07:36:00 -0400
In-Reply-To: <alpine.DEB.2.00.1001252234130.18597@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Paul,
Sorry for late response. Here is the answer for some of the queries that you had posted.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, January 26, 2010 11:13 AM
> To: Reddy, Teerth
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Kevin Hilman
> Subject: RE: [PATCH] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall in
> SDRC after a Warm-reset
> 
> Hello Teerth,
> 
> On Mon, 25 Jan 2010, Reddy, Teerth wrote:
> 
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > >
> > > I wonder if this also needs to make sure that all the other system
> > > initiators are mute before continuing, for the same reason cited in commit
> > > 18862cbe47e37beba98f22c088fbe6fe029df889 ?  I suppose that, for example,
> > > if an interrupt occurs on the IVA2.2 or the DMA controller tries to access
> > > the SDRC, it would hopefully only wedge those initiators and not the whole
> > > chip?
> >  Do you think we need to take care of the system initiators if we are
> > disabling all the interrupts before going for a warm reset?
> 
> Are you disabling _all_ the interrupts, or just the MPU's interrupts?
> Even if you did disable all of the system interrupts, couldn't DMA be
> ongoing from/to another system initiator, independently of interrupts?
We should disable all MPU interrupts. 
Yes there can be another initiator active in the system parallelly. However all the system initiators will recover from reset once warm reset is triggered.
> 
> > I think this doesn't seem to hold good here.
> 
> You may be right, but I'd like you to describe your reasoning on this
> point.
> 
> > Please let me know if you understanding is wrong.
> 
> My concerns here are twofold:
> 
> 1. If other system initiators are interacting with the SDRC during this
> process, is there a danger that the interconnect could enter a state that
> would prevent the warm reset from occurring, thus wedging the system?
This should not happen since bottle neck would be L4, only initiators accessing L4 are expected to be MPU and DMA (and maybe DSP) and L4 has 4 threads. We cannot think of a blocking scenario.
> 
> 2. When the warm-reset occurs, will it also completely reset other
> initiators that may be wedged waiting for some SDRC access to complete?
Yes

Vishwa
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
