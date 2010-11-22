From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform device driver
Date: Mon, 22 Nov 2010 12:14:31 +0530
Message-ID: <AANLkTik6PVX5XjX0T2GHhiEm4nb+P=V4UwXLWUr0XQNj@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com> <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com> <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46263 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab0KVGpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 01:45:13 -0500
Received: by mail-iw0-f169.google.com with SMTP id 33so2986408iwn.28
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 22:45:12 -0800 (PST)
In-Reply-To: <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

<<snip>>

> -/*
> - * Reads timer registers in posted and non-posted mode. The posted m=
ode bit
> - * is encoded in reg. Note that in posted mode write pending bit mus=
t be
> - * checked. Otherwise a read of a non completed write will produce a=
n error.
> +/**
> + * omap_dm_timer_read_reg - read timer registers in posted and non-p=
osted mode
> + * @timer: =A0 =A0 =A0timer pointer over which read operation to per=
form
> + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> + *
> + * The posted mode bit is encoded in reg. Note that in posted mode w=
rite
> + * pending bit must be checked. Otherwise a read of a non completed =
write
> + * will produce an error.
> =A0*/
> =A0static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *tim=
er, u32 reg)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
> +
> =A0 =A0 =A0 =A0if (timer->posted)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base + (OMAP_TIM=
ER_WRITE_PEND_REG & 0xff))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (reg =
>> WPSHIFT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRITE_PEND=
_REG + pdata->func_offst)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & 0xff)=
) & (reg >> WPSHIFT))

You may add a timeout in this.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> =A0 =A0 =A0 =A0return readl(timer->io_base + (reg & 0xff));
> =A0}
>
> -/*
> - * Writes timer registers in posted and non-posted mode. The posted =
mode bit
> - * is encoded in reg. Note that in posted mode the write pending bit=
 must be
> - * checked. Otherwise a write on a register which has a pending writ=
e will be
> - * lost.
> +/**
> + * omap_dm_timer_write_reg - write timer registers in posted and non=
-posted mode
> + * @timer: =A0 =A0 =A0timer pointer over which write operation is to=
 perform
> + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
> + * @value: =A0 =A0 =A0data to write into the register
> + *
> + * The posted mode bit is encoded in reg. Note that in posted mode t=
he write
> + * pending bit must be checked. Otherwise a write on a register whic=
h has a
> + * pending write will be lost.
> =A0*/
> =A0static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u=
32 reg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0u32 value)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
> +
> =A0 =A0 =A0 =A0if (timer->posted)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base + (OMAP_TIM=
ER_WRITE_PEND_REG & 0xff))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (reg =
>> WPSHIFT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRITE_PEND=
_REG + pdata->func_offst)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & 0xff)=
) & (reg >> WPSHIFT))

Ditto.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> =A0 =A0 =A0 =A0writel(value, timer->io_base + (reg & 0xff));
> =A0}


<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
