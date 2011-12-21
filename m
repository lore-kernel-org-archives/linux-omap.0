From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH V2 2/2] mcx: support for HTKW mcx board
Date: Wed, 21 Dec 2011 11:19:43 +0200
Message-ID: <4EF1A4AF.90807@compulab.co.il>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com> <1323910383-1184-3-git-send-email-yanok@emcraft.com> <4EE9CEB1.3050003@compulab.co.il> <4EF0EB09.4010008@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:44529
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752596Ab1LUJTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Dec 2011 04:19:49 -0500
In-Reply-To: <4EF0EB09.4010008@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

Hi Ilya,

On 12/20/11 22:07, Ilya Yanok wrote:
> Hi Igor,
> 
>>> +static struct omap2_hsmmc_info mmc[] = {
>>> +	{
>>> +		.mmc		= 1,
>>> +		.caps		= MMC_CAP_4_BIT_DATA,
>>> +		.gpio_cd        = SD_CARD_CD,
>>> +		.gpio_wp        = SD_CARD_WP,
>>> +		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34 |
>>> +					MMC_VDD_165_195,
>>
>> The ocr_mask will be overridden, by the following patch:
>> -----------------
>> commit e89715a7e48d505f42813a4e3ee0f0efb49832ba
>> Author: Abhilash K V <abhilash.kv@ti.com>
>> Date:   Fri Dec 9 12:27:36 2011 -0800
>>
>>     ARM: OMAP: hsmmc: Support for AM3517 MMC1 voltages
>> --------------
>>
>> in Tony's hsmmc branch.
>>
>> IMO it should be fixed, by adding a check if the ocr_mask is
>> already set...
>> I can't send a patch for this right now...
> 
> Well, I think I should just drop the .ocr_mask field then. Everything
> works fine for me with the above mentioned patch.

Yes, for your patch, it is correct - just remove it.

My concern is for the common code - it will override any
board special setting (e.g. you want smaller range supported).

>>> +static void __init mcx_init(void)
>>> +{
>>> +	int err;
>>> +
>>> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>>> +	mcx_i2c_init();
>>> +	platform_add_devices(mcx_devices, ARRAY_SIZE(mcx_devices));
>>> +	omap_serial_init();
>>
>> Shouldn't this one be before the mcx_i2c_init() call?
> 
> Well, I think I've taken this order from some other board init... I
> think the idea was to bring up regulator chip earlier. But I can move
> serial up with no problem.

I see, no problem.
My "concern" was about the pr_err() inside the mcx_i2c_init()
and the mcx_ts_init() functions.

Also, IMO, mcx_ts_init() can be done at a later stage, than along
with I2C buses initialization, but it does not really meter...


-- 
Regards,
Igor.
