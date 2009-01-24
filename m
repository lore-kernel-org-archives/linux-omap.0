From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Sat, 24 Jan 2009 09:06:22 -0600
Message-ID: <A73F0912-41CB-43F7-BE84-A4B91183B66B@beagleboard.org>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <A11F15D6-F171-4D62-ADB9-1508B57037E4@beagleboard.org> <200901230152.17239.david-b@pacbell.net> <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:12146 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZAXPG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 10:06:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5182185rvb.1
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2009 07:06:25 -0800 (PST)
In-Reply-To: <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Beagle Board <beagleboard@googlegroups.com>


On Jan 23, 2009, at 4:48 AM, Koen Kooi wrote:

>
> Op 23 jan 2009, om 10:52 heeft David Brownell het volgende geschreven:
>
>> On Friday 23 January 2009, Koen Kooi wrote:
>>>
>>> Op 15 jan 2009, om 20:30 heeft Koen Kooi het volgende geschreven:
>>>
>>>> From: Koen Kooi <koen@beagleboard.org>
>>>>
>>>> Changing it to 100kHz is needed to make more devices works  
>>>> properly.
>>>> Controlling the TI DLP Pico projector[1] doesn't work properly at
>>>> 400kHz, 100kHz and lower work fine. EDID readout is unaffected by
>>>> this change.
>>>>
>>>> [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
>>>>
>>>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>>>
>>> Any comments on this patch?
>>
>> I2C-3 is only used for talking on DVI, right?
>> Which means EDID ... and maybe DLP/Pico, unless
>> someone uses it as an I2C adapter.  (Which some
>> folk hack together on PCs...)
>>
>> Seems harmless to me, but I'd add a comment
>> explaining why just 100 MHz.  (The Pico manual
>> says 400 KHz should work.)
>
> The updated manual will say 400kHz won't work, the TI DLP engineers  
> were the ones that designed the pico that pointed the i2c speed  
> problem out to me :)
> I'd be happy to change the patch if needed, but I think the updated  
> manual will take care of most issues.
>
> regards,
>
> Koen

Given that this port is only used on the DVI port for the BeagleBoard,  
I believe it is appropriate to set it to 100kHz as Koen has done.


>
>
>>
>>
>> - Dave
>>
>>
>>>
>>> regards,
>>>
>>> Koen
>>>
>>>
>>>
>>>
>>>>
>>>> ---
>>>> arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/ 
>>>> mach-
>>>> omap2/board-omap3beagle.c
>>>> index fe97bab..f279404 100644
>>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>>> @@ -227,7 +227,7 @@ static int __init omap3_beagle_i2c_init(void)
>>>> #ifdef CONFIG_I2C2_OMAP_BEAGLE
>>>> 	omap_register_i2c_bus(2, 400, NULL, 0);
>>>> #endif
>>>> -	omap_register_i2c_bus(3, 400, NULL, 0);
>>>> +	omap_register_i2c_bus(3, 100, NULL, 0);
>>>> 	return 0;
>>>> }
>>>>
>>>> -- 
>>>> 1.5.6.3
>

