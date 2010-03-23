From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
Date: Tue, 23 Mar 2010 00:16:12 +0000
Message-ID: <20100323001612.GA8190@n2100.arm.linux.org.uk>
References: <20100317175731.GE2900@atomide.com> <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com> <20100317191114.GH2900@atomide.com> <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com> <20100318170021.GN2900@atomide.com> <20100319013521.GP2900@atomide.com> <20100319085317.GA8451@n2100.arm.linux.org.uk> <20100319155805.GS2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33703 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab0CWAQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 20:16:26 -0400
Content-Disposition: inline
In-Reply-To: <20100319155805.GS2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 19, 2010 at 08:58:05AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100319 01:49]:
> > On Thu, Mar 18, 2010 at 06:35:21PM -0700, Tony Lindgren wrote:
> > > -#if defined(CONFIG_HAS_TLS_REG)
> > > -	mcr	p15, 0, r3, c13, c0, 3		@ set TLS register
> > > -#elif !defined(CONFIG_TLS_REG_EMUL)
> > > -	mov	r4, #0xffff0fff
> > > -	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
> > > +#if !defined(CONFIG_TLS_REG_EMUL)
> > > +	ldr	r4, =elf_hwcap
> > > +	ldr	r4, [r4, #0]
> > > +	tst	r4, #HWCAP_TLS			@ hardware with TLS?
> > 
> > This is really really inefficient.  Both the second ldr and tst will stall
> > the pipeline because they need to wait for the result of the precending
> > ldr.  Can we do better by re-ordering some instructions?
> 
> Or set ifdef CONFIG_CPU_V6 and test for the cp15 id register every time..

I was suggesting that it might be worth trying to reorder the instructions
here so that we're not immediately using the result of the ldr in the
next instruction.  We have plenty of registers available here (everything
except r0-r2, r6, fp.)

> > Also, the ifndef seems incorrect - if we have TLS_REG_EMUL we seem to omit
> > all this code.
> 
> Is the current ifdef elif wrong? The current code does not seem to
> do anything if TLS_REG_EMUL is set and HAS_TLS_REG is not set.
> HAS_TLS_REG depends !TLS_REG_EMUL.

Now I look back, I don't think so.  Ignore that comment.
