From: Ilkka Koskinen <ilkkakos@kolumbus.fi>
Subject: Re: [PATCH] rtc-twl: Switch to using threaded irq
Date: Wed, 18 May 2011 22:20:05 +0300
Message-ID: <4DD41BE5.4050600@kolumbus.fi>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>	 ,<BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>	 <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com> <1305242664.2680.28.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:43319 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933711Ab1ERT2J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 15:28:09 -0400
In-Reply-To: <1305242664.2680.28.camel@work-vm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: John Stultz <john.stultz@linaro.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, balajitk@ti.com


Hi,

Tony, would you mind taking the patch in your tree?

Btw, the nokia address doesn't work anymore, but
should probably still remain in s-o-b...

Cheers, Ilkka

13.5.2011 2:24, John Stultz kirjoitti:
> On Thu, 2011-05-05 at 07:51 +0000, ilkka.koskinen@nokia.com wrote:
>> Hi,
>>
>> Tony and John: What would be the appropriate path for this patch?
> 
> I'd probably push it through omap maintainer path, as its hardware
> specific and can be better tested there.
> 
> thanks
> -john
> 
> 
>> On Apr 13, 2011 Krishnamoorthy, Balaji T  wrote:
>>> On Wed, Mar 16, 2011 at 9:37 PM, Ilkka Koskinen
>> <ilkka.koskinen@nokia.com> wrote:
>>>>
>>>> The driver is accessing to i2c bus in interrupt handler.
>>>> Therefore, it should use threaded irq.
>>
>>> Acked-by: Balaji T K <balajitk@ti.com>
>>
>>>>
>>>> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
>>>> ---
>>>>  drivers/rtc/rtc-twl.c |    2 +-
>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
>>>> index ed1b868..2715b96 100644
>>>> --- a/drivers/rtc/rtc-twl.c
>>>> +++ b/drivers/rtc/rtc-twl.c
>>>> @@ -475,7 +475,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
>>>>        if (ret < 0)
>>>>                goto out1;
>>>>
>>>> -       ret = request_irq(irq, twl_rtc_interrupt,
>>>> +       ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
>>>>                                IRQF_TRIGGER_RISING,
>>>>                                dev_name(&rtc->dev), rtc);
>>>>        if (ret < 0) {
>>>> --
>>>> 1.7.0.4
>>>>
> 
> 
