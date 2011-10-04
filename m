From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 04 Oct 2011 19:20:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110041900590.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <20111003224411.GA19897@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
 <20111004225424.GA32102@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:55226 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933299Ab1JDXU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 19:20:58 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSK00GFSE1RG0E0@VL-VM-MR004.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 04 Oct 2011 19:17:51 -0400 (EDT)
In-reply-to: <20111004225424.GA32102@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 4 Oct 2011, Russell King - ARM Linux wrote:

> On Tue, Oct 04, 2011 at 05:10:36PM -0400, Nicolas Pitre wrote:
> > Which makes me think... with all those architectures intercepting 
> > ioremap calls in order to provide an equivalent static mapping address, 
> > they already get an unexpected domain given that static mappings are 
> > mostly DOMAIN_IO and not DOMAIN_KERNEL as would result from an non 
> > intercepted ioremap call.
> 
> That's a necessary evil - otherwise we have to separate out the
> ioremap from vmalloc.
> 
> Incidentally, how are you dealing with the problem of a static mapping
> setting up a L1 page table entry for DOMAIN_IO, and then a vmalloc
> request coming in, overlapping that L1 page table?
> 
> If this memory then gets accessed with get_user() with set_fs(get_ds()),
> the kernel will oops as we don't switch DOMAIN_IO memory on set_fs().
> (I don't know if this happens in practice, but there's nothing to say
> that it's illegal to do this.)

I suppose that didn't happen so far.  Granted, moving the ioremap 
optimization into core code for all machines will increase the 
possibility for this to happen, even if still small.

With CPU_USE_DOMAINS not set, set_fs() is a no-op anyway, besides 
addr_limit that is.

Is there a strong benefit in having static mappings being DOMAIN_IO 
instead of DOMAIN_KERNEL?


Nicolas
