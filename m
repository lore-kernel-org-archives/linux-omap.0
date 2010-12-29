From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 13:00:00 +0000
Message-ID: <1293627600.3451.93.camel@odin>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
	 <1293509826-23253-2-git-send-email-dlambert@ti.com>
	 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
	 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
	 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
	 <1293618931.3451.17.camel@odin>
	 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
	 <1293623571.3451.51.camel@odin>
	 <20101229120443.GB2222@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0L2NAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 08:00:04 -0500
Received: by wwa36 with SMTP id 36so10661890wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 05:00:03 -0800 (PST)
In-Reply-To: <20101229120443.GB2222@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, 2010-12-29 at 14:04 +0200, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Dec 29, 2010 at 11:52:51AM +0000, Liam Girdwood wrote:
> >I agree that drivers should be arch independent when possible, but in
> >this case the OMAP DMIC DAI driver is coupled to the OMAP platform only.
> >i.e. it performs IO directly on the OMAP DMIC IP. This IP is only found
> >on OMAP silicon.
> 
> Let's imagine this IP is sourced from someone else and not created by
> TI, what prevents company XYZ from sourcing the same IP and end up
> re-using the driver ?

That's fine, but this is not the case atm for this particular DMIC IP
and we can only justify effort for OMAP atm.

> 
> >I also agree it would be nice if it builds for PXA, MIPS, SuperH etc but
> >what happens when the driver builds fine for OMAP but breaks the PXA,
> >MIPS, SuperH build ? Who will spend time to fix and test it ?
> 
> You forgetting about other ARMs. This won't compile on DaVinci either.
> 
> >My main problem here is cost benefit. No one benefits directly by having
> >this driver available for the above platforms but it costs me time
> >fixing it when it breaks.
> 
> Of course there's people benefitting: OMAP audio driver writers would
> know their driver is well written and doesn't break build for anybody.
> 
> Ok, let me put it this way:
> 
> What happens when you want have one kernel image for OMAP and DaVinci ?
> Granted, that's not possible today anyway but e.g. Linaro is pushing for
> it and IMO should be the way to go for us to be able to have a
> distro-like kernel for ARM-based systems too.
> 

Ok, I now think you meant other "ARM architectures" here than other
Linux architectures in general. It does make a more sense for ARM
distribution deployment, but I still think guaranteeing successful build
for this driver on all non ARM architectures atm just to give us
satisfaction that the driver is "well written" is unnecessary effort.

> >> >It also seems inconsistent with the other OMAP system headers in
> >> >plat-omap too.
> >>
> >> Other than a few drivers which still need converting (and are on their
> >> way) I can only see really arch-specific bits and pieces under plat/.
> >>
> >> Not sure what's your point here.
> >>
> >
> >The point is that David had split the DMIC headers into two files, one
> >for plat specific registers and bit definitions and the other for audio
> >definitions (for the machine drivers) and is/was consistent with the
> >current OMAP platform headers.
> 
> You forgot to mention that plat/ headers are supposed to be used by
> plat-* and mach-* code only to setup the correct state for the driver.
> Just recently one of the musb glue layers got broken because it was
> mistakenly using <plat/control.h> and that got moved.
> 
> That's actually my point and why I think drivers should not touch plat/*
> and mach/* headers.
> 

In a lot of cases drivers under drivers/* and sound/* must touch plat/*
and mach/* headers for runtime access to hardware IP. I've just grepped
and the list is quite long for drivers/*

Liam


