From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
 asm/spinlock.h
Date: Wed, 26 Jan 2011 10:42:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101261023470.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
 <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
 <20110125165919.GD17286@n2100.arm.linux.org.uk>
 <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
 <20110125174636.GE17286@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1101251618230.8580@xanadu.home>
 <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:9219 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1AZPm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 10:42:59 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFM003S1ZMIAJ80@vl-mo-mrz23.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Wed, 26 Jan 2011 10:42:18 -0500 (EST)
In-reply-to: <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 26 Jan 2011, Dave Martin wrote:

> On Tue, Jan 25, 2011 at 9:21 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:
> >
> >> Hmm, actually it looks like you can end up with configurations where the
> >> spinlocks are inlined.
> >>
> >> That means we'll have to get rid of the link-time discarding of the
> >> .exit sections, and discard them along with the .init sections.
> >
> > ... but only when CONFIG_SMP_ON_UP=y.
> 
> Do we need to consider any other discarded sections?  In vmlinux.lds, I have:
> 
>  /* Default discards */
>  /DISCARD/ : { *(.exit.text) *(.cpuexit.text) *(.memexit.text)
> *(.exit.data) *(.cpuexit.data) *(.cpuexit.rodata) *(.memexit.data)
> *(.memexit.rodata) *(.exitcall.exit) *(.discard) *(.discard.*) }
> 
> 
> Alternatively, I wonder .alt.smp.init could make weak references
> instead of normal references: then if the referenced section is
> discarded, the reference will revert to 0 and the fixup code can
> ignore it (at the expense of wasting a bit of space in the fixup table
> ... but it's no worse than the current situation).  From
> experimentation, it seems this doesn't work if the referenced symbol
> is defined in the same file, since the linker resolves the reference
> before discarding sections, but maybe there's a way around it...

That's strange.  How can the linker resolve the reference if the 
referenced symbol is not in the same section as the reference source?  
What happens when the final link completes?


Nicolas
