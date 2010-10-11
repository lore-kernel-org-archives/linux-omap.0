From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
Date: Mon, 11 Oct 2010 22:45:55 +0530
Message-ID: <AANLkTi=33EUPFLzTr3zRHL1+CEm7JpqU18cFzzmpbAsG@mail.gmail.com>
References: <4B91A39F.8050502@am.sony.com>
	<20100306201849.GD13262@n2100.arm.linux.org.uk>
	<AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
	<20101009193757.GB28183@n2100.arm.linux.org.uk>
	<20101010220603.GA2723@debian>
	<20101011082535.GA26355@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45578 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab0JKRP5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 13:15:57 -0400
Received: by wye20 with SMTP id 20so636172wye.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 10:15:56 -0700 (PDT)
In-Reply-To: <20101011082535.GA26355@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 11, 2010 at 1:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> And now to go back to the original question I asked: What is __irq_entry
> used for?

It's used to identify when we're inside the interrupt handling path.
Depending upon the tracing options ("funcgraph-irqs"), this can be
excluded from the trace output.

> If it's to identify those functions which can't be traced through because
> of the stack layout, that's true of all __exception marked functions -
> so we might as well make the linker symbols for irqentry alias the
> exception text symbols.
>
> I see nothing special of just the three functions you mention that warrant
> them being handled separately by ftrace.

See above.  The funcgraph-irqs option is supposed to only affect the
interrupt handling path, not all exception handling.
