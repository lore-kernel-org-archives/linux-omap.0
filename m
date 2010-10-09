From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
Date: Sat, 9 Oct 2010 23:20:50 +0530
Message-ID: <AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
References: <4B91A39F.8050502@am.sony.com>
	<20100306201849.GD13262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59616 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab0JIRuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 13:50:52 -0400
Received: by wyb28 with SMTP id 28so1954889wyb.19
        for <linux-omap@vger.kernel.org>; Sat, 09 Oct 2010 10:50:51 -0700 (PDT)
In-Reply-To: <20100306201849.GD13262@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Mar 7, 2010 at 1:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 05, 2010 at 04:36:47PM -0800, Tim Bird wrote:
>> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
>> a compiler error on kernel/trace/trace_functions_graph.c),
>> although no routines were marked as __irq_entry.
>
> Well, ARM already places the assembly exception text in its own separ=
ate
> section for other reasons. =A0We can't place it in two sections.
>
> What is __irq_entry used for? =A0Just the low level assembly or C fun=
ctions?

It's used just for the C entry functions for interrupts: asm_do_IRQ()
and the IPI and local timer functions.

AFAICS __exception seems to be used only for is_exception_text().  If
that's the case, would it be OK to just place those functions in
__irq_entry if ftrace is built and have is_exception_text() check that
section too?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
