From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 04 Oct 2011 17:10:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <20111003224411.GA19897@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:10527 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933618Ab1JDVKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 17:10:37 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSK00E9E8418X50@VL-VM-MR003.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 04 Oct 2011 17:09:37 -0400 (EDT)
In-reply-to: <20111003224411.GA19897@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 3 Oct 2011, Russell King - ARM Linux wrote:

> On Mon, Oct 03, 2011 at 06:09:57PM -0400, Nicolas Pitre wrote:
> > On Mon, 3 Oct 2011, Tony Lindgren wrote:
> > > Having the SRAM base address move around with different sizes also
> > > requires the SoC detection.. Otherwise we can end up mapping wrong
> > > size and end up trying to access secure SRAM that will hang the system.
> > > 
> > > The way to fix it is to move SRAM init happen much later so we don't
> > > have to map it early. I guess now we could use ioremap for SRAM,
> > > although we may not want device attributes for the executable code?
> > > Got any suggestions here on how we should map SRAM later on?
> > 
> > You can use a variant of ioremap() such as __arm_ioremap() which let you 
> > specify the memory attribute.
> 
> Just be aware that __arm_ioremap() always ends up with stuff in the
> kernel domain, but that's not what you end up with using create_mapping().
> So I'd prefer it if you didn't suggest that __arm_ioremap() should be used
> with types not listed in asm/io.h.

Well, here we're talking about MT_MEMORY and MT_MEMORY_NONCACHED, and 
they are using DOMAIN_KERNEL already.  So no difference there.

Which makes me think... with all those architectures intercepting 
ioremap calls in order to provide an equivalent static mapping address, 
they already get an unexpected domain given that static mappings are 
mostly DOMAIN_IO and not DOMAIN_KERNEL as would result from an non 
intercepted ioremap call.


Nicolas
