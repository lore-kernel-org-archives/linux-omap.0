From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/3] Add OMAP hardware spinlock misc driver
Date: Mon, 18 Oct 2010 16:27:05 +0100
Message-ID: <tnxeibnh67q.fsf@e102109-lin.cambridge.arm.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
	<1287409417.29097.1598.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37831 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756763Ab0JRP1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Oct 2010 11:27:40 -0400
In-Reply-To: <1287409417.29097.1598.camel@twins> (Peter Zijlstra's message of
	"Mon, 18 Oct 2010 15:43:37 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, 2010-10-18 at 14:35 +0100, Russell King - ARM Linux wrote:
>> In any case, Linux's spinlock API (or more accurately, the ARM exclusive
>> access instructions) relies upon hardware coherency support (a piece of
>> hardware called an exclusive monitor) which isn't present on the M3 nor
>> DSP processors.  So there's no way to ensure that updates from the M3
>> and DSP are atomic wrt the A9 updates.
>
> Right, so the problem is that there simply is no way to do atomic memory
> access from these auxiliary processing units wrt the main CPU? Seeing as
> they operate on the same memory space, wouldn't it make sense to have
> them cache-coherent and thus provide atomicy guarantees through that?

With cache coherency you may get atomicity of writes or reads but
usually not atomic modifications.

-- 
Catalin
