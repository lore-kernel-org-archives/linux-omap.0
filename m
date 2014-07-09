From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Wed, 9 Jul 2014 10:06:59 -0400
Message-ID: <53BD4C83.7020700@ti.com>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com> <20140617131935.GB9070@saruman.home> <20140701194704.GG13396@saruman.home> <20140702081142.GU28884@atomide.com> <20140707104727.GM28884@atomide.com> <20140707104944.GS3705@n2100.arm.linux.org.uk> <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com> <20140707121512.GT3705@n2100.arm.linux.org.uk> <20140707123925.GW28884@atomide.com> <20140707134008.GU3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbaGIOH3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2014 10:07:29 -0400
In-Reply-To: <20140707134008.GU3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

On Monday 07 July 2014 09:40 AM, Russell King - ARM Linux wrote:
> On Mon, Jul 07, 2014 at 05:39:26AM -0700, Tony Lindgren wrote:
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140707 05:17]:
>>> On Mon, Jul 07, 2014 at 05:20:27PM +0530, Sekhar Nori wrote:
>>>> OMAP4430 had L2 cache controller version r2p0 (per the public TRM) which
>>>> does not have this register. So unless there is a ROM API that was
>>>> introduced after OMAP4430, this would not be there even for other
>>>> OMAP4s. Public TRM of OMAP4470 does not indicate an API for this.
>>>>
>>>> Before creating the patch, I checked with ROM team handling AM437x and
>>>> they denied an API to write to this register was present in AM437x ROM.
>>>
>>> Okay, so why are we trying to write to this register then...
>>>
>>> Ah, we have a bug in cache-l2x0.c:
>>>
>>> #define L2X0_CACHE_ID_PART_MASK         (0xf << 6)
>>> #define L2X0_CACHE_ID_RTL_MASK          0x3f
>>> #define L310_CACHE_ID_RTL_R3P0          0x05
>>>
>>>         unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
>>>
>>>         if (rev >= L310_CACHE_ID_RTL_R2P0) {
>>> ...
>>>         if (rev >= L310_CACHE_ID_RTL_R3P0) {
>>>                 l2c_write_sec(L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN,
>>>                               base, L310_POWER_CTRL);
>>>
>>> So, because we're masking the wrong bits, we end up with these tests
>>> always succeeding.
>>>
>>> So that's a NACK for the original patch, it's the wrong fix.  The
>>> right fix is to avoid writing this register by fixing the RTL masking.
>>
>> Okie dokie, dropping the omap specific fix.
> 
> Here's the revision mask fix - with the existing code, the revision checks
> are all useless since they would all pass irrespective of the actual
> revision.  (Had the L2C series been better tested rather than being largely
> ignored, this may have been noticed before it was merged...)  Anyway, what
> isn't clear from Sekhar's message is which revision L2C310 is in the AM437x.
> 
Sorry for joining late on the thread. Yes the power control register API
isn't provided and write should be avoiding. 

> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Subject: [PATCH] ARM: l2c: fix revision checking
> 
> The revision checking in l2c310_enable() was not correct; we were
> masking the part number rather than the revision number.  Fix this
> to use the correct macro.
> 
> Fixes: 4374d64933b1 ("ARM: l2c: add automatic enable of early BRESP")
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Right. Feel free add my ack if you need one.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>  arch/arm/mm/cache-l2x0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 948f12cf6180..0b5068256baf 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, v
>  
>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
>  {
> -	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
> +	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_RTL_MASK;
>  	bool cortex_a9 = read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
>  
>  	if (rev >= L310_CACHE_ID_RTL_R2P0) {
> 

