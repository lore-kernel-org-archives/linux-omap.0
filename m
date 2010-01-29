From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if
	ARCH_OMAP2 isnot selected
Date: Fri, 29 Jan 2010 10:38:59 +0000
Message-ID: <1264761539.4242.25.camel@pc1117.cambridge.arm.com>
References: <20100128183303.GA30029@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:61645 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754956Ab0A2KjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jan 2010 05:39:18 -0500
In-Reply-To: <20100128183303.GA30029@shareable.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2010-01-28 at 18:33 +0000, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > > Hmm, but then we can't compile in SMP for single core systems and
> > > keep it bootable on single core v6?
> >
> > Not with the current kernel since it hardcodes the shareability bit in
> > the page tables and the LDREX/STREX operations don't work as expected on
> > uniprocessor hardware.
> 
> My understanding of LDREX/STREX is that it's allowed to be quite
> different on uniprocessors (and CPU-local activity on SMP), but if
> it's used properly it still works ok.
> 
> Can you say a bit more about assumptions made by the kernel using
> LDREX/STREX that fail on uniprocessor hardware?
> 
> Is it just the shareability bit in page tables having the wrong value?

The kernel doesn't make any assumptions. It's the CPU that behaved
differently when the page was marked as shareable in a UP system. I
tried in the past and it looked like STREX was expecting some kind of
global exclusive monitor and it was always failing.

Anyway, it is possible that I don't recall correctly and it may have
been just an ARM11MPCore but with the SMP/nAMP mode disabled but the
STREX had already implemented with other expectations.

It's worth giving it a try though.

-- 
Catalin

