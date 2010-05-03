From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Mon, 3 May 2010 10:34:06 -0700
Message-ID: <20100503173405.GS29604@atomide.com>
References: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
 <87zl0h6khl.fsf@deeprootsystems.com>
 <20100503163600.GQ29604@atomide.com>
 <87fx285325.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60488 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab0ECReI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 13:34:08 -0400
Content-Disposition: inline
In-Reply-To: <87fx285325.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100503 10:00]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100503 08:58]:
> >> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> >> 
> >> > If we are softbooting another kernel using kexec, DMA controller state is not
> >> > known when we are performing omap_init_dma(). It is possible that some DMA
> >> > channels are already active. For example after kexec we get:
> >> >
> >> > <4>IRQ 0020 for non-allocated DMAchannel 5
> >> > <4>IRQ 0020 for non-allocated DMAchannel 5
> >> > <4>IRQ 0020 for non-allocated DMAchannel 5
> >> > <4>IRQ 0020 for non-allocated DMAchannel 5
> >> > <4>IRQ 0020 for non-allocated DMAchannel 5
> >> >
> >> > To prevent any weird things happening, we perform soft reset for the controller
> >> > and disable all per channel interrupts.
> >> >
> >> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> >> 
> >> This is a good fix, but we get reset of DMA (and all other blocks) for
> >> free when switching to hwmod.  Here's a good reason to convert DMA
> >> to hwmod.
> >
> > Hmm, do we have existing DMA hwmod patches somewhere that work on all omaps?
> 
> No, that's my point. 
> 
> Rather than implement reset here (then remove it with DMA hwmods) I'd
> rather just see a DMA hwmods added, and then we get reset for free.

Sure. But until we have something available we should get the fix part in.

AFAIK just disabling the channel interrupt in omap_clear_dma() should
do the trick, see my other reply.

Regards,

Tony
