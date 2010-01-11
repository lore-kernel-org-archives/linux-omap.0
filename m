From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
Date: Mon, 11 Jan 2010 15:06:12 -0800
Message-ID: <20100111230612.GD5055@atomide.com>
References: <1262867408-9895-1-git-send-email-srk@ti.com>
 <4B45FC4B.9080302@ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870300519AC7@dbde02.ent.ti.com>
 <4B47491F.1000303@ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087030051A222@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64518 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab0AKXGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 18:06:07 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030051A222@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

* Govindarajan, Sriramakrishnan <srk@ti.com> [100111 04:11]:
> From: Menon, Nishanth
> > Sent: Friday, January 08, 2010 8:33 PM
> > To: Govindarajan, Sriramakrishnan
> > Cc: linux-omap@vger.kernel.org; Syed Mohammed, Khasim; Nori, Sekhar
> > Subject: Re: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for
> > OMAP
> > 
> > Govindarajan, Sriramakrishnan had written, on 01/08/2010 02:15 AM, the
> > following:
> > >
> > >> From: Menon, Nishanth
> > >> Govindarajan, Sriramakrishnan had written, on 01/07/2010 06:30 AM, the
> > >> following:
> > >>> From: Sriram <srk@ti.com>
> > >>>
> > >>> OMAP platforms(like OMAP3530) include DSP or other co-processors
> > >>> for media acceleration. when carving out memory for the
> > >>> accelerators we can end up creating a hole in the memory map
> > >>> of sort:
> > >>> <kernel memory><hole(memory for accelerator)><kernel memory>
> > >>>
> > >>> To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
> > >>> has to be enabled. For further information refer discussion at:
> > >>> http://www.mail-archive.com/linux-omap@vger.kernl.org/msg15262.html.
> > >> pls check the link: I see "The document you were looking for was not
> > >> found."
> > >
> > > The URL is spelt incorrectly. Here is the correct URL:
> > > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15262.html
> > >
> > >>>  	select GENERIC_TIME
> > >>>  	select GENERIC_CLOCKEVENTS
> > >>> +	select ARCH_HAS_HOLES_MEMORYMODEL
> > >> why enable this for all OMAPs?
> > >
> > > I have tested this on several OMAP3 platforms and this feature is
> > required
> > > Wherever some memory needs to be reserved for media accelerators - hence
> > it
> > > Would be handy for earlier OMAP platforms as well
> > I understand that you have tested with OMAP3. my question is you have
> > handled this as per the diff
> > @@ -699,6 +699,7 @@ config ARCH_OMAP
> > to ARCH_OMAP
> > 
> > is this good for OMAP1510, 1610, 1710, 2420,2430, 770 etc..?
> 
> I do not have other OMAP platforms for me to validate this patch on.
> I believe the nature of change is generic and benefit other OMAP
> Platforms as well.

Sounds like the issue is a slight performance penalty when not used.
But considering all the coprocessors, I'd say let's apply this so
the checks are in place when using the coprocessors.

Regards,

Tony
