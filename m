From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Thu, 13 Dec 2012 15:39:57 +0100
Message-ID: <50C9E8BD.1020501@ti.com>
References: <20120919134658.GA2111@linaro.org> <20120920102514.GD4588@e102568-lin.cambridge.arm.com> <20120920110439.GB2117@linaro.org> <Pine.LNX.4.64.1212111655050.29758@axis700.grange> <20121211163313.GG16759@mudshark.cambridge.arm.com> <20121211163843.GH16759@mudshark.cambridge.arm.com> <50C7C16B.7050106@codeaurora.org> <20121212103338.GB23022@e102568-lin.cambridge.arm.com> <20121212133650.GJ6195@mudshark.cambridge.arm.com> <Pine.LNX.4.64.1212130909190.18586@axis700.grange> <20121213105109.GB26540@mudshark.cambridge.arm.com> <Pine.LNX.4.64.1212131522430.18586@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1212131522430.18586@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 13 December 2012 03:32 PM, Guennadi Liakhovetski wrote:
> On Thu, 13 Dec 2012, Will Deacon wrote:
>
>> On Thu, Dec 13, 2012 at 08:09:33AM +0000, Guennadi Liakhovetski wrote:
>>> On Wed, 12 Dec 2012, Will Deacon wrote:
>>>> Back to the case in hand.... Lorenzo just pointed out to me that the
>>>> finished in question (sh7372_do_idle_sysc) calls v7_flush_dcache_all, so
>>>> the louis stuff should be irrelevant. The problem may actually be that the
>>>> finisher disables the L2 cache prior to cleaning/invalidating it, which is
>>>> the opposite order to that described by the A8 TRM.
>>>>
>>>> Guennadi -- can you try moving the kernel_flush call before the L2 disable
>>>> in sh7372_do_idle_sysc please?
>>>
>>> Yes, this works too.
>>
>> That's good to know. Please can you send a patch for that? The sequence
>> currently being used by the finisher *is* buggy, and should be fixed
>> independently of the louis stuff.
>
> Well, the fix is yours, so, it should be "From: you." I can certainly send
> it just copying your description above, but I'd also need your Sob.
> Something like the below (feel free to improve the subject line and the
> description):
>
> From: Will Deacon <will.deacon@arm.com>
> Subject: [PATCH] ARM: sh7372: fix cache clean / invalidate order
>
> According to the Cortex A8 TRM the L2 cache should be first cleaned and
> then disabled. Fix the swapped order on sh7372.
>
> Signed-off-by: <you>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> (or even just)
> Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> diff --git a/arch/arm/mach-shmobile/sleep-sh7372.S b/arch/arm/mach-shmobile/sleep-sh7372.S
> index 1d56467..df15d8a 100644
> --- a/arch/arm/mach-shmobile/sleep-sh7372.S
> +++ b/arch/arm/mach-shmobile/sleep-sh7372.S
> @@ -59,16 +59,16 @@ sh7372_do_idle_sysc:
>   	mcr	p15, 0, r0, c1, c0, 0
>   	isb
>
> -	/* disable L2 cache in the aux control register */
> -	mrc     p15, 0, r10, c1, c0, 1
> -	bic     r10, r10, #2
> -	mcr     p15, 0, r10, c1, c0, 1
> -
>   	/*
>   	 * Invalidate data cache again.
>   	 */
kernel_flush does "Clean and Invalidate"
>   	ldr	r1, kernel_flush
>   	blx	r1
> +
> +	/* disable L2 cache in the aux control register */
> +	mrc     p15, 0, r10, c1, c0, 1
> +	bic     r10, r10, #2
> +	mcr     p15, 0, r10, c1, c0, 1
An isb will be make it safe.

Otherwise patch looks good to me.
Feel free to add my review-by tag if you need one.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


