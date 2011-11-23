From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in
 low-power mode support
Date: Wed, 23 Nov 2011 18:03:09 +0530
Message-ID: <CAC83ZvK7-jfXm0YZo45pcd7D4_Ad858u1WJY1ozfy+z31Zk5Wg@mail.gmail.com>
References: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
	<CAB-zwWiNc=aFMd2ccyL=s1c5qa8dnu6c-M29K1CrezJ01YXZWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na6sys009bog026.obsmtp.com ([74.125.150.92]:41749 "EHLO
	na6sys009bog026.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960Ab1KWMjl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 07:39:41 -0500
Received: by mail-qw0-f42.google.com with SMTP id g40so2535167qab.8
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 04:39:37 -0800 (PST)
In-Reply-To: <CAB-zwWiNc=aFMd2ccyL=s1c5qa8dnu6c-M29K1CrezJ01YXZWg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Mon, Nov 21, 2011 at 10:12 PM, Ramirez Luna, Omar
<omar.ramirez@ti.com> wrote:
> Hi,
>
> On Tue, Nov 8, 2011 at 12:00 AM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
>> to use timer->func_base OCP_CFG should not use this wrapper anymore.
>> Instead use __raw_writel() directly and use timer->io_base instead
>> to write to OCP_CFG.
>>
>> The timer->sys_stat is valid only if timer->revision is 1. In the
>> context restore function make this correction.
>>
>> Save the contexts and loss count when timer is stopped.
>> Also, disable the clock. Else, clock usecount would become imbalance=
d.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ...
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtim=
er.c
>> index af3b92b..f042c82 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
> ...
>> @@ -357,6 +357,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *ti=
mer)
>>
>> =A0 =A0 =A0 =A0__omap_dm_timer_stop(timer, timer->posted, rate);
>>
>> + =A0 =A0 =A0 if (timer->loses_context) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timer->get_context_loss_count)
>
> Maybe: if (timer->loses_context && timer->get_context_loss_count)
Sure.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->ctx_loss_count =
=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_los=
s_count(&timer->pdev->dev);
>
> could get rid =A0of this weird one-line formatting
ok.
>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Since the register values are computed and writte=
n within
>> + =A0 =A0 =A0 =A0* __omap_dm_timer_stop, we need to use read to retr=
ieve the
>> + =A0 =A0 =A0 =A0* context.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 timer->context.tclr =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_read_reg=
(timer, OMAP_TIMER_CTRL_REG);
>> + =A0 =A0 =A0 timer->context.tisr =3D __raw_readl(timer->irq_stat);
>> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
>
> FWIW, functionally it looks good to me, besides it fixes the broken
> dmtimer start/stop sequence from 3.2-rc1. Tested with tidspbridge on
> omap3.
Thanks.

>
> If needed:
>
> Tested-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Sure. Thanks.
--
Tarun
>
> Regards,
>
> Omar
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
