From: Jean Pihet <jpihet@mvista.com>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 17:35:37 +0200
Message-ID: <200906291735.38290.jpihet@mvista.com>
References: <200906291631.19562.jpihet@mvista.com> <20090629151931.GA9042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:10592 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbZF2Pfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 11:35:48 -0400
In-Reply-To: <20090629151931.GA9042@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, oprofile-list@lists.sourceforge.net

On Monday 29 June 2009 17:19:31 Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2009 at 04:31:18PM +0200, Jean Pihet wrote:
> > I am trying to get the latest IRQ registers from a timer or a work queue
> > but I am running into problems:
> > - get_irq_regs() returns NULL in some cases,
>
> It will always return NULL outside of IRQ context - and only returns valid
> pointers when used inside IRQ context.
Ok got it.

> It's one of these things that nests itself - when you have several IRQs
> being processed on one CPU, there are several register contexts saved,
> and get_irq_regs() returns the most recent one.
>
> > The use case is that the performance unit (PMNC) of the Cortex A8 has
> > some serious bug, in short the performance counters overflow IRQ is to be
> > avoided.
>
> I don't follow.  None of the PMNC support code in the mainline kernel
> uses get_irq_regs() outside of IRQ context.
That is correct. The Cortex A8 needs some special treatment.
The errata says that if the counters are overflowing at the same time as a 
coprocessor access is performed, the perf unit gets reset and/or locks up. In 
short the counters overflow is to be avoided and so the PMNC IRQ.

> > Some questions:
> > - is there a way to get the last 'real' IRQ registers from a timer or
> > work queue handler?
>
> No.  Outside of IRQ events, the saved IRQ context does not exist.
Ok. I wonder how to implement it correctly from here.
The ultimate goal is to feed the registers to oprofile for statistics 
gathering (mostly the PC). I do not see much benefit from oprofile without 
the PC statistics.

Thanks,
Jean
