From: <ilkka.koskinen@nokia.com>
Subject: RE: [PATCH] rtc-twl: Switch to using threaded irq
Date: Thu, 5 May 2011 07:51:15 +0000
Message-ID: <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>,<BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:34621 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab1EEHv4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 03:51:56 -0400
In-Reply-To: <BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, john.stultz@linaro.org
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, balajitk@ti.com, ilkkakos@kolumbus.fi


Hi,

Tony and John: What would be the appropriate path for this patch?

Cheers, Ilkka

On Apr 13, 2011 Krishnamoorthy, Balaji T  wrote:
>On Wed, Mar 16, 2011 at 9:37 PM, Ilkka Koskinen
<ilkka.koskinen@nokia.com> wrote:
>>
>> The driver is accessing to i2c bus in interrupt handler.
>> Therefore, it should use threaded irq.

>Acked-by: Balaji T K <balajitk@ti.com>

>>
>> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
>> ---
>>  drivers/rtc/rtc-twl.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
>> index ed1b868..2715b96 100644
>> --- a/drivers/rtc/rtc-twl.c
>> +++ b/drivers/rtc/rtc-twl.c
>> @@ -475,7 +475,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
>>        if (ret < 0)
>>                goto out1;
>>
>> -       ret = request_irq(irq, twl_rtc_interrupt,
>> +       ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
>>                                IRQF_TRIGGER_RISING,
>>                                dev_name(&rtc->dev), rtc);
>>        if (ret < 0) {
>> --
>> 1.7.0.4
>>
