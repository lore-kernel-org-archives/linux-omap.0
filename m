From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform device driver
Date: Mon, 22 Nov 2010 18:05:17 +0530
Message-ID: <AANLkTin513xJwJphjwSdgxpSuoJcPSoP_9GxajOzbk7f@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com> <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com> <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
 <AANLkTik6PVX5XjX0T2GHhiEm4nb+P=V4UwXLWUr0XQNj@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0372E40047@dbde02.ent.ti.com>
 <AANLkTi=ao+J_3bs91F3YDXewkpOvY=e9rrGXYQC_yOu1@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0372E40154@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40702 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755014Ab0KVMgB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 07:36:01 -0500
Received: by mail-iw0-f172.google.com with SMTP id 40so8507682iwn.31
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 04:36:01 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0372E40154@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Nov 22, 2010 at 17:38, DebBarma, Tarun Kanti <tarun.kanti@ti.co=
m> wrote:
>
>> -----Original Message-----
>> From: Varadarajan, Charulatha
>> Sent: Monday, November 22, 2010 5:30 PM
>> To: DebBarma, Tarun Kanti
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platform =
device
>> driver
>>
>> On Mon, Nov 22, 2010 at 14:44, DebBarma, Tarun Kanti <tarun.kanti@ti=
=2Ecom>
>> wrote:
>> >> -----Original Message-----
>> >> From: Varadarajan, Charulatha
>> >> Sent: Monday, November 22, 2010 12:15 PM
>> >> To: DebBarma, Tarun Kanti
>> >> Cc: linux-omap@vger.kernel.org
>> >> Subject: Re: [PATCHv4 12/14] OMAP: dmtimer: switch-over to platfo=
rm
>> device
>> >> driver
>> >>
>> >> <<snip>>
>> >>
>> >> > -/*
>> >> > - * Reads timer registers in posted and non-posted mode. The po=
sted
>> mode
>> >> bit
>> >> > - * is encoded in reg. Note that in posted mode write pending b=
it
>> must
>> >> be
>> >> > - * checked. Otherwise a read of a non completed write will pro=
duce
>> an
>> >> error.
>> >> > +/**
>> >> > + * omap_dm_timer_read_reg - read timer registers in posted and=
 non-
>> >> posted mode
>> >> > + * @timer: =A0 =A0 =A0timer pointer over which read operation =
to perform
>> >> > + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
>> >> > + *
>> >> > + * The posted mode bit is encoded in reg. Note that in posted =
mode
>> >> write
>> >> > + * pending bit must be checked. Otherwise a read of a non comp=
leted
>> >> write
>> >> > + * will produce an error.
>> >> > =A0*/
>> >> > =A0static inline u32 omap_dm_timer_read_reg(struct omap_dm_time=
r
>> *timer,
>> >> u32 reg)
>> >> > =A0{
>> >> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pd=
ev-
>> >> >dev.platform_data;
>> >> > +
>> >> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
>> >> > +
>> >> > =A0 =A0 =A0 =A0if (timer->posted)
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
>> (OMAP_TIMER_WRITE_PEND_REG
>> >> & 0xff))
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
 (reg >> WPSHIFT))
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRIT=
E_PEND_REG + pdata-
>> >func_offst)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
 0xff)) & (reg >> WPSHIFT))
>> >>
>> >> You may add a timeout in this.
>> > There are few reasons why I have not done:
>> > (1) This was in this way from the beginning and I thought some ana=
lysis
>> > Was done already for not adding timeout and so did not wish to alt=
er
>> that.
>> > (2) wanted to keep low level functions as simple as possible by av=
oiding
>> > As many checks as possible unless really needed.
>> > (3) The client driver can take care of timeout. Even if timeout is
>> > Introduced in this api, the client driver anyways have to check fo=
r the
>> > Timeout.
>>
>> I don't think that client driver should take care of this. The clien=
t
>> driver should
>> check only for the return value. If timeout, return error.
> So what I am saying is it can add the timeout instead of checking for=
 the
> Return value. This would keep the low level function simple.
> Please try to understand that this is =A0a common function called by =
all the
> Client drivers associated with all the timers. If you can reduce a ch=
eck
> The benefit is tremendous.

I do not agree. If low level driver functions are using these common re=
ad/write
functions, there is a possibility of getting struck up in the while loo=
p since
there is no timeout. If you think that there is no possibility of timeo=
ut when
called from low level driver functions, remove the while loop unless if=
 it is
really required.

If these functions uses while loops, please have a timeout error. Other=
wise,
analyze and remove the while loop from these functions.

>
> --
> Tarun
>
>>
>> In your case, one of the calls to omap_dm_timer_write_reg() is as gi=
ven
>> below:
>> omap2_gp_timer_init()
>> =A0 =A0 -> omap2_gp_clockevent_init()
>> =A0 =A0 =A0 =A0 =A0 -> omap_dm_timer_request_specific()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> omap_dm_timer_prepare()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> omap_dm_timer_write_reg()
>>
>> Here timeout is not taken care.
>>
>> >
>> > --
>> > Tarun
>> >>
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>> >> > =A0 =A0 =A0 =A0return readl(timer->io_base + (reg & 0xff));
>> >> > =A0}
>> >> >
>> >> > -/*
>> >> > - * Writes timer registers in posted and non-posted mode. The p=
osted
>> >> mode bit
>> >> > - * is encoded in reg. Note that in posted mode the write pendi=
ng bit
>> >> must be
>> >> > - * checked. Otherwise a write on a register which has a pendin=
g
>> write
>> >> will be
>> >> > - * lost.
>> >> > +/**
>> >> > + * omap_dm_timer_write_reg - write timer registers in posted a=
nd
>> non-
>> >> posted mode
>> >> > + * @timer: =A0 =A0 =A0timer pointer over which write operation=
 is to
>> perform
>> >> > + * @reg: =A0 =A0 =A0 =A0lowest byte holds the register offset
>> >> > + * @value: =A0 =A0 =A0data to write into the register
>> >> > + *
>> >> > + * The posted mode bit is encoded in reg. Note that in posted =
mode
>> the
>> >> write
>> >> > + * pending bit must be checked. Otherwise a write on a registe=
r
>> which
>> >> has a
>> >> > + * pending write will be lost.
>> >> > =A0*/
>> >> > =A0static void omap_dm_timer_write_reg(struct omap_dm_timer *ti=
mer, u32
>> >> reg,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 value)
>> >> > =A0{
>> >> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pd=
ev-
>> >> >dev.platform_data;
>> >> > +
>> >> > + =A0 =A0 =A0 if (reg >=3D OMAP_TIMER_WAKEUP_EN_REG)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D pdata->func_offst;
>> >> > +
>> >> > =A0 =A0 =A0 =A0if (timer->posted)
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
>> (OMAP_TIMER_WRITE_PEND_REG
>> >> & 0xff))
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
 (reg >> WPSHIFT))
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (readl(timer->io_base +
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OMAP_TIMER_WRIT=
E_PEND_REG + pdata-
>> >func_offst)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
 0xff)) & (reg >> WPSHIFT))
>> >>
>> >> Ditto.
>> >>
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>> >> > =A0 =A0 =A0 =A0writel(value, timer->io_base + (reg & 0xff));
>> >> > =A0}
>> >>
>> >>
>> >> <<snip>>
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
