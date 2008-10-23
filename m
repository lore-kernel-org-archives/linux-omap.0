From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt
	bits
Date: Thu, 23 Oct 2008 11:21:35 -0700
Message-ID: <20081023182135.GM2994@atomide.com>
References: <E1Kt4gl-0003Zw-EM@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65145 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758260AbYJWSVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2008 14:21:39 -0400
Content-Disposition: inline
In-Reply-To: <E1Kt4gl-0003Zw-EM@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

* Rick Bronson <rick@efn.org> [081023 11:13]:
> Tony,
> 
> > Well we should let the generic irq handler to do the logging.. But I
> > guess nothing will happen if adm_do_IRQ() does not get called.
> > 
> > We could have a dummy handler for some invented higher number that would
> > capture the spurious interrupts I guess.
> > 
> > BTW, ideally we would do the ldr conditionally rather than every time,
> > I guess that's the idea with the old way of doing things.
> 
>   Well, actually the ldr (I assume you mean this one):
> 
> 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> 
>   was being done everytime, since presumably, at least one of the
> "pending" bits would be set otherwise how would we get to this
> interrupt?  Which bring up a point - why bother even checking the
> pending bits at all?   Just grab the irqnr, check for spurious and
> exit.

Yeah that would be nice.

Tony
