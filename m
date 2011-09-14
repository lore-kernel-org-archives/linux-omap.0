From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v15 11/12] OMAP: dmtimer: extend spinlock to exported APIs
Date: Wed, 14 Sep 2011 10:28:06 +0530
Message-ID: <CAC83ZvK0rknVX3bw42dL-V2Dpq5wjwhU6H=fNjR1=oZCs+rkng@mail.gmail.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-12-git-send-email-tarun.kanti@ti.com>
	<20110913231540.GI24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42337 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837Ab1INE6I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 00:58:08 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1518547bkb.33
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 21:58:07 -0700 (PDT)
In-Reply-To: <20110913231540.GI24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, Sep 14, 2011 at 4:45 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
>> Since the exported APIs can be called from interrupt context
>> extend spinlock protection to some more relevant APIs to avoid
>> race condition.
>
> We should have locking for requesting and releasing a timer etc,
> but I don't see need for that for the timer specific functions.
Alright... I will remove locking from timer specific functions.
In that case we have extension of locks to just following two functions=
:
omap_dm_timer_request()
omap_dm_timer_request_specific()

So, I can modify the patch subject and description accordingly.

>
>> @@ -317,9 +317,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
>> =A0void omap_dm_timer_start(struct omap_dm_timer *timer)
>> =A0{
>> =A0 =A0 =A0 u32 l;
>> + =A0 =A0 unsigned long flags;
>>
>> =A0 =A0 =A0 omap_dm_timer_enable(timer);
>>
>> + =A0 =A0 spin_lock_irqsave(&dm_timer_lock, flags);
>> =A0 =A0 =A0 if (timer->loses_context) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctx_loss_cnt_after =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_loss_=
count(&timer->pdev->dev);
>
> Here the caller already owns the timer being started. So there
> should never be multiple users for a single timer. If there are,
> then the caller should take care of locking.
Ok.

>
>> =A0void omap_dm_timer_stop(struct omap_dm_timer *timer)
>> =A0{
>> - =A0 =A0 unsigned long rate =3D 0;
>> + =A0 =A0 unsigned long rate =3D 0, flags;
>> =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->dev=
=2Eplatform_data;
>> =A0 =A0 =A0 bool is_omap2 =3D true;
>>
>> + =A0 =A0 spin_lock_irqsave(&dm_timer_lock, flags);
>> =A0 =A0 =A0 if (pdata->needs_manual_reset)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_omap2 =3D false;
>> =A0 =A0 =A0 else
>
> Here too.
Right.

>
>> @@ -389,8 +394,10 @@ void omap_dm_timer_set_load(struct omap_dm_time=
r *timer, int autoreload,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int loa=
d)
>> =A0{
>> =A0 =A0 =A0 u32 l;
>> + =A0 =A0 unsigned long flags;
>>
>> =A0 =A0 =A0 omap_dm_timer_enable(timer);
>> + =A0 =A0 spin_lock_irqsave(&dm_timer_lock, flags);
>> =A0 =A0 =A0 l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG)=
;
>> =A0 =A0 =A0 if (autoreload)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D OMAP_TIMER_CTRL_AR;
>
> And here.
Ok.

>
>> @@ -412,9 +420,11 @@ void omap_dm_timer_set_load_start(struct omap_d=
m_timer *timer, int autoreload,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =
int load)
>> =A0{
>> =A0 =A0 =A0 u32 l;
>> + =A0 =A0 unsigned long flags;
>>
>> =A0 =A0 =A0 omap_dm_timer_enable(timer);
>>
>> + =A0 =A0 spin_lock_irqsave(&dm_timer_lock, flags);
>> =A0 =A0 =A0 if (timer->loses_context) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctx_loss_cnt_after =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_loss_=
count(&timer->pdev->dev);
>
> Not needed here either. And that's the case for all the other functio=
ns
> too.
Sure.
--
Tarun
>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
