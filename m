From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] OMAP2+: ads7846_init: put gpio_pendown into pdata if
 it's provided
Date: Wed, 21 Dec 2011 22:06:43 +0400
Message-ID: <4EF22033.9030806@emcraft.com>
References: <1324485086-31410-1-git-send-email-yanok@emcraft.com> <4EF215DE.8060002@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:54425 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab1LUSGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 13:06:14 -0500
In-Reply-To: <4EF215DE.8060002@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

Hi Igor,

On 21.12.2011 21:22, Igor Grinberg wrote:
> Please, Cc the linux-arm-kernel@lists.infradead.org for patches,
> so Tony, or whoever will not need to resend them...

Uh.. Actually I thought that linux-omap ML is a good place for really
OMAP-specific patches like this one and there is no much sense posting
such patches into the main ARM list...

Ok, I will Cc linux-arm-kernel in future.

>> If platform data is provided by the caller gpio_pendown is put into
>> unused static ads7846_config structure and effectively has no effect.
>> Of course caller can set gpio_pendown field in platform data himself
>> but it seems natural to do this in ads7846_init to remove duplication.
>>
>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>> ---
>>  arch/arm/mach-omap2/common-board-devices.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
>> index 2d1d775..eb408dd 100644
>> --- a/arch/arm/mach-omap2/common-board-devices.c
>> +++ b/arch/arm/mach-omap2/common-board-devices.c
>> @@ -75,7 +75,10 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>>  			gpio_set_debounce(gpio_pendown, gpio_debounce);
>>  	}
>>  
>> -	ads7846_config.gpio_pendown = gpio_pendown;
>> +	if (!board_pdata)
>> +		ads7846_config.gpio_pendown = gpio_pendown;
>> +	else
>> +		board_pdata->gpio_pendown = gpio_pendown;
>>  
>>  	spi_bi->bus_num	= bus_num;
>>  	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
> 
> The fact that the ads7846_config has no effect in case
> the board_pdata is provided does not really meter...
> How about reusing the existing "if" instead of adding another one?
> Like in the attached patch?

Yes, I think your version is a bit clearer. Probably it makes to add
"else" clause and move ads7846_config.gpio_pendown assignment under it.

Regards, Ilya.
