From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 14 Feb 2011 15:10:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102141110500.14920@xanadu.home>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org> <87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com> <alpine.LFD.2.00.1102140950580.14920@xanadu.home> <20110214153726.GA20144@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62061 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1BNU1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 15:27:03 -0500
Received: by vws16 with SMTP id 16so3320227vws.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 12:27:02 -0800 (PST)
In-Reply-To: <20110214153726.GA20144@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

On Mon, 14 Feb 2011, Dave Martin wrote:

> On Mon, Feb 14, 2011 at 10:00:23AM -0500, Nicolas Pitre wrote:
> > > +#ifdef CONFIG_THUMB2_KERNEL
> > > +	.align
> > > +	bx	pc
> > > +	nop
> > > +	.arm
> > 
> > Also here, the .align has the potential to introduce a zero halfword in 
> > the instruction stream before the bx.  What about:
> > 
> > 	adr	r3, 1f
> > 	bx	r3
> > 	.align
> > 	.arm
> > 1:	...
> 
> .align inserts a 16-bit nop when misaligned in Thumb in a text section,

Ah, OK then.  I didn't know about that. In ARM mode the all-zero bits 
decode to an instruction that sort of does nothing, but this isn't an 
eleguant nop, and that's what .align (used to?) insert as padding.

> and a word-aligned bx pc is a specific architecturally allowed way
> to do an inline switch to ARM.  The linker uses this trick for PLT
> veneers etc.

Yep.  It's just that with my suggestion the bx wasn't necessarily 
aligned.

> A nicer fix for doing this sort of call from low-level code which
> might be ARM is to convert arch/arm/mm/*-v7.S to use "bx lr" to return.
> 
> Generally, we can do this for all arches >= v5, without any
> incompatibility.  However, since the need for it will be rare and it
> will generate patch noise for not much real benefit,
> I haven't proposed this.

This can be done in those places where this might be needed without 
having to convert them all.


Nicolas
