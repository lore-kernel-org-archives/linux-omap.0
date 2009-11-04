From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: [PATCH] omap3: beagle: Fix USB host port power control
Date: Wed, 04 Nov 2009 02:22:43 +0000
Message-ID: <4AF0E573.80906@blueyonder.co.uk>
References: <1256371194-22944-1-git-send-email-jhnikula@gmail.com> <CD99E8BE-6FBB-4975-9072-A9BE16B1A00D@student.utwente.nl>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:46020 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751012AbZKDCWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 21:22:44 -0500
In-Reply-To: <CD99E8BE-6FBB-4975-9072-A9BE16B1A00D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On 03/11/09 14:11, Koen Kooi wrote:
> Any comments on this, I need this on beagleboard to make ehci work.
> 
> regards,
> 
> Koen
> 
> Op 24 okt 2009, om 09:59 heeft Jarkko Nikula het volgende geschreven:
> 
>> The host port power is enabled by driving the nEN_USB_PWR low as
>> stated in
>> the comment. This fix is originally from Steve Sakoman
>> <steve@sakoman.com>.
>>
>> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
>> Cc: Steve Sakoman <steve@sakoman.com>
>> ---
>> arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
>> b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 6cb99f6..7ad9846 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -162,7 +162,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
>>
>>     /* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active
>> low) */
>>     gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
>> -    gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
>> +    gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
>>
>>     /* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>>     gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>> -- 
>> 1.6.3.3
>>
>> -- 

Certainly works on 2.6.32-rc5, all EHCI devices are now enumerated.
Regards
Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

