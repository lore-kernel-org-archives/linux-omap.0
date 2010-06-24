From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
Date: Thu, 24 Jun 2010 01:28:53 +0100
Message-ID: <20100624002853.GJ7058@shareable.org>
References: <20100621133749.24299.36154.stgit@baageli.muru.com> <20100621135120.24299.98499.stgit@baageli.muru.com> <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com> <20100623133636.GC7058@shareable.org> <alpine.LFD.2.00.1006231002530.24097@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:42514 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0FXA2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 20:28:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006231002530.24097@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nicolas Pitre wrote:
> On Wed, 23 Jun 2010, Jamie Lokier wrote:
> 
> > For other things like __switch_to and maybe cache maintenance calls,
> > dmb() etc, I'd suggest first doing a generic asm mechanism like x86's
> > "alternatives", keeping in mind that one of the alternatives has to be
> > XIP friendly.
> 
> You cannot be XIP friendly unless you rewrite the concerned function(s) 
> into a RAM page in order to modify it.  And then of course you have to 
> play tricks with the linker so that the rewritten functions are 
> referenced with their final rewritten location.  And that means of 
> course that the RAM location has to be a constant unless we introduce 
> some indirect function calls.  And at that point we're not much better 
> than the proposed runtime test.
> 
> Also, if you are interested by a XIP kernel, this usually means you have 
> a fairly highly customized kernel config.  In this context it is 
> senseless to have runtime patching of the kernel.  What you want in that 
> case is as much stuff as possible selected and optimized at compile 
> time, and anything you don't need configured out.

I wasn't suggesting that XIP kernels do any run-time npatching.
Sorry, I thought that was obvious.

What I mean is to provide a set of macros, a bit like x86's
alternatives macros, which take various asm fragments and the
condition which would choose between them, and compiles to
unconditional code if the condition is known at compile time (XIP or
not), otherwise compiles to fixed, run-time conditional code on XIP
(it could be conditional code or an indirect functional call), and on
non-XIP compiles to patchable code with an alternate-table section.

-- Jamie
