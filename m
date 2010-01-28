From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if ARCH_OMAP2 isnot selected
Date: Thu, 28 Jan 2010 18:33:03 +0000
Message-ID: <20100128183303.GA30029@shareable.org>
References: <20100126193748.15134.4837.stgit@baageli.muru.com> <1264676451.7064.40.camel@pc1117.cambridge.arm.com> <20100128174741.GN23505@atomide.com> <1264701931.7064.98.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:34280 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab0A1SdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 13:33:08 -0500
Content-Disposition: inline
In-Reply-To: <1264701931.7064.98.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Catalin Marinas wrote:
> > Hmm, but then we can't compile in SMP for single core systems and
> > keep it bootable on single core v6?
> 
> Not with the current kernel since it hardcodes the shareability bit in
> the page tables and the LDREX/STREX operations don't work as expected on
> uniprocessor hardware.

My understanding of LDREX/STREX is that it's allowed to be quite
different on uniprocessors (and CPU-local activity on SMP), but if
it's used properly it still works ok.

Can you say a bit more about assumptions made by the kernel using
LDREX/STREX that fail on uniprocessor hardware?

Is it just the shareability bit in page tables having the wrong value?

Thanks,
-- Jamie
