From: Tony Lindgren <tony@atomide.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Thu, 22 Jan 2009 16:02:21 -0800
Message-ID: <20090123000220.GE7172@atomide.com>
References: <1231921649.13843.171.camel@eenurkka-desktop> <20090114152806.GP29324@atomide.com> <20090119095429.629b2606.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50191 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbZAWACY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 19:02:24 -0500
Content-Disposition: inline
In-Reply-To: <20090119095429.629b2606.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>, linux-omap@vger.kernel.org, "ext Lopez Cruz, Misael" <x0052729@ti.com>

* Jarkko Nikula <jarkko.nikula@nokia.com> [090118 23:54]:
> On Wed, 14 Jan 2009 17:28:07 +0200
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > > You need to have the counterpart (in /sound/soc/omap/omap-mcbsp.c) for
> > > that patch, othwerwise there's no chance to hear any DMA transferred
> > > audio.
> > 
> > Jarkko, can you post the patch queued up for alsa? We might want to
> > have that in linux-omap too.
> > 
> Patch was made by Misael and I think he is waiting until the plat-omap
> part goes into mainline. And which means that OMAP3 audio is broken
> until sound/soc/omap/omap-mcbsp.c is patched.
> 
> I would say that we wouldn't want to hack with sound/ directory in
> linux-omap. Especially code which is not in Takashi's tree since then
> we have yet another conflict point if one wants to merge from his tree
> on top of linux-omap.
> 
> Probably we should revert the patch and split it into three
> separate patches:
> 
> 1. Header change in linux-omap adding those registers (and queue it)
> 2. Patch to alsa-devel setting default values to those registers
> 3. Patch to linux-omap writing those registers

OK, I've reverted #3 above in l-o master and omap-2.6.28 branches.

> Or better: send those two patches to LKML, cc linux-omap and alsa-devel
> and let it fall down from -mm or linux-next tree.

Well since #3 is already queued in omap-fixes, I'd rather let it go to
mainline and not mess with that queue.

Maybe after that you could try to get #1 & #2 above merged to mainline
via alsa-devel list as one patch?

Regards,

Tony
