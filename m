From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 3/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Mon, 12 Mar 2012 11:22:42 +0530
Message-ID: <4F5D8F2A.1070602@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-4-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203092051140.30879@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57872 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972Ab2CLFwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 01:52:49 -0400
Received: by mail-gy0-f174.google.com with SMTP id r11so2629534ghr.5
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 22:52:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203092051140.30879@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Saturday 10 March 2012 09:29 AM, Paul Walmsley wrote:
> Hi
>
> On Tue, 6 Mar 2012, Tero Kristo wrote:
>
>> From: Rajendra Nayak<rnayak@ti.com>
>>
>> IO daisychain is a mechanism that allows individual IO pads to generate
>> wakeup events on their own based on a switch of an input signal level.
>> This allows the hardware module behind the pad to be powered down, but
>> still have device level capability to detect IO events, and once this
>> happens the module can be powered back up to resume IO. See section
>> 3.9.4 in OMAP4430 Public TRM for details.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>
> Here's an updated version of this patch.  Please let me know if you think
> we should remove the poll on the WUCLKOUT line to conform with the change
> that Tero made to the OMAP3 version.

Thanks Paul, for the updates patch. Just one comment below..

>
>
> - Paul
>
> From: Rajendra Nayak<rnayak@ti.com>
> Date: Fri, 2 Mar 2012 17:17:52 +0200
> Subject: [PATCH 3/6] ARM: OMAP4: PRM: Add IO Daisychain support
>
> IO daisychain is a mechanism that allows individual IO pads to generate
> wakeup events on their own based on a switch of an input signal level.
> This allows the hardware module behind the pad to be powered down, but
> still have device level capability to detect IO events, and once this
> happens the module can be powered back up to resume IO. See section
> 3.9.4 in OMAP4430 Public TRM for details.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com> is just bad
documentation.

> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> [paul@pwsan.com: removed MAX_IOPAD_LATCH_TIME declaration; renamed

But the code below still seems to use it. Is it now defined in some
common header so the same value is used in omap3 and omap4?

regards,
Rajendra

>   omap4_trigger_io_chain() to conform to other PRM function names;
>   added kerneldoc]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/prm44xx.c |   48 +++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/prm44xx.h |    2 +
>   2 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index a1d6154..5868a12 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -231,6 +231,54 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
>   				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
>   }
>
> +/**
> + * omap44xx_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
> + *
> + * Clear any previously-latched I/O wakeup events and ensure that the
> + * I/O wakeup gates are aligned with the current mux settings.  Works
> + * by asserting WUCLKIN, waiting for WUCLKOUT to be asserted, and then
> + * deasserting WUCLKIN and waiting for WUCLKOUT to be deasserted.
> + * No return value. XXX Are the final two steps necessary?
> + */
> +void omap44xx_prm_reconfigure_io_chain(void)
> +{
> +	int i = 0;
> +
> +	/* Enable GLOBAL_WUEN */
> +	if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> +		OMAP4_PRM_IO_PMCTRL_OFFSET)&  OMAP4430_GLOBAL_WUEN_MASK))
> +		omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
> +			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET);
> +
> +	/* Trigger WUCLKIN enable */
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
> +			OMAP4430_WUCLK_CTRL_MASK, OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET);
> +	omap_test_timeout(
> +		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET)&
> +			OMAP4430_WUCLK_STATUS_MASK)>>
> +			OMAP4430_WUCLK_STATUS_SHIFT) == 1),
> +		MAX_IOPAD_LATCH_TIME, i);
> +	if (i == MAX_IOPAD_LATCH_TIME)
> +		pr_warn("PRM: I/O chain clock line assertion timed out\n");
> +
> +	/* Trigger WUCLKIN disable */
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, 0x0,
> +			OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET);
> +	omap_test_timeout(
> +		(((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
> +			OMAP4_PRM_IO_PMCTRL_OFFSET)&
> +			OMAP4430_WUCLK_STATUS_MASK)>>
> +			OMAP4430_WUCLK_STATUS_SHIFT) == 0),
> +		MAX_IOPAD_LATCH_TIME, i);
> +	if (i == MAX_IOPAD_LATCH_TIME)
> +		pr_warn("PRM: I/O chain clock line deassertion timed out\n");
> +
> +	return;
> +}
> +
>   static int __init omap4xxx_prcm_init(void)
>   {
>   	if (cpu_is_omap44xx())
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
> index 7978092..ee72ae6 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -763,6 +763,8 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
>   extern void omap4_prm_vcvp_write(u32 val, u8 offset);
>   extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
>
> +extern void omap44xx_prm_reconfigure_io_chain(void);
> +
>   /* PRM interrupt-related functions */
>   extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
>   extern void omap44xx_prm_ocp_barrier(void);

