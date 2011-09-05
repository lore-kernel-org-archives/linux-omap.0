From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
Date: Mon, 05 Sep 2011 19:43:24 +0530
Message-ID: <4E64D904.4050207@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com> <20110905140126.GA30520@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:43213 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752287Ab1IEONb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 10:13:31 -0400
Received: by mail-yi0-f49.google.com with SMTP id 13so3540056yic.8
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 07:13:30 -0700 (PDT)
In-Reply-To: <20110905140126.GA30520@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@ti.com" <khilman@ti.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday 05 September 2011 07:31 PM, Lorenzo Pieralisi wrote:
> Hi Santosh,
>
> just a question below.
>
> On Sun, Sep 04, 2011 at 02:54:21PM +0100, Santosh Shilimkar wrote:
>> When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
>> necessary maintenance operations and context restoration in the
>> low power code.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/mach-omap2/include/mach/omap-secure.h |    5 +
>>   arch/arm/mach-omap2/omap-mpuss-lowpower.c      |   38 +++++++++-
>>   arch/arm/mach-omap2/omap4-sar-layout.h         |    4 +
>>   arch/arm/mach-omap2/sleep44xx.S                |   96 ++++++++++++++++++++++++
>>   4 files changed, 142 insertions(+), 1 deletions(-)
>>
>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
>> index 230ab8c..a7cce0b 100644
>> --- a/arch/arm/mach-omap2/sleep44xx.S
>> +++ b/arch/arm/mach-omap2/sleep44xx.S
>> @@ -32,6 +32,9 @@
>>   ppa_zero_params:
>>   	.word		0x0
>>
>> +ppa_por_params:
>> +	.word		1, 0
>> +
>>   /*
>>    * =============================
>>    * == CPU suspend finisher ==
>> @@ -130,6 +133,55 @@ skip_scu_gp_set:
>>   	mcrne	p15, 0, r0, c1, c0, 1
>>   	isb
>>   	dsb
>> +#ifdef CONFIG_CACHE_L2X0
>> +	/*
>> +	 * Clean and invalidate the L2 cache.
>> +	 * Common cache-l2x0.c functions can't be used here since it
>> +	 * uses spinlocks. We are out of coherency here with data cache
>> +	 * disabled. The spinlock implementation uses exclusive load/store
>> +	 * instruction which can fail without data cache being enabled.
>> +	 * OMAP4 hardware doesn't support exclusive monitor which can
>> +	 * overcome exclusive access issue. Because of this, CPU can
>> +	 * lead to deadlock.
>> +	 */
>> +l2x_clean_inv:
>> +	bl	omap4_get_sar_ram_base
>> +	mov	r8, r0
>> +	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
>> +	ands	r5, r5, #0x0f
>> +	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]
>> +	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
>> +	cmp	r0, #3
>> +	bne	do_WFI
>> +#ifdef CONFIG_PL310_ERRATA_727915
>> +	mov	r0, #0x03
>> +	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
>> +	DO_SMC
>> +#endif
>> +	bl	omap4_get_l2cache_base
>> +	mov	r2, r0
>> +	ldr	r0, =0xffff
>> +	str	r0, [r2, #L2X0_CLEAN_INV_WAY]
>> +wait:
>> +	ldr	r0, [r2, #L2X0_CLEAN_INV_WAY]
>> +	ldr	r1, =0xffff
>> +	ands	r0, r0, r1
>> +	bne	wait
>> +#ifdef CONFIG_PL310_ERRATA_727915
>> +	mov	r0, #0x00
>> +	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
>> +	DO_SMC
>> +#endif
>> +l2x_sync:
>> +	bl	omap4_get_l2cache_base
>> +	mov	r2, r0
>> +	mov	r0, #0x0
>> +	str	r0, [r2, #L2X0_CACHE_SYNC]
>> +sync:
>> +	ldr	r0, [r2, #L2X0_CACHE_SYNC]
>> +	ands	r0, r0, #0x1
>> +	bne	sync
>> +#endif
>>
>
> If I am not mistaken, here the PL310 is still on. Is it
> safe to go to wfi (PL310 logic state is lost then ?) with the controller
> enabled ? You still use the stack and I think prefetch is enabled,
> do not know if you can end up having AXI bus transactions ongoing
> whilst HW yanks the power. To disable it I think you need a secure call,
> again it is just a question for my information.
>
PL310 is ON but C-bit is disabled. More over the Last sync will ensure
that all out-standing transactions are completed. So it should be
safe to go down. On OMAP, hardware waits for AXI transation complete
before CPU transitioning to low power, so that's not an issue.

For disabling, we need secure call. I didn't disable it because
we haven't seen any issue so far and AXI ack is already in
place.

Regards
Santosh
