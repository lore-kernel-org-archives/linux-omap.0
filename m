From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM
Date: Tue, 14 Dec 2010 19:54:37 +0530
Message-ID: <4D077E25.5070609@ti.com>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org> <E4A07EF4-1694-4B22-8015-0710B6BE7A2E@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35108 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754695Ab0LNOYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 09:24:43 -0500
Received: by mail-gy0-f172.google.com with SMTP id 12so356720gyd.3
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 06:24:42 -0800 (PST)
In-Reply-To: <E4A07EF4-1694-4B22-8015-0710B6BE7A2E@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 12/14/2010 7:41 PM, Koen Kooi wrote:
> Any comments on this?
> 
> Op 7 dec 2010, om 13:40 heeft Koen Kooi het volgende geschreven:
> 
>> From: Koen Kooi <koen@dominion.thruhere.net>
>>


You may want to add a description here. For instance you're
making the PMU STAT led disappear - and I'm not sure it's
deliberate.

>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>> ---
>> arch/arm/mach-omap2/board-omap3beagle.c |   27 +++++++++++++++++++++++----
>> 1 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index f1a8ede..9c9bd96 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -297,12 +297,31 @@ static int beagle_twl_gpio_setup(struct device *dev,
>> 	gpio_request(gpio + 1, "EHCI_nOC");
>> 	gpio_direction_input(gpio + 1);
>>
>> -	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
>> +	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
>> +	 * high / others active low) */


Just nitpicking. The multi-line comments are not as per
Documentation/CodingStyle.




>> 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
>> -	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
>> +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
>> +	else
>> +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
>> +
>> +	/* DVI reset GPIO is different between revisions */
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
>> +		beagle_dvi_device.reset_gpio = 129;
>> +	else
>> +		beagle_dvi_device.reset_gpio = 170;
>> +
>> +	 /* Power on DVI, Serial and PWR led */
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +		gpio_request(gpio + 1, "nDVI_PWR_EN");
>> +		gpio_direction_output(gpio + 1, 0);
>> +	}
>>
>> -	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>> -	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;

This disappeared. So no more PMU STAT led?

>> +	/* Power on camera interface on P7/P8 or DVI on A2 and beyond */
>> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +		gpio_request(gpio + 2, "CAM_EN");
>> +		gpio_direction_output(gpio + 2, 1);
>> +	}
>>
>> 	return 0;
>> }
