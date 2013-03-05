From: kishon <kishon@ti.com>
Subject: Re: [PATCH] ARM: OMAP: RX-51: add missing USB phy binding
Date: Tue, 5 Mar 2013 17:11:54 +0530
Message-ID: <5135DA02.8070801@ti.com>
References: <1362481780-11018-1-git-send-email-aaro.koskinen@iki.fi> <20130305113618.GB19290@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59137 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982Ab3CELmR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Mar 2013 06:42:17 -0500
In-Reply-To: <20130305113618.GB19290@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 05 March 2013 05:06 PM, Felipe Balbi wrote:
> On Tue, Mar 05, 2013 at 01:09:40PM +0200, Aaro Koskinen wrote:
>> Commit 51482be9 (ARM: OMAP: USB: Add phy binding information) forgot to
>> add phy binding for RX-51, and as a result USB does not work anymore on
>> 3.9-rc1. Add the missing binding.
>>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>
> Acked-by: Felipe Balbi <balbi@ti.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>
>> ---
>>   arch/arm/mach-omap2/board-rx51.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
>> index f7c4616..d2ea68e 100644
>> --- a/arch/arm/mach-omap2/board-rx51.c
>> +++ b/arch/arm/mach-omap2/board-rx51.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/io.h>
>>   #include <linux/gpio.h>
>>   #include <linux/leds.h>
>> +#include <linux/usb/phy.h>
>>   #include <linux/usb/musb.h>
>>   #include <linux/platform_data/spi-omap2-mcspi.h>
>>
>> @@ -98,6 +99,7 @@ static void __init rx51_init(void)
>>   	sdrc_params = nokia_get_sdram_timings();
>>   	omap_sdrc_init(sdrc_params, sdrc_params);
>>
>> +	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>>   	usb_musb_init(&musb_board_data);
>>   	rx51_peripherals_init();
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

