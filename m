From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] adding back some features
Date: Wed, 17 Jun 2009 02:35:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906170233400.3382@utopia.booyaka.com>
References: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com> <20090615080001.GC4474@atomide.com> <87ski1a6n1.fsf@deeprootsystems.com> <87k53da3eb.fsf@deeprootsystems.com> <20090617083119.GF6605@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33656 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbZFQIfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 04:35:46 -0400
In-Reply-To: <20090617083119.GF6605@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, tero.kristo@nokia.com
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

code comment below:

On Wed, 17 Jun 2009, Tony Lindgren wrote:

> * Kevin Hilman <khilman@deeprootsystems.com> [090615 09:05]:
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> > 
> > > Tony Lindgren <tony@atomide.com> writes:
> > >
> > >> Hi,
> > >>
> > >> * Kevin Hilman <khilman@deeprootsystems.com> [090612 15:13]:
> > >>> Here's a couple patches to add-back some feature dropped in the
> > >>> mainline sync.  These are needed for the PM branch among other things.
> > >>> 
> > >>> Applies to linux-omap master.
> > >>> 
> > >>> Kevin Hilman (1):
> > >>>   OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS
> > >>
> > >> Is there any reason to get this one into mainline early?
> > >
> > > Well, the PM branch has a dependency, but also the recenetly submitted
> > > qwatchdog driver has a dependency.
> > >
> > >> If not, I suggest you keep this in your pm branch for next merge
> > >> window that I can keep merging to l-o master as needed.
> > >>
> > >> However, if omap_type() is by other queues earlier, then I can
> > >> add it into my upstream queue. If this blocks several queues
> > >> from being rebased against mainline kernel, that alone might
> > >> already be a good enough reason to get it in early.
> > >
> > > I think it should go via your upstream queue.  I imagine some of the
> > > other upcoming driver submissions from TI will have a dependency as
> > > well since there is still some missing EMU/HS support ind drivers.
> > 
> > Also, I'm carrying this SRAM patch below for HS/EMU that could go into
> > Paul's SRAM/SDRC queue if this omap_type() gets merged sooner rather
> > than later.
> 
> Hmm, the HS omap sram.c patch below for sure justifies fixing it as
> incorrect SRAM size can cause nasty bugs.
> 
> Will add both omap_type and the sram.c patch below to omap-fixes.
> 
> Regards,
> 
> Tony
>  
> > Kevin
> > 
> > commit 106588e30f070d9a8d5906d409e0b9aad89edc9e
> > Author: Tero Kristo <tero.kristo@nokia.com>
> > Date:   Thu Oct 9 17:47:02 2008 +0300
> > 
> >     OMAP3: SRAM size fix for HS/EMU devices
> >     
> >     Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> >     Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
> > 
> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > old mode 100644
> > new mode 100755
> > index 65006df..f40bd2d
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -131,9 +131,15 @@ void __init omap_detect_sram(void)
> >  	if (cpu_class_is_omap2()) {
> >  		if (is_sram_locked()) {
> >  			if (cpu_is_omap34xx()) {
> > -				omap_sram_base = OMAP3_SRAM_PUB_VA;
> > -				omap_sram_start = OMAP3_SRAM_PUB_PA;
> > -				omap_sram_size = 0x8000; /* 32K */
> > +				if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
> > +					omap_sram_base = OMAP3_SRAM_PUB_VA;
> > +					omap_sram_start = OMAP3_SRAM_PUB_PA;
> > +					omap_sram_size = 0x8000; /* 32K */
> > +				} else {

This would be better if it specifically tested for HS and EMU devices.  
There are at least two other omap_type() possibilities here, "TEST" and 
"BAD"

> > +					omap_sram_base = OMAP3_SRAM_PUB_VA;
> > +					omap_sram_start = OMAP3_SRAM_PUB_PA;
> > +					omap_sram_size = 0x7000; /* 28K */
> > +				}
> >  			} else {
> >  				omap_sram_base = OMAP2_SRAM_PUB_VA;
> >  				omap_sram_start = OMAP2_SRAM_PUB_PA;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
