From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Wed, 23 Jun 2010 10:19:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006231002530.24097@xanadu.home>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
 <20100621135120.24299.98499.stgit@baageli.muru.com>
 <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com>
 <20100623133636.GC7058@shareable.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:32752 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab0FWOTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 10:19:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L4H00K4X150QID0@VL-MO-MR004.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Wed, 23 Jun 2010 10:19:48 -0400 (EDT)
In-reply-to: <20100623133636.GC7058@shareable.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 23 Jun 2010, Jamie Lokier wrote:

> For other things like __switch_to and maybe cache maintenance calls,
> dmb() etc, I'd suggest first doing a generic asm mechanism like x86's
> "alternatives", keeping in mind that one of the alternatives has to be
> XIP friendly.

You cannot be XIP friendly unless you rewrite the concerned function(s) 
into a RAM page in order to modify it.  And then of course you have to 
play tricks with the linker so that the rewritten functions are 
referenced with their final rewritten location.  And that means of 
course that the RAM location has to be a constant unless we introduce 
some indirect function calls.  And at that point we're not much better 
than the proposed runtime test.

Also, if you are interested by a XIP kernel, this usually means you have 
a fairly highly customized kernel config.  In this context it is 
senseless to have runtime patching of the kernel.  What you want in that 
case is as much stuff as possible selected and optimized at compile 
time, and anything you don't need configured out.

So it would be best if dynamic function patching could be statically 
generated from the same source when XIP is active.


Nicolas
