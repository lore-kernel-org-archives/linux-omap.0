From: venki kaps <venkiece2005@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Wed, 8 Sep 2010 21:25:30 +0530
Message-ID: <AANLkTimwMiOfvCpUfeXPSF8zh3t3YsM_8nDZbuWFcKM4@mail.gmail.com>
References: <AANLkTinnHiCodvHrSxiMCAQXAETczRiZ+sDu2aQXSeG0@mail.gmail.com>
	<AANLkTiksb1AudCzs8-TWdXb11T-QcPx1G_qu6eUtJ74C@mail.gmail.com>
	<AANLkTin7eVyosgK4XhuB_yqR2ao=YJGVidHB1x2802cr@mail.gmail.com>
	<AANLkTinrecJXH+uDxtBsskFLpBCz0VSZMtSiWGFW9YCr@mail.gmail.com>
	<AANLkTinkhY-y6Qv6HJnGbggksdEmULgQ9DTOrNmu1tLp@mail.gmail.com>
	<AANLkTikZK=8HCtXDR_2dSBce1E10xNfBtyXGOJqykV83@mail.gmail.com>
	<AANLkTin8bXvPqdkYQq++wf0iCK=ZAfZ2jnqbgL=xj8yq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33187 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0IHPza convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 11:55:30 -0400
In-Reply-To: <AANLkTin8bXvPqdkYQq++wf0iCK=ZAfZ2jnqbgL=xj8yq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, Anand Gadiyar <gadiyar@ti.com>

Hi Ming Lei &  Balbi,

Thanks for your support and the porblem is resolved.

Venkii,
On Tue, Sep 7, 2010 at 11:52 PM, venki kaps <venkiece2005@gmail.com> wr=
ote:
> Venkii,
> On Tue, Sep 7, 2010 at 11:45 PM, venki kaps <venkiece2005@gmail.com> =
wrote:
>> Venkii,
>> On Tue, Sep 7, 2010 at 9:18 PM, venki kaps <venkiece2005@gmail.com> =
wrote:
>>> Venkii,
>>>
>>> On Tue, Sep 7, 2010 at 9:10 PM, Ming Lei <tom.leiming@gmail.com> wr=
ote:
>>>> 2010/9/7 venki kaps <venkiece2005@gmail.com>:
>>>>> thanks for your good response.
>>>>>
>>>>> Venkii,
>>>>>
>>>>> On Tue, Sep 7, 2010 at 6:54 PM, Ming Lei <tom.leiming@gmail.com> =
wrote:
>>>>>> 2010/9/7 venki kaps <venkiece2005@gmail.com>:
>>>>>>> Dear USB experts,
>>>>>>>
>>>>>>> =A0Is the same fix valid for omap3430 + 2.6.32 Kernel?
>>>>>>>
>>>>>>> =A0I have been facing mp3 playback idle current consumption 20m=
A more
>>>>>>> after booting without USB cable connected
>>>>>>> =A0but If USB cable detach and attach happen, then able to hit =
proper
>>>>>>> values otherwise irrespective of cold/warm reset
>>>>>>> =A0the current values increases to 20mA.
>>>>>>>
>>>>>>> =A0with cable,
>>>>>>> =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART idle
>>>>>>> =A0 =A0 =A0HSOTGUSB_STANDBY - SMART standby
>>>>>>>
>>>>>>> =A0without cable,
>>>>>>> =A0 =A0 =A0 =A0OTG_SYSCONFIG standby mode of operation - SMART =
idle
>>>>>>> =A0 =A0 =A0 =A0HSOTGUSB_STANDBY - Active
>>>>>>>
>>>>>>> =A0Even i have applied =A0patch but still the same issue.
>>>>>>
>>>>>> Are you applying the patch below?
>>>>>>
>>>>>> =A0 =A0 =A0 =A0 http://marc.info/?l=3Dlinux-omap&m=3D12837868622=
1264&w=3D2
>>>>>>
>>>>>> The patch(USB: otg: twl4030: fix phy initialization(v1)) above i=
s against
>>>>>> 2.6.36-rc3, I don't think you can apply it directly on 2.6.32. A=
nd the patch
>>>>>> is introduced to fix the problems caused by
>>>>>>
>>>>>> =A0 =A0 =A0 =A0 =A0commit 461c317705eca5cac09a360f488715927fd0a9=
27.
>>>>>>
>>>>>> which change is committed into mainline 2.6.36-rc3.
>>>>> =A0>>> Yes, this patch i have applied.
>>>>
>>>> If you applied the patch, I guess you may see __twl4030_phy_power(=
twl, 0)
>>>> is called from .probe.
>>>>
>>>> If called, =A0seems your description a little contradictory since =
you observed
>>>> __twl4030_phy_power(twl, 0) may hit proper values, right?
>>>
>>> =A0Yes, __twl4030_phy_power(twl, 0) - =A0the current values are get=
ting
>>> proper with or without cable.
>>>>
>>>> If not called, could you trace the return value of twl4030_usb_lin=
kstat in
>>>> twl4030_usb_phy_init?
>>> ok, i can do that and update.
>> =A0 =A0 twl4030_usb_linkstat return value is zero (0) in both
>> twl4030_usb_phy_init/twl4030_usb_irq.
> =A0WIth twl4030_usb_phy_init, Everything is fine except battery tempe=
rature
> =A0but surprisingly the temperature is fine with PC based usb cable c=
harger and
> =A0the problem is with travel adapter only.

 The temperature with TA effected due to the TWL4030 PHY power down on
I2c(__twl4030_phy_power(twl, 0)).
 When TA connect to the phone the battery ADC is not reading proper
values since already PHY power down.

  To resolve the above issue, we have made "PHY power on" in battery
adc on function
  and "PHY power down" in battery adc off function.

  With the above change the problem is resolved.

>>>> thanks,
>>>>
>>>> --
>>>> Lei Ming
>>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
