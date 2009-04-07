From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest tmlid/linux-omap-2.6.git changes
Date: Tue, 7 Apr 2009 16:45:08 -0700
Message-ID: <20090407234508.GF23823@atomide.com>
References: <f9d2a5e10904071541k3c7c233x82c303e50cafc7a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60347 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZDGXpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 19:45:12 -0400
Content-Disposition: inline
In-Reply-To: <f9d2a5e10904071541k3c7c233x82c303e50cafc7a6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

* Russ Dill <russ.dill@gmail.com> [090407 15:41]:
> f64f3007, "omap_hsmmc: Flush posted write to IRQ" doesn't change any files.
> 
> It appears that the patch in question is here:
> 
> http://patchwork.kernel.org/patch/16515/
> 
> But it looks like it would have created a conflict with b420f201,
> "MMC: OMAP: flush posted write to IRQ". The f64f3007 patch adds a read
> in two places, but the b420f201 patch only adds a read in one place.

Thanks, looks like I need to fix that in omap-pool, otherwise git merge
will automerge that one.
 
> It also apears that e6cb736 "Initial import of extra code in
> arch/arm/*omap* into omap-pool branch", sets arch/arm/plat-omap/dma.c
> to mode 755, and the merge a01c39f, "Merge branch 'omap-fixes'" keeps
> that mode.

Hmm, I wonder how that got set.. Should be fixed now.

Once I have the omap-pool patches broken down into individual patches,
this constant merging should calm down a bit.

Regards,

Tony
