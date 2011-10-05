From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 04 Oct 2011 20:57:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110042048320.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <20111003224411.GA19897@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
 <20111004225424.GA32102@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1110041900590.9106@xanadu.home>
 <20111005004208.GW6324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:60759 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417Ab1JEA5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 20:57:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSK00GNXIJ7UPE0@VL-VM-MR004.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 04 Oct 2011 20:54:43 -0400 (EDT)
In-reply-to: <20111005004208.GW6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 4 Oct 2011, Tony Lindgren wrote:

> In any case, I suggest we add the following __arm_ioremap_exec patch
> and then sort out issues with it as they show up.
> 
> This allows further work on the common SRAM genalloc patches and generic
> map_io patches.
> 
> Nico, I already have a series converting omap2+ to use the the patch
> below, and it seems to be working just fine for SRAM. I'll post that
> series separately shortly. Maybe take a look and see if that allows
> you to do the generic map_io changes?

Yes, that looks fine.  Maybe you could avoid exporting the symbol until 
it is actually needed though.

The other thing I need is for the code using ioremap() such as in 
omap2_set_globals_control() to be called only after the corresponding 
static mappings are already installed.  Then everything should go 
smoothly.


Nicolas
