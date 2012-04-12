From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
Date: Thu, 12 Apr 2012 10:22:22 +0530
Message-ID: <CAC83ZvKyh38=BdWg9ExTM20Sq_c3e-fo2JrH5Cmv80hY8TxLLA@mail.gmail.com>
References: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
	<87zkahlrdc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:43217 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753354Ab2DLEwX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 00:52:23 -0400
Received: by qaeb19 with SMTP id b19so4192510qae.11
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 21:52:22 -0700 (PDT)
In-Reply-To: <87zkahlrdc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 12, 2012 at 6:04 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Since hwmod framework now manages sysconfig context save/restore
>> there is no more need to touch this register in driver. Hence,
>> remove restore of sysconfig register in omap_timer_restore_context.
>> This was causing incorrect context restore of sysconfig register.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> While cleaning this up, you can remove it from 'struct timer_regs' =A0=
in
> <plat/dmtimer.h> as well, since the code you remove is the only user.
Oh yes I missed that. Thanks.
--
Tarun
>
> Kevin
>
>> ---
>> =A0arch/arm/plat-omap/dmtimer.c | =A0 =A02 --
>> =A01 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtim=
er.c
>> index 652139c..15e7882 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm=
_timer *timer, u32 reg,
>>
>> =A0static void omap_timer_restore_context(struct omap_dm_timer *time=
r)
>> =A0{
>> - =A0 =A0 __raw_writel(timer->context.tiocp_cfg,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->io_base + OMAP_TIME=
R_OCP_CFG_OFFSET);
>> =A0 =A0 =A0 if (timer->revision =3D=3D 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(timer->context.tistat, time=
r->sys_stat);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
