From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
Date: Sat, 9 Oct 2010 20:37:57 +0100
Message-ID: <20101009193757.GB28183@n2100.arm.linux.org.uk>
References: <4B91A39F.8050502@am.sony.com> <20100306201849.GD13262@n2100.arm.linux.org.uk> <AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35470 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab0JITjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 15:39:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Oct 09, 2010 at 11:20:50PM +0530, Rabin Vincent wrote:
> On Sun, Mar 7, 2010 at 1:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 05, 2010 at 04:36:47PM -0800, Tim Bird wrote:
> >> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
> >> a compiler error on kernel/trace/trace_functions_graph.c),
> >> although no routines were marked as __irq_entry.
> >
> > Well, ARM already places the assembly exception text in its own sep=
arate
> > section for other reasons. =A0We can't place it in two sections.
> >
> > What is __irq_entry used for? =A0Just the low level assembly or C f=
unctions?
>=20
> It's used just for the C entry functions for interrupts: asm_do_IRQ()
> and the IPI and local timer functions.
>=20
> AFAICS __exception seems to be used only for is_exception_text().  If
> that's the case, would it be OK to just place those functions in
> __irq_entry if ftrace is built and have is_exception_text() check tha=
t
> section too?

No.  is_exception_text() is used to detect those functions which have
a specific stack layout - which is that there's a pt_regs struct on the
stack.  Grouping other functions into that violates the expectation.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
