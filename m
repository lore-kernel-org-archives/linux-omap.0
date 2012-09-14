From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
Date: Fri, 14 Sep 2012 07:07:50 -0700
Message-ID: <87r4q4aea1.fsf@deeprootsystems.com>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
	<CAM=Q2cufVSReuvs3Yf6jvuBFeV9j5iPWV-DaMqRkCJFXUMZPQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49465 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab2INOHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 10:07:52 -0400
Received: by obbuo13 with SMTP id uo13so6262948obb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 07:07:52 -0700 (PDT)
In-Reply-To: <CAM=Q2cufVSReuvs3Yf6jvuBFeV9j5iPWV-DaMqRkCJFXUMZPQg@mail.gmail.com>
	(Shubhrajyoti Datta's message of "Fri, 14 Sep 2012 17:12:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:

> Hi Kevin,
>
> On Fri, Sep 14, 2012 at 2:15 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From: Kevin Hilman <khilman@ti.com>
>>
>> On some platforms, bootloaders are known to do some interesting RTC
>> programming.  Without going into the obscurities as to why this may be
>> the case, suffice it to say the the driver should not make any
>> assumptions about the state of the RTC when the driver loads.  In
>> particular, the driver probe should be sure that all interrupts are
>> disabled until otherwise programmed.
>>
>> This was discovered when finding bursty I2C traffic every second on
>> Overo platforms.  This I2C overhead was keeping the SoC from hitting
>> deep power states.  The cause was found to be the RTC firing every
>> second on the I2C-connected TWL PMIC.
>>
>> Special thanks to Felipe Balbi for suggesting to look for a rogue
>> driver as the source of the I2C traffic rather than the I2C driver
>> itself.
>>
>> Special thanks to Steve Sakoman for helping track down the source of
>> the continuous RTC interrups on the Overo boards.
>>
>
> Tested that the continuous interrupt issue after doing a i2c mm on omap4sdp.
> This patch solves the issue.
> thanks,
>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Steve Sakoman <steve@sakoman.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Patch applies to v3.6-rc5
>>
>>  drivers/rtc/rtc-twl.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
>> index c5d06fe..9277d94 100644
>> --- a/drivers/rtc/rtc-twl.c
>> +++ b/drivers/rtc/rtc-twl.c
>> @@ -495,6 +495,11 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
>>         if (ret < 0)
>>                 goto out1;
>>
>> +       /* ensure interrupts are disabled, bootloaders can be strange */
>> +       ret = twl_rtc_write_u8(0, REG_RTC_INTERRUPTS_REG);
>> +       if (ret < 0)
>> +               dev_warn(&pdev->dev, "unable to disable interrupt\n");
>> +
> Now that it is always 0 can the below read be removed as it is redundant now.

Possibly, but I don't know this HW well enough to know if there are any
persistent bits in that register on any of the various derivations of
this PMIC.  Since this read-back value is used throughout the driver, I
decided not to mess with it when doing this targetted fix.

Kevin

