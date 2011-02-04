From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for
 DEBUG_LL
Date: Fri, 4 Feb 2011 12:24:11 -0800
Message-ID: <20110204202411.GA20795@atomide.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
 <20110204012709.26410.78100.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
 <20110204170249.GV3322@atomide.com>
 <alpine.LFD.2.00.1102041445360.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13577 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1BDUYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 15:24:37 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102041445360.12104@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [110204 12:14]:
> 
> Just create a get_config_ptr macro or similar and the trickery will be 
> nicely encapsulated.  You'd have:
> 
> 	.macro get_config_ptr ptr, tmp
> 	b	9002f
> 	.align
> 9001:	.long	.
> 	.long	uart_param_storage
> 9002:	adr	\ptr, 9001b
> 	ldr	\tmp, [\ptr]
> 	sub	\tmp, \tmp, \ptr
> 	ldr	\ptr, [\ptr, #4]
> 	sub	\ptr, \ptr, \tmp
> 	.endm
> 
> 	.macro addruart rp, rv
> 	get_config_ptr \rv
> 	ldr	\rp, [\rv]
> 	ldr	\rv, [\rv, #4]
> 	.endm
> 
> And for the other macros, you get the hardware address to use already, 
> but you can still use get_config_ptr for extra config values you 
> need if necessary.

Thanks, will try that out next week. That might run into problems with
busyuart as it only has rd register to play with.
 
> > In that case the mapping of IO space for the serial port in head.S
> > would have to be changed as that relies on rx containing the port
> > IO address..
> 
> Yes, and I'm not sure if it is worth changing that at this point when it 
> is possible to do it without introducing such a change which would 
> affect all machines again.

Agreed, let's see how far we can get with the existing setup.

What might need to be done is to save and restore rx in
busyuart to be able to use your macro above.

Tony
