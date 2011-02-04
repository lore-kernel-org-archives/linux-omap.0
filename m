From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for DEBUG_LL
Date: Fri, 04 Feb 2011 15:33:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102041529250.12104@xanadu.home>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
 <20110204012709.26410.78100.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
 <20110204170249.GV3322@atomide.com>
 <alpine.LFD.2.00.1102041445360.12104@xanadu.home>
 <20110204202411.GA20795@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:60657 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1BDUdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 15:33:52 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG4005T8142F0E0@VL-MR-MRZ20.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 04 Feb 2011 15:33:38 -0500 (EST)
In-reply-to: <20110204202411.GA20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, 4 Feb 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [110204 12:14]:
> > 
> > Just create a get_config_ptr macro or similar and the trickery will be 
> > nicely encapsulated.  You'd have:
> > 
> > 	.macro get_config_ptr ptr, tmp
> > 	b	9002f
> > 	.align
> > 9001:	.long	.
> > 	.long	uart_param_storage
> > 9002:	adr	\ptr, 9001b
> > 	ldr	\tmp, [\ptr]
> > 	sub	\tmp, \tmp, \ptr
> > 	ldr	\ptr, [\ptr, #4]
> > 	sub	\ptr, \ptr, \tmp
> > 	.endm
> > 
> > 	.macro addruart rp, rv
> > 	get_config_ptr \rv
> > 	ldr	\rp, [\rv]
> > 	ldr	\rv, [\rv, #4]
> > 	.endm
> > 
> > And for the other macros, you get the hardware address to use already, 
> > but you can still use get_config_ptr for extra config values you 
> > need if necessary.
> 
> Thanks, will try that out next week. That might run into problems with
> busyuart as it only has rd register to play with.

With some code auditing we could declare ip as being callee clobberable 
with those macros.


Nicolas
