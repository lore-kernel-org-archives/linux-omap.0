From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH 0/6] ARM: OMAP4+: hwmod: fixing omap4+ DSS hwmods
Date: Thu, 20 Nov 2014 07:04:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411200342370.9204@utopia.booyaka.com>
References: <1412863399-9508-1-git-send-email-tomi.valkeinen@ti.com> <5465C2A4.3060901@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59400 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaKTHEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 02:04:32 -0500
In-Reply-To: <5465C2A4.3060901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Archit Taneja <archit.taneja@gmail.com>

Hi Tomi,

thanks for the ping.

On Fri, 14 Nov 2014, Tomi Valkeinen wrote:

> On 09/10/14 17:03, Tomi Valkeinen wrote:
> > This is an RFC to fix the issues with boot time DSS hwmod setup.
> > 
> > There was an earlier series sent by Archit here:
> > 
> > http://www.spinics.net/lists/linux-omap/msg107700.html
> > 
> > This series takes different approach, and just tries to fix the issue at setup
> > time by making sure the DSS core hwmod is enabled when a DSS submodule hwmod is
> > being setup.
> > 
> > Quickly tested on OMAP4 Panda and OMAP5 uEVM.
> > 
> >  Tomi
> > 
> > Tomi Valkeinen (6):
> >   ARM: OMAP2+: hwmod: add parent_hwmod support
> >   ARM: OMAP5: hwmod: set DSS submodule parent hwmods
> >   ARM: OMAP4: hwmod: set DSS submodule parent hwmods
> >   ARM: OMAP4: hwmod: use MODULEMODE properly
> >   ARM: OMAP4: fix RFBI iclk
> >   ARM: dts: omap4.dtsi: remove dss_fck
> > 
> >  arch/arm/boot/dts/omap4.dtsi               |  2 +-
> >  arch/arm/boot/dts/omap44xx-clocks.dtsi     |  8 --------
> >  arch/arm/mach-omap2/omap_hwmod.c           | 22 ++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod.h           |  1 +
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 25 ++++++++++++++++---------
> >  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  5 +++++
> >  6 files changed, 45 insertions(+), 18 deletions(-)
> > 
> 
> Ping. Would this series be acceptable?

Yes, it looks good for the short term, and definitely moves us closer to 
where we should be.  

Queued with Archit's Reviewed-by:, with some extra documentation added to 
the first patch.  If you have a spare moment, could you take a quick look 
at it?  It should not result in any functional changes.

In theory, that .parent_hwmod information should come from the 
omap_hwmod_ocp_if data.  But as you know, unfortunately due to some 
limitations in the hwmod code, we don't handle IP blocks with multiple 
interconnect parents very well right now.  Ultimately we should only have 
one "OCP" interface between each of the DSS IP blocks.  But for that to 
work, the physical address code needs to be overhauled, and the data 
should be specified as offsets rather than absolute addresses.  One of 
these days.


- Paul
