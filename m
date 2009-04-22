From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: Suggestion and patch about the alarm of TWL4030-RTC
Date: Wed, 22 Apr 2009 14:34:44 +0900
Message-ID: <4d34a0a70904212234k6b126e4s7483b2ffd7f128c2@mail.gmail.com>
References: <49EEA279.2010202@samsung.com>
	 <200904212157.43022.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:40894 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZDVFep convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 01:34:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2743336rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 22:34:44 -0700 (PDT)
In-Reply-To: <200904212157.43022.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kim Kyuwon <q1.kim@samsung.com>, OMAP <linux-omap@vger.kernel.org>, kyungmin.park@samsung.com, bhmin@samsung.com, Kevin Hilman <khilman@deeprootsystems.com>, rtc-linux@googlegroups.com

On Wed, Apr 22, 2009 at 1:57 PM, David Brownell <david-b@pacbell.net> w=
rote:
> On Tuesday 21 April 2009, Kim Kyuwon wrote:
>> Hi All,
>>
>> >From the twl4030_rtc_suspend() in rtc-twl4030.c, the alarm signal o=
f TWL4030 RTC can't wake up the system form suspend.
>> However, I think it is more reasonable to alarm wake up the system a=
nd this is just we do.
>> (Mobile phone is mostly in suspend state, especially in the morning,=
 thus alarm signal can wake up the phone!)
>> So I'm sending following patch.
>>
>> Please give your comments.
>> I really want to apply this patch.
>>
>> Thanks & Regards,
>> Kyuwon
>>
>> --
>> >From 9d70ffc38653b1fb0dc7ae0950502e4adfe06c50 Mon Sep 17 00:00:00 2=
001
>> From: Kim Kyuwon <q1.kim@samsung.com>
>> Date: Wed, 22 Apr 2009 13:29:50 +0900
>> Subject: [PATCH] rtc: rtc-twl4030 don't mask alarm interrupts on sus=
pend
>>
>> This patch enables the alarm interrupt of TWL4030 RTC to wake up the=
 system from suspend
>>
>> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
>
> Looks right to me. =A0If you've tested thhis:

I tested with following commands,

# echo +10 > sys/class/rtc/rtc0/wakealarm; echo mem > /sys/power/state;

I confirm that the system wake up after 10 seconds.
Thank you.

> =A0Acked-by: David Brownell <dbrownell@users.sourceforge.net>
>
> The reason I left that original clearly-wrong code in place
> was that I had yet to see an OMAP3-based system which could
> use the system suspend state, so it was unclear that change
> would suffice...
>
>
>> ---
>> =A0drivers/rtc/rtc-twl4030.c | =A0 =A04 +---
>> =A01 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
>> index ad35f76..c185939 100644
>> --- a/drivers/rtc/rtc-twl4030.c
>> +++ b/drivers/rtc/rtc-twl4030.c
>> @@ -495,9 +495,7 @@ static int twl4030_rtc_suspend(struct platform_d=
evice *pdev, pm_message_t state)
>> =A0{
>> =A0 =A0 =A0 irqstat =3D rtc_irq_bits;
>>
>> - =A0 =A0 /* REVISIT alarm may need to wake us from sleep */
>> - =A0 =A0 mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT_RTC_INTERRUPTS_REG_=
IT_ALARM_M);
>> + =A0 =A0 mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> --
>> 1.5.2.5
>>
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
