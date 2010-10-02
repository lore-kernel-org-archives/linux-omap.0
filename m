From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV4] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall
 in SDRC after a Warm-reset
Date: Fri, 1 Oct 2010 18:25:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010011825270.22941@utopia.booyaka.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03229868BA@dbde02.ent.ti.com> <alpine.DEB.2.00.1005181816380.27473@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB0322FA8926@dbde02.ent.ti.com> <alpine.DEB.2.00.1009151533560.458@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608703117EA1CA@dbde02.ent.ti.com> <alpine.DEB.2.00.1009211859090.4677@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC3560870311976EF2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41125 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab0JBAZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 20:25:43 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870311976EF2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vishwa,

On Wed, 22 Sep 2010, Sripathy, Vishwanath wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, September 22, 2010 6:37 AM
> > To: Sripathy, Vishwanath
> > Cc: Reddy, Teerth; linux-omap@vger.kernel.org
> > Subject: RE: [PATCHV4] OMAP3: SDRC : Errata 1.176 Fix - Accesses to DDR stall in
> > SDRC after a Warm-reset
> > 
> > Hello Vishwa,
> > 
> > Thanks for the info.
> > 
> > a few quick questions:
> > 
> > On Thu, 16 Sep 2010, Sripathy, Vishwanath wrote:
> > 
> > > > -----Original Message-----
> > > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > > Sent: Thursday, September 16, 2010 3:05 AM
> > > >
> > > > On Tue, 25 May 2010, Reddy, Teerth wrote:
> > > >
> > > > > > -----Original Message-----
> > > > > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > > > > Sent: Wednesday, May 19, 2010 6:03 AM
> > > > > > To: Reddy, Teerth
> > > > > >
> > > > > > On Fri, 23 Apr 2010, Reddy, Teerth wrote:
> > > > > >
> > > > > > > From: Teerth Reddy <teerth@ti.com>
> > > > > > >
> > > > > > > This patch has the workaround for errata 1.176.
> > > >
> > > > What's the current status of this patch?  Still waiting for an updated
> > > > version.
> > >
> > > We have realized that this errata is not applicable if reset is
> > > triggered via dpll3 reset. The rootcasuse of the issues was that incase
> > > of warm reset, SDRC is not sensitive to the warm reset, but the
> > > interconect is reset on the fly, thus causing a misalignment between
> > > SDRC logic, interconect logic and DDR memory state. Hence the workaround
> > > was proposed. However, incase of dpll3 reset, sdrc also gets reset. In
> > > omap_prcm_arch_reset, system reset is triggered via dpll3 reset, so this
> > > WA is not applicable.
> > 
> > 
> > 1. So by "warm reset," are you referring to the software warm reset
> > triggered by GLOBAL_SW_RST, or by another mechanism?
> > Yes, warm reset by means of GLOBAL_SW_RST.
> 
> > 2. If GLOBAL_SW_RST, what do you think about adding a brief comment in the
> > code warning people not to use GLOBAL_SW_RST unless they implement the
> > Errata 1.176 sequence?
> Yes, a note can be added. I will send a patch with this comment.

Any progress on this?


- Paul
