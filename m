From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 17:07:44 +0100
Message-ID: <20090629160744.GA11523@n2100.arm.linux.org.uk>
References: <200906291631.19562.jpihet@mvista.com> <20090629151931.GA9042@n2100.arm.linux.org.uk> <200906291735.38290.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52765 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZF2QIW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 12:08:22 -0400
Content-Disposition: inline
In-Reply-To: <200906291735.38290.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, oprofile-list@lists.sourceforge.net

On Mon, Jun 29, 2009 at 05:35:37PM +0200, Jean Pihet wrote:
> On Monday 29 June 2009 17:19:31 Russell King - ARM Linux wrote:
> > It's one of these things that nests itself - when you have several IRQs
> > being processed on one CPU, there are several register contexts saved,
> > and get_irq_regs() returns the most recent one.
> >
> > > The use case is that the performance unit (PMNC) of the Cortex A8 has
> > > some serious bug, in short the performance counters overflow IRQ is to be
> > > avoided.
> >
> > I don't follow.  None of the PMNC support code in the mainline kernel
> > uses get_irq_regs() outside of IRQ context.
>
> That is correct. The Cortex A8 needs some special treatment.
> The errata says that if the counters are overflowing at the same time as a 
> coprocessor access is performed, the perf unit gets reset and/or locks up. In 
> short the counters overflow is to be avoided and so the PMNC IRQ.

Are you talking about 628216?
