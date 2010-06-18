From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH]OMAP:GPTIMER:1ms tick generation correction
Date: Fri, 18 Jun 2010 08:21:46 -0500
Message-ID: <4C1B72EA.3010100@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB032358E75F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59069 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758285Ab0FRNVr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jun 2010 09:21:47 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5IDLltH010008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 08:21:47 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5IDLkeG017010
	for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 08:21:46 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5IDLks4029556
	for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 08:21:46 -0500 (CDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032358E75F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

DebBarma, Tarun Kanti had written, on 06/18/2010 07:17 AM, the following:
> Generation of 1ms granular GPTIMER events using 32KHz or system clocks
> as inputs does not have whole number count value to loaded into the register. This inaccurate count value with respect to 1ms period leads to time drift subsequently. OMAP3 and later silicones have dedicated registers for GPTIMER1, GPTIMER2 and GPTIMER10, which can be programmed with computed values to keep this error controlled within specified limit.

I could go on and on on the evils of >70 character emails and worst of 
all >70 character commit messages :). but it will suffice to say "please 
fix ur editor for keeping your commit messages <70 chars.

I recommend reading:
http://omapedia.org/wiki/Releasing_to_Linux_kernel_using_patches_and_emails
esp:
http://userweb.kernel.org/~akpm/stuff/tpp.txt

also typos on silicone Vs silcon ;)

few suggestions below:
> 
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c              |   99 ++++++++++++++++++-----------
>  arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
>  2 files changed, 64 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> old mode 100644
> new mode 100755
> index c64875f..0d7d85a
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -160,6 +160,9 @@ struct omap_dm_timer {
>  	unsigned reserved:1;
>  	unsigned enabled:1;
>  	unsigned posted:1;
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +	unsigned ms_correction:1;
> +#endif
>  };
>  
>  static int dm_timer_count;
> @@ -185,18 +188,18 @@ static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
>  
>  #ifdef CONFIG_ARCH_OMAP2
>  static struct omap_dm_timer omap2_dm_timers[] = {
> -	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
> -	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
> -	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
> -	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
> -	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
> -	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
> -	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
> -	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
> -	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
> -	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> -	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
> +	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1, .ms_correction = 0 },
> +	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2, .ms_correction = 0 },
> +	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3, .ms_correction = 0 },
> +	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4, .ms_correction = 0 },
> +	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5, .ms_correction = 0 },
> +	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6, .ms_correction = 0 },
> +	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7, .ms_correction = 0 },
> +	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8, .ms_correction = 0 },
> +	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9, .ms_correction = 0 },
> +	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10, .ms_correction = 0 },
> +	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11, .ms_correction = 0 },
> +	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12, .ms_correction = 0 },

NAK -> static structs are default to 0 for fields you dont explicitly 
assign.

>  };
>  
>  static const char *omap2_dm_source_names[] __initdata = {
> @@ -218,18 +221,18 @@ static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
>  
>  #ifdef CONFIG_ARCH_OMAP3
>  static struct omap_dm_timer omap3_dm_timers[] = {
> -	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
> -	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
> -	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
> -	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
> -	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
> -	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
> -	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
> -	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
> -	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
> -	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> -	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
> +	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1, .ms_correction = 1 },
> +	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2, .ms_correction = 1 },
> +	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3, .ms_correction = 0 },
> +	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4, .ms_correction = 0 },
> +	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5, .ms_correction = 0 },
> +	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6, .ms_correction = 0 },
> +	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7, .ms_correction = 0 },
> +	{ .phys_base = 0x4903E001, .irq = INT_24XX_GPTIMER8, .ms_correction = 0 },
> +	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9, .ms_correction = 0 },
> +	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10, .ms_correction = 1 },
> +	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11, .ms_correction = 0 },
> +	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ, .ms_correction = 0 },
NAK -> static structs are default to 0 for fields you dont explicitly 
assign.
>  };
>  
>  static const char *omap3_dm_source_names[] __initdata = {
> @@ -250,18 +253,18 @@ static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
>  
>  #ifdef CONFIG_ARCH_OMAP4
>  static struct omap_dm_timer omap4_dm_timers[] = {
> -	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
> -	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
> -	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
> -	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
> -	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
> -	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
> -	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
> -	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
> -	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
> -	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
> -	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
> -	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
> +	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1, .ms_correction = 1 },
> +	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2, .ms_correction = 1 },
> +	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3, .ms_correction = 0 },
> +	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4, .ms_correction = 0 },
> +	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5, .ms_correction = 0 },
> +	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6, .ms_correction = 0 },
> +	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7, .ms_correction = 0 },
> +	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8, .ms_correction = 0 },
> +	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9, .ms_correction = 0 },
> +	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10, .ms_correction = 1 },
> +	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11, .ms_correction = 0 },
> +	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12, .ms_correction = 0 },
NAK -> static structs are default to 0 for fields you dont explicitly 
assign.
>  };
>  static const char *omap4_dm_source_names[] __initdata = {
>  	"sys_clkin_ck",
> @@ -612,6 +615,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
>  {
>  	u32 l;
>  
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +	if (timer->ms_correction) {
> +		omap_dm_timer_ms_correction(timer, load);
> +	}
> +#endif
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>  	if (autoreload) {
>  		l |= OMAP_TIMER_CTRL_AR;
> @@ -733,6 +741,25 @@ int omap_dm_timers_active(void)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timers_active);
>  
> +/**
> + * omap_dm_timer_ms_correction - hardware correction for millisecond timer
> + * @timer: GPTIMER on which the correction support is to be applied
> + * @load: timer load value, used here to extract the expiry count
> + */
> +void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, \
> +					unsigned int load)
> +{
> +	int pos_increment, neg_increment;
> +	u32 fclk, tick; /* fclk: functional clock in Hz, ticks: ms count */
> +
> +	fclk = clk_get_rate(omap_dm_timer_get_fclk(timer));
> +	tick = (0xFFFFFFFF - load)/(fclk/1024);
> +	pos_increment = ((((fclk*tick)/1000)+1)*1000000) - (fclk*tick*1000000);
> +	neg_increment = (((fclk*tick)/1000)*1000000) - (fclk*tick*1000000);
please fix checkpatch warnings and try to use the kernel.h ROUND macros 
instead.

> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_POS_REG, pos_increment);
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_NEG_REG, neg_increment);
> +}
> +
>  int __init omap_dm_timer_init(void)
>  {
>  	struct omap_dm_timer *timer;
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 20f1054..39ac1e7 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -80,5 +80,6 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value
>  
>  int omap_dm_timers_active(void);
>  
> +void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, unsigned int load);
>  
>  #endif /* __ASM_ARCH_DMTIMER_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Nishanth Menon
