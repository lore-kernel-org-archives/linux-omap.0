From: "Y, Kishore" <kishore.y@ti.com>
Subject: RE: [PATCH 0/3] OMAP: DSS: Low power refresh rate support for dss
Date: Wed, 23 Dec 2009 18:50:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD4076C@dbde02.ent.ti.com>
References: <3647DBDA80551C4696E9E4506F0BE08E2183E0A017@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39363 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111AbZLWNTs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 08:19:48 -0500
In-Reply-To: <3647DBDA80551C4696E9E4506F0BE08E2183E0A017@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tomi.Valkeinen@nokia.com" <Tomi.Valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi.Valkeinen@nokia.com [mailto:Tomi.Valkeinen@nokia.com]
> Sent: Wednesday, December 23, 2009 4:29 PM
> To: Y, Kishore
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH 0/3] OMAP: DSS: Low power refresh rate support for dss
> 
> > ________________________________________
> > From: ext Y, Kishore [kishore.y@ti.com]
> > Sent: Wednesday, December 23, 2009 12:22
> > To: Valkeinen Tomi (Nokia-D/Helsinki)
> > Cc: Kevin Hilman; linux-omap@vger.kernel.org
> > Subject: RE: [PATCH 0/3] OMAP: DSS: Low power refresh rate support for
> dss
> >
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Tuesday, December 22, 2009 4:44 PM
> > > To: Y, Kishore
> > > Cc: Kevin Hilman; linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH 0/3] OMAP: DSS: Low power refresh rate support for
> dss
> > >
> > > Hi,
> > >
> > > On Tue, 2009-12-22 at 10:37 +0100, ext Y, Kishore wrote:
> > > > These patches add Low Power Refresh functionality for DSS.
> > > > Short info on patches
> > > >
> > > > DSS PM_WKEN to refill DMA
> > > >     - DMA request to refill the FIFO will wake up the CORE domain
> > > > DSS2 LPR enable and disable function definition
> > > >     - LPR enable and disable functions implementing FIFO merge
> > > > DSS2 sysfs enteries to export LPR enable to user
> > > >     - sysfs entries for above methods
> > >
> > > I don't like this approach very much. Fifo merge should be automatic,
> > > not user configurable. It should be integrated into the apply/cache
> > > mechanism in manager.c.
> > >
> > > I actually implemented fifo merge at some point during DSS2
> development,
> > > but I had to remove it when changing the driver/device model. I
> haven't
> > > had time to implement it again, as it not very trivial. The old
> version
> > > can be found in N900's kernel, and earlier snapshots of DSS2.
> >
> > Can you point me to the git for N900 code or ur old dss code? I couldn't
> find it.
> 
> I don't know if there's a git tree, but the kernel source can be
> downloaded from, for example,
> http://repository.maemo.org/pool/fremantle/free/k/kernel/kernel-
> source_2.6.28-20094102.3+0m5_all.deb
> 
> Use "dpkg -x file.deb ." to extract.
> 
> > Please suggest:
> > How do we decide when to enable or disable lpr if we include it in
> manager.c?
> > Should we be doing it based on video pipeline usage...?
> 
> If by LPR you mean fifo-merge, I think it's simple: fifo-merge can be used
> when only one overlay is in use. And as I don't know any drawbacks with
> fifo-merge, fifo-merge should be used whenever there's only one overlay in
> use.
> 
> The complication comes from configuring fifo-merge. If I remember right,
> fifo-merge bit is not shadowed, but overlay disable/enable is, and thus
> you need to be careful that the overlays really are disabled when enabling
> fifo-merge etc.

Here we only do fifo-merge for LPR. I would make the changes to remove sysfs entries and enable or disable in manager.
Regards
Kishore Y
> 
>  Tomi
> 
> Ps. Removing Kevin from cc, I don't think this concerns him.
