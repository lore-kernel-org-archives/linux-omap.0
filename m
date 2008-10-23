From: Rick Bronson <rick@efn.org>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Thu, 23 Oct 2008 11:13:39 -0700
Message-ID: <E1Kt4gl-0003Zw-EM@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:45227 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757461AbYJWSNl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 14:13:41 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 32CB11700B6
	for <linux-omap@vger.kernel.org>; Thu, 23 Oct 2008 11:13:40 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1Kt4gl-0003Zw-EM
	for linux-omap@vger.kernel.org; Thu, 23 Oct 2008 11:13:39 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tony,

> Well we should let the generic irq handler to do the logging.. But I
> guess nothing will happen if adm_do_IRQ() does not get called.
> 
> We could have a dummy handler for some invented higher number that would
> capture the spurious interrupts I guess.
> 
> BTW, ideally we would do the ldr conditionally rather than every time,
> I guess that's the idea with the old way of doing things.

  Well, actually the ldr (I assume you mean this one):

		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]

  was being done everytime, since presumably, at least one of the
"pending" bits would be set otherwise how would we get to this
interrupt?  Which bring up a point - why bother even checking the
pending bits at all?   Just grab the irqnr, check for spurious and
exit.

  Rick
