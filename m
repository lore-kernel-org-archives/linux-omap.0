From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
Date: Mon, 11 Oct 2010 09:25:35 +0100
Message-ID: <20101011082535.GA26355@n2100.arm.linux.org.uk>
References: <4B91A39F.8050502@am.sony.com> <20100306201849.GD13262@n2100.arm.linux.org.uk> <AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com> <20101009193757.GB28183@n2100.arm.linux.org.uk> <20101010220603.GA2723@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52589 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0JKI0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 04:26:42 -0400
Content-Disposition: inline
In-Reply-To: <20101010220603.GA2723@debian>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 11, 2010 at 03:36:03AM +0530, Rabin Vincent wrote:
> On Sat, Oct 09, 2010 at 08:37:57PM +0100, Russell King - ARM Linux wrote:
> > On Sat, Oct 09, 2010 at 11:20:50PM +0530, Rabin Vincent wrote:
> > > It's used just for the C entry functions for interrupts: asm_do_IRQ()
> > > and the IPI and local timer functions.
> > > 
> > > AFAICS __exception seems to be used only for is_exception_text().  If
> > > that's the case, would it be OK to just place those functions in
> > > __irq_entry if ftrace is built and have is_exception_text() check that
> > > section too?
> > 
> > No.  is_exception_text() is used to detect those functions which have
> > a specific stack layout - which is that there's a pt_regs struct on the
> > stack.  Grouping other functions into that violates the expectation.
> 
> I'm not sure I follow.  These functions (asm_do_IRQ(), do_IPI(), and
> do_local_timer()) will be the only ones in __irq_entry. iow, __irq_entry
> will contain nothing else except these functions.  So we woudn't be
> grouping other functions; it's just that some of the __exception
> functions would be moved to the new section so that __exception and
> __irq_entry combined will contain the functions with the specific stack
> layout (and only those functions).

And now to go back to the original question I asked: What is __irq_entry
used for?

If it's to identify those functions which can't be traced through because
of the stack layout, that's true of all __exception marked functions -
so we might as well make the linker symbols for irqentry alias the
exception text symbols.

I see nothing special of just the three functions you mention that warrant
them being handled separately by ftrace.
