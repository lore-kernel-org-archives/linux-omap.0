From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP: irqs: Fix NR_IRQS value to handle PRCM interrupts
Date: Tue, 28 Feb 2012 21:32:28 +0100
Message-ID: <4F4D39DC.9020800@ti.com>
References: <4F4CD231.4030709@ti.com> <20120228143614.GA5627@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57798 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965025Ab2B1Uct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 15:32:49 -0500
In-Reply-To: <20120228143614.GA5627@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Russell,

On 2/28/2012 3:36 PM, Russell King - ARM Linux wrote:
> On Tue, Feb 28, 2012 at 02:10:09PM +0100, Cousson, Benoit wrote:
>> The following commit: 2f31b51659c2d8315ea2888ba5b93076febe672b
>> Author: Tero Kristo<t-kristo@ti.com>
>> Date:   Fri Dec 16 14:37:00 2011 -0700
>>
>>      ARM: OMAP4: PRM: use PRCM interrupt handler
>>
>> introduced the PRCM interrupt handler and thus the need
>> for 64 more interrupts. Since SPARSE_IRQ is still not fully
>> functional on OMAP, the NR_IRQS needs to be updated to avoid
>> the failure that happen during irq_alloc_descs call inside
>> the PRCM driver:
>>
>> [    0.208221] PRCM: failed to allocate irq descs: -12
>>
>> Later the mux framework is then unable to request an IRQ from
>> the PRCM interrupt handler.
>>
>> [    1.802795] mux: Failed to setup hwmod io irq -22
>
> This is fine for rc, but longer term...
>
> Do any of these have hard-coded interrupt numbers associated with them?
> If not, just enabling sparse IRQ will sort this out.

You're right, in that case, it does not depend on any hard-coded number.

> As I tried to explain yesterday, there are two modes for IRQ allocation:
>
> 1. Without sparse IRQ enabled, irq_alloc_descs(-1, from, num, -1) will
>     allocate IRQs _within_ the existing from..NR_IRQS range, and will fail
>     if there is insufficient IRQs available.
>
> 2. With sparse IRQs enabled, irq_alloc_descs(-1, from, num, -1) will
>     allocate IRQs starting at max(from, NR_IRQS) and working upwards.
>
> In either case, irq_alloc_descs(start, 0, num, -1) will allocate 'num'
> IRQs at 'start' or fail if the range is already in use (and 0..NR_IRQS
> is defined as 'being in use' when sparse IRQs are enabled.)
>
> So, if the PRCM interrupts aren't statically assigned (the code suggests
> that they aren't) then it's already sparse-IRQ compliant, and enabling
> sparse IRQ support will mean that they will be allocated above NR_IRQS.
>
> Therefore, I suggest rather than raising NR_IRQS, you instead enable
> SPARSE_IRQ now so that anyone using the dynamic IRQ allocation can
> benefit from sparse IRQ support without having to have a large NR_IRQS.
>
> So, you don't have to wait until everything is converted to use
> sparse IRQ.  You just need to make sure that nothing uses
> irq_alloc_descs(start, from, num, ...) where start<  NR_IRQS, and
> nothing using that requires statically defined IRQ numbering.

Yes, I fully agree, and that's still the plan. That's why I started 
sending last week a bunch of cleanup for SPARSE_IRQ support. 
Unfortunately, they might not be ready for 3.4 either, but I'm still 
working on it.

Meanwhile, we need the current temporary fix.

I can emphasis the temporary duration on that patch in the changelog if 
needed.

Thanks,
Benoit
