From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] OMAP3: ack spurious IRQs in get_irqnr_and_base
Date: Fri, 17 Oct 2008 15:17:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810171517320.3833@utopia.booyaka.com>
References: <1224071511-4670-1-git-send-email-lauri.leukkunen@nokia.com> <alpine.DEB.2.00.0810170226530.729@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbYJQVR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:17:58 -0400
In-Reply-To: <alpine.DEB.2.00.0810170226530.729@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Fri, 17 Oct 2008, Paul Walmsley wrote:

> > + 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> > +#if defined(CONFIG_ARCH_OMAP34XX)
> > +		mov	\irqstat, \irqnr
> > +		bic	\irqstat, \irqstat, #0x7f /* check for spurious flag */
> 
> According to Table 10-14 in the TRM, the spurious flag field is 25 bits 
> wide, but the patch only checks for 7 bits.  This should probably be 
> extended?

eh never mind -- misread the insn.  


- Paul
