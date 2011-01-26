From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
Date: Wed, 26 Jan 2011 15:52:03 +0000
Message-ID: <20110126155203.GA10141@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk> <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com> <20110125165919.GD17286@n2100.arm.linux.org.uk> <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com> <20110125174636.GE17286@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251618230.8580@xanadu.home> <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com> <alpine.LFD.2.00.1101261023470.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54147 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1AZPwR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 10:52:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101261023470.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 26, 2011 at 10:42:41AM -0500, Nicolas Pitre wrote:
> On Wed, 26 Jan 2011, Dave Martin wrote:
> > Alternatively, I wonder .alt.smp.init could make weak references
> > instead of normal references: then if the referenced section is
> > discarded, the reference will revert to 0 and the fixup code can
> > ignore it (at the expense of wasting a bit of space in the fixup table
> > ... but it's no worse than the current situation).  From
> > experimentation, it seems this doesn't work if the referenced symbol
> > is defined in the same file, since the linker resolves the reference
> > before discarding sections, but maybe there's a way around it...
> 
> That's strange.  How can the linker resolve the reference if the 
> referenced symbol is not in the same section as the reference source?  
> What happens when the final link completes?

$ cat t.s
	.section ".exit.text", "ax", %progbits
	mov	r0, r0
a:	mov	r0, r0

	.pushsection ".alt.smp.fixup", "a"
	.weak	a
	.long	a
	mov	r0, r1
	.popsection
$ arm-linux-as -o t.o t.s
$ arm-linux-nm t.o
00000004 W a
$ arm-linux-objdump -Dr t.o

Disassembly of section .exit.text:

00000000 <a-0x4>:
   0:	e1a00000 	nop			(mov r0,r0)

00000004 <a>:
   4:	e1a00000 	.word	0xe1a00000

Disassembly of section .alt.smp.fixup:

00000000 <.alt.smp.fixup>:
   0:	00000000 	.word	0x00000000
			0: R_ARM_ABS32	a
   4:	e1a00001 	mov	r0, r1

which when linked with:

SECTIONS
{
        .alt.smp.init : { *(.alt.smp.init) }

        /DISCARD/ : { *(.exit.text) }
}

$ arm-linux-ld -T t.lds -r -o t.oo t.o
`a' referenced in section `.alt.smp.fixup' of t.o: defined in discarded section `.exit.text' of t.o

So I don't think weak symbols work like we want them to.
