From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Wed, 30 Jun 2010 10:42:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006301011520.24097@xanadu.home>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
 <20100621135120.24299.98499.stgit@baageli.muru.com>
 <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com>
 <20100623133636.GC7058@shareable.org> <20100629141836.GM2822@atomide.com>
 <alpine.LFD.2.00.1006291355520.24097@xanadu.home>
 <20100630110828.GZ2822@atomide.com> <20100630131737.GF2822@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:10971 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab0F3OmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 10:42:20 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L4U00HWK0UIL480@VL-MR-MR002.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Wed, 30 Jun 2010 10:42:19 -0400 (EDT)
In-reply-to: <20100630131737.GF2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 30 Jun 2010, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [100630 14:02]:
> > * Nicolas Pitre <nico@fluxnic.net> [100629 22:14]:
> > 
> > Updated patch below.
> 
> And a bug crept in..
> 
> > +	.macro set_tls_v6, tp, tmp1, tmp2
> > +	ldr	\tmp1, =elf_hwcap
> > +	ldr	\tmp1, [\tmp1, #0]
> > +	mov	\tmp2, #0xffff0fff
> > +	tst	\tmp2, #HWCAP_TLS		@ hardware TLS available?
> > +	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
> > +	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
> > +	.endm
> 
> The tst	\tmp2, #HWCAP_TLS should of course use \tmp1.
> 
> Also fixed a warning about adding parentheses around comparison
> if (id & 0x410f0000) != 0x41070000).

Here you probably want (id & 0xff0f0000) and not (id & 0x410f0000).

> Again, updated patch below.

I like it.  However, in proc-v6.S, you don't need to add a reference to 
feat_v6_fixup() to the __pj4_v6_proc_info block.  Simply adding 
HWCAP_TLS in that case should be fine as PJ4 always has the TLS reg.

With the above fixes, you can add

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
