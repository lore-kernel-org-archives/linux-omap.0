From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] OMAP3: GPIO: Only enable WAKEUPEN for edge
 detection GPIOs
Date: Tue, 11 May 2010 15:57:34 -0700
Message-ID: <20100511225734.GK13931@atomide.com>
References: <1272929177-22685-1-git-send-email-khilman@deeprootsystems.com>
 <1272929177-22685-3-git-send-email-khilman@deeprootsystems.com>
 <20100510211105.GI16460@atomide.com>
 <87vdaufr92.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58537 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0EKW5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 18:57:32 -0400
Content-Disposition: inline
In-Reply-To: <87vdaufr92.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Chunqiu Wang <cqwang@motorola.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100511 07:22]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100503 16:28]:
> >> From: Chunqiu Wang <cqwang@motorola.com>
> >> 
> >> According to the GPIO 'Wakeup and Interrupt' section of the TRM[1],
> >> wake-up requests can only be generated on edge transitions.
> >> 
> >> Also for OMAP3, only edge GPIOs may lose interrupts when PER enters
> >> RET/OFF state, this is addressed by gpio prepare|resume idle functions
> >
> > There's a generic solution to this problem. The solution is to temporarily
> > set the level GPIO pins into edge for the duration of idle. Then
> > they need to be set back to level after the system is woken up.
> 
> Sure, but that doesn't change the need for this patch which is
> a correctness fix.
> 
> Adding wakeup support for level GPIOs would be a separate fix.

OK, let's plan on merging these then. Want me to pick these,
or pull from some branch?

Looks like they also need to be posted to LAKML too, and we
should get them into linux-omap master for some testing.

Looks like these should not cause much of merge issues with
the gpio platform init patches. It would be nice to get those
merged too if possible.

Regards,

Tony
