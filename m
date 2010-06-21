From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Mon, 21 Jun 2010 18:49:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032358ED1B@dbde02.ent.ti.com>
References: <1277151798-26232-1-git-send-email-tarun.kanti@ti.com>
 <4C1F429E.40107@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032358ECE4@dbde02.ent.ti.com>
 <4C1F618E.4090700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51526 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0FUNTT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 09:19:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5LDJGZB001577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 08:19:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5LDJF16005668
	for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 18:49:16 +0530 (IST)
In-Reply-To: <4C1F618E.4090700@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>


> -----Original Message-----
> From: Menon, Nishanth
> Sent: Monday, June 21, 2010 6:27 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; R, Sricharan
> Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
> 
> DebBarma, Tarun Kanti had written, on 06/21/2010 07:51 AM, the following:
> > Nishant,
> >
> >> -----Original Message-----
> >> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
> >> Sent: Monday, June 21, 2010 4:15 PM
> >> To: DebBarma, Tarun Kanti
> >> Cc: linux-omap@vger.kernel.org; R, Sricharan
> >> Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
> >>
> >> NAK - my prev comments are not fixed here either.
> >>
> >> On 06/21/2010 03:23 PM, Tarun Kanti DebBarma wrote:
> >>> Generation of 1ms granular GPTIMER events using 32KHz or system
> >>> clocks as inputs does not have whole number count value to load
> >>> into the register. This inaccurate count value with respect to 1ms
> >>> period leads to time drift subsequently. OMAP3 and later silicons
> >>> have dedicated registers for GPTIMER1, GPTIMER2 and GPTIMER10,
> >>> which can be programmed with computed values to keep this error
> >>> controlled within specified limit.
> >>>
> >>> Version 2:
> >> move this to diffstat section please.
> >>> (i) optimized omap_dm_timer_ms_correction() function and corrected
> >>> error in computing the positive and negative increments.
> >>> (ii) typo corrections in comment section and warning removal related
> >>> to 80-character limit
> >>>
> >>> Tested on Zoom3 using Linus tree.
> >>>
> >>> Signed-off-by: R Sricharan<r.sricharan@ti.com>
> >>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> >>> ---
> >>>   arch/arm/plat-omap/dmtimer.c              |  131
> >> +++++++++++++++++++++--------
> >>>   arch/arm/plat-omap/include/plat/dmtimer.h |    1 +
> >>>   2 files changed, 96 insertions(+), 36 deletions(-)
> >>>
> >>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
> omap/dmtimer.c
> >>> index c64875f..42344a7
> >>> --- a/arch/arm/plat-omap/dmtimer.c
> >>> +++ b/arch/arm/plat-omap/dmtimer.c
> >>> @@ -160,6 +160,9 @@ struct omap_dm_timer {
> >>>   	unsigned reserved:1;
> >>>   	unsigned enabled:1;
> >>>   	unsigned posted:1;
> >>> +#ifdef CONFIG_ARCH_OMAP2PLUS
> >>> +	unsigned ms_correction:1;
> >>> +#endif
> >>>   };
> >>>
> >>>   static int dm_timer_count;
> >>> @@ -185,18 +188,30 @@ static const int omap1_dm_timer_count =
> >> ARRAY_SIZE(omap1_dm_timers);
> >>>   #ifdef CONFIG_ARCH_OMAP2
> >>>   static struct omap_dm_timer omap2_dm_timers[] = {
> >>> -	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
> >>> -	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
> >>> -	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
> >>> -	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
> >>> -	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
> >>> -	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
> >>> -	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
> >>> -	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
> >>> -	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
> >>> -	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> >>> -	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> >>> -	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
> >>> +	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12,
> >>> +						.ms_correction = 0 },
> >> ignore of previous comments on .ms_correction initialization.
> >> try the output of the following code:
> >> struct b {
> >>          unsigned char z:1;
> >>          unsigned char a:1;
> >> };
> >>
> >> static struct b b1[2]={
> >>          {.z =1},
> >>          {.a = 1},
> >> };
> >>
> >> unsigned int main()
> >> {
> >>          int i;
> >>          for (i=0; i<2; i++)
> >>          printf("%d: %d %d\n", i, b1[i].z, b1[i].a);
> >> }
> > This comment is not clear to me.
> > Are you suggesting to make the initialization of ms_correction variable
> > in a separate function instead of doing the present way?
> 
> no. my suggestion is this:
> you dont need to do .ms_correction = 0
> when the variable is static - by C standards static variables are
> initialized to 0. so, .ms_correction = 1 alone is needed in the specific
> GPTimer cases where this is needed.
> 
> the example i posted shows that it works :).
> 
OK.
But in this case I have to re-design / re-structure the other bit fields
Viz. reserved, enabled, posted. Then we have to decide what to name the structure, etc. If you feel this is the right direction then I can go ahead.

> >
> >>>   };
> >>>
> >>>   static const char *omap2_dm_source_names[] __initdata = {
> >>> @@ -218,18 +233,30 @@ static const int omap2_dm_timer_count =
> >> ARRAY_SIZE(omap2_dm_timers);
> >>>   #ifdef CONFIG_ARCH_OMAP3
> >>>   static struct omap_dm_timer omap3_dm_timers[] = {
> >>> -	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
> >>> -	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
> >>> -	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
> >>> -	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
> >>> -	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
> >>> -	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
> >>> -	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
> >>> -	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
> >>> -	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
> >>> -	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> >>> -	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> >>> -	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
> >>> +	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1,
> >>> +						.ms_correction = 1 },
> >>> +	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2,
> >>> +						.ms_correction = 1 },
> >>> +	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4903E001, .irq = INT_24XX_GPTIMER8,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10,
> >>> +						.ms_correction = 1 },
> >>> +	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ,
> >>> +
> >> NAK
> > Will be taken care.
> >> 					.ms_correction = 0 },
> >>>   };
> >>>
> >>>   static const char *omap3_dm_source_names[] __initdata = {
> >>> @@ -250,18 +277,30 @@ static const int omap3_dm_timer_count =
> >> ARRAY_SIZE(omap3_dm_timers);
> >>>   #ifdef CONFIG_ARCH_OMAP4
> >>>   static struct omap_dm_timer omap4_dm_timers[] = {
> >>> -	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
> >>> -	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
> >>> -	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
> >>> -	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
> >>> -	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
> >>> -	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
> >>> -	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
> >>> -	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
> >>> -	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
> >>> -	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
> >>> -	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
> >>> -	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
> >>> +	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1,
> >>> +						.ms_correction = 1 },
> >>> +	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2,
> >>> +						.ms_correction = 1 },
> >>> +	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10,
> >>> +						.ms_correction = 1 },
> >>> +	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11,
> >>> +						.ms_correction = 0 },
> >>> +	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12,
> >>> +
> >> 						.ms_correction = 0 },
> >> NAK
> > Will be taken care.
> >>>   };
> >>>   static const char *omap4_dm_source_names[] __initdata = {
> >>>   	"sys_clkin_ck",
> >>> @@ -612,6 +651,10 @@ void omap_dm_timer_set_load_start(struct
> >> omap_dm_timer *timer, int autoreload,
> >>>   {
> >>>   	u32 l;
> >>>
> >>> +#ifdef CONFIG_ARCH_OMAP2PLUS
> >>> +	if (timer->ms_correction)
> >>> +		omap_dm_timer_ms_correction(timer, load);
> >>> +#endif
> >>>   	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> >>>   	if (autoreload) {
> >>>   		l |= OMAP_TIMER_CTRL_AR;
> >>> @@ -733,6 +776,22 @@ int omap_dm_timers_active(void)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(omap_dm_timers_active);
> >>>
> >>> +/**
> >>> + * omap_dm_timer_ms_correction - hardware correction for millisecond
> >> timer
> >>> + * @timer: GPTIMER on which the correction support is to be applied
> >>> + * @load: timer load value, used here to extract the expiry count
> >>> + */
> >>> +void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, u32
> load)
> >> does this function need to be exposed to the world? why?
> >> omap_dm_timer_set_load_start seems to automatically use it. and
> >> omap_dm_timer_set_load_start is private within dmtimer.c
> > This will be changed to static void omap_dm_timer_ms_correction (...)
> >
> >>> +{
> >>> +	int pos_increment, neg_increment;
> >>> +	unsigned int count = (0xFFFFFFFF - load)*1024;
> >>> +
> >>> +	pos_increment = (((count/1000)+1)*1000000) - (count*1000);
> >>> +	neg_increment = ((count/1000)*1000000) - (count*1000);
> >> NAK. comments from last time not fixed! - fix check patch AND use
> >> kernel.h ROUND functions.
> > I did not quite understand the comment.
> > With regard to using round() macro in kernel.h is there any advantage?
> 
> yes, ROUND macros are safe from a perspective of overflow and truncation
> - further this is a standard mechanism used elsewhere in the kernel. so
> why define your own macros?
> 
> Also scripts/checkpatch.pl --strict has not been run on this patch, you
> definitely need space between operators such as / and * ..
> 
Unfortunately "scripts/checkpatch.pl --strict" did not give me this error/warning. Anyways, I will incorporate this.

> >
> >>> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_POS_REG,
> >> pos_increment);
> >>> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_NEG_REG,
> >> neg_increment);
> >>> +}
> >>> +
> >>>   int __init omap_dm_timer_init(void)
> >>>   {
> >>>   	struct omap_dm_timer *timer;
> >>> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h
> b/arch/arm/plat-
> >> omap/include/plat/dmtimer.h
> >>> index 20f1054..ad37bcc 100644
> >>> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> >>> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> >>> @@ -80,5 +80,6 @@ void omap_dm_timer_write_counter(struct
> omap_dm_timer
> >> *timer, unsigned int value
> >>>   int omap_dm_timers_active(void);
> >>>
> >>> +void omap_dm_timer_ms_correction(struct omap_dm_timer *timer, u32
> >> load);
> >> as mentioned offline: why does this function need to be exposed to the
> >> world?
> > This will be removed.
> >>>   #endif /* __ASM_ARCH_DMTIMER_H */
> >>
> >> Regards,
> >> Nishanth Menon
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> Regards,
> Nishanth Menon
