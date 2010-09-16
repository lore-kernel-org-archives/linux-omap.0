From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV4] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR
 stall in SDRC after a Warm-reset
Date: Thu, 16 Sep 2010 11:19:18 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703117EA1CA@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03229868BA@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1005181816380.27473@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322FA8926@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1009151533560.458@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab0IPFt1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 01:49:27 -0400
In-Reply-To: <alpine.DEB.2.00.1009151533560.458@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, September 16, 2010 3:05 AM
> To: Reddy, Teerth
> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath
> Subject: RE: [PATCHV4] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall in
> SDRC after a Warm-reset
> 
> Teerth, Vishwa,
> 
> On Tue, 25 May 2010, Reddy, Teerth wrote:
> 
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Wednesday, May 19, 2010 6:03 AM
> > > To: Reddy, Teerth
> > > Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath
> > > Subject: Re: [PATCHV4] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR
> > > stall in SDRC after a Warm-reset
> > >
> > > On Fri, 23 Apr 2010, Reddy, Teerth wrote:
> > >
> > > > From: Teerth Reddy <teerth@ti.com>
> > > >
> > > > This patch has the workaround for errata 1.176.
> 
> What's the current status of this patch?  Still waiting for an updated
> version.
We have realized that this errata is not applicable if reset is triggered via dpll3 reset.
The rootcasuse of the issues was that incase of warm reset, SDRC is not sensitive to the warm reset, but the interconect is reset on the fly, thus causing a misalignment
between SDRC logic, interconect logic and DDR memory state. Hence the workaround was proposed. However, incase of dpll3 reset, sdrc also gets reset. 
In omap_prcm_arch_reset, system reset is triggered via dpll3 reset, so this WA is not applicable. 

Regards
Vishwa
> 
> 
> - Paul
