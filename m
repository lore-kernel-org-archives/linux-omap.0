From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 08/12] OMAP: dmtimer: do remaining initialization in probe
Date: Thu, 22 Sep 2011 11:35:38 +0530
Message-ID: <CAC83ZvKek=4CyMesouPEzJn+0Ytb23BbFzTaiZxH4=KKT_9mkA@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-9-git-send-email-tarun.kanti@ti.com>
	<20110922010005.GO2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:40711 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab1IVGFj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 02:05:39 -0400
Received: by mail-bw0-f44.google.com with SMTP id q10so2117235bka.3
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 23:05:38 -0700 (PDT)
In-Reply-To: <20110922010005.GO2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Sep 22, 2011 at 6:30 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> @@ -514,10 +514,23 @@ static int __devinit omap_dm_timer_probe(struc=
t platform_device *pdev)
>> =A0 =A0 =A0 timer->irq =3D irq->start;
>> =A0 =A0 =A0 timer->pdev =3D pdev;
>>
>> - =A0 =A0 /* Skip pm_runtime_enable for OMAP1 */
>> - =A0 =A0 if (!pdata->needs_manual_reset) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> +/*
>> + * sys_timer_reserved is not defined for OMAP1.
>> + * Use the macro to avoid compilation error on OMAP1.
>> + */
>> +#if defined(CONFIG_ARCH_OMAP2PLUS)
>> + =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>> + =A0 =A0 /* Mark clocksource and clockevent timers as reserved */
>> + =A0 =A0 if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 timer->reserved =3D 1;
>> +#endif
>> +
>> + =A0 =A0 if (!timer->reserved) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&pdev->dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_init_regs(timer);
>> + =A0 =A0 =A0 =A0 =A0 =A0 timer->tidr =3D __raw_readl(timer->io_base=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&pdev->dev);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* add the timer element to the list */
>
> This all should not be necessary. We can pass the reserved flag
> in pdata. Let's replace this one with the patch below.
Yes, this is much better organized.
--
Tarun
>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 21 Sep 2011 16:38:51 -0700
> Subject: [PATCH] ARM: OMAP: dmtimer: skip reserved timers
>
> Pass the reserved flag in pdata and use it. We can
> now make sys_timer_reserved static to mach-omap2/timer.c.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.=
c
> index 9c2f588..f1e3ec1 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -69,7 +69,7 @@
> =A0/* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
> =A0#define MAX_GPTIMER_ID =A0 =A0 =A0 =A0 12
>
> -u32 sys_timer_reserved;
> +static u32 sys_timer_reserved;
>
> =A0/* Clockevent code */
>
> @@ -463,6 +463,10 @@ static int __init omap_timer_init(struct omap_hw=
mod *oh, void *unused)
> =A0 =A0 =A0 =A0pdata->set_timer_src =3D omap2_dm_timer_set_src;
> =A0 =A0 =A0 =A0pdata->timer_ip_version =3D oh->class->rev;
>
> + =A0 =A0 =A0 /* Mark clocksource and clockevent timers as reserved *=
/
> + =A0 =A0 =A0 if ((sys_timer_reserved >> (id - 1)) & 0x1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->reserved =3D 1;
> +
> =A0 =A0 =A0 =A0od =3D omap_device_build(name, id, oh, pdata, sizeof(*=
pdata),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_dmtimer_latency,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap2_dmtim=
er_latency),
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index ac904c2..c8df3c3 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -509,6 +509,7 @@ static int __devinit omap_dm_timer_probe(struct p=
latform_device *pdev)
>
> =A0 =A0 =A0 =A0timer->id =3D pdev->id;
> =A0 =A0 =A0 =A0timer->irq =3D irq->start;
> + =A0 =A0 =A0 timer->reserved =3D pdata->reserved;
> =A0 =A0 =A0 =A0timer->pdev =3D pdev;
>
> =A0 =A0 =A0 =A0/* Skip pm_runtime_enable for OMAP1 */
> @@ -517,6 +518,12 @@ static int __devinit omap_dm_timer_probe(struct =
platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_irq_safe(&pdev->dev);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (!timer->reserved) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&pdev->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __omap_dm_timer_init_regs(timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&pdev->dev);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* add the timer element to the list */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&dm_timer_lock, flags);
> =A0 =A0 =A0 =A0list_add_tail(&timer->node, &omap_timer_list);
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/pla=
t-omap/include/plat/dmtimer.h
> index 4e3a326..29764c3 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -77,6 +77,7 @@ struct dmtimer_platform_data {
> =A0 =A0 =A0 =A0int (*set_timer_src)(struct platform_device *pdev, int=
 source);
> =A0 =A0 =A0 =A0int timer_ip_version;
> =A0 =A0 =A0 =A0u32 needs_manual_reset:1;
> + =A0 =A0 =A0 bool reserved;
> =A0};
>
> =A0struct omap_dm_timer *omap_dm_timer_request(void);
> @@ -248,7 +249,6 @@ struct omap_dm_timer {
> =A0 =A0 =A0 =A0struct list_head node;
> =A0};
>
> -extern u32 sys_timer_reserved;
> =A0int omap_dm_timer_prepare(struct omap_dm_timer *timer);
>
> =A0static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer=
, u32 reg,
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
