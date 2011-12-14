From: Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com>
Subject: Re: [PATCH v2] OMAP3: RX-51: complete tsc2005 controller support
Date: Wed, 14 Dec 2011 17:39:46 +0200
Message-ID: <4EE8C342.5060302@nokia.com>
References: <1323867676-15956-1-git-send-email-vladimir.zapolskiy@nokia.com> <1323867775-16031-1-git-send-email-vladimir.zapolskiy@nokia.com> <4EE8B371.6070108@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45879 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632Ab1LNPkS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 10:40:18 -0500
In-Reply-To: <4EE8B371.6070108@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>

Hi Igor,

thanks for review.

On 12/14/2011 04:32 PM, ext Igor Grinberg wrote:
> Hi Vladimir,
>
> On 12/14/11 15:02, Vladimir Zapolskiy wrote:
>> This change adds initialization of TSC2005 touchscreen controller found on Nokia
>> RX-51 board.
>>
>> The change is taken from MeeGo kernel adaptation for Nokia N900, it repeats the
>> work of Aaro Koskinen and Mika Laitio, the original discussion is at
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26749.html
>>
>> Signed-off-by: Vladimir Zapolskiy<vladimir.zapolskiy@nokia.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Aaro Koskinen<aaro.koskinen@nokia.com>
>> Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>> ---
>> Changes from v1 to v2:
>> * whitespace fix
>>
>>   arch/arm/mach-omap2/board-rx51-peripherals.c |   45 ++++++++++++++++++++++++-
>>   1 files changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> index ba1aa07..f30484e 100644
>> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
>> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> @@ -15,6 +15,7 @@
>>   #include<linux/input/matrix_keypad.h>
>>   #include<linux/spi/spi.h>
>>   #include<linux/wl12xx.h>
>> +#include<linux/spi/tsc2005.h>
>>   #include<linux/i2c.h>
>>   #include<linux/i2c/twl.h>
>>   #include<linux/clk.h>
>> @@ -56,6 +57,9 @@
>>   #define RX51_FMTX_IRQ			53
>>   #define RX51_LP5523_CHIP_EN_GPIO	41
>>
>> +#define RX51_TSC2005_RESET_GPIO		104
>> +#define RX51_TSC2005_IRQ_GPIO		100
>> +
>>   #define RX51_USB_TRANSCEIVER_RST_GPIO	67
>>
>>   /* list all spi devices here */
>> @@ -146,6 +150,17 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
>>   	.single_channel	= 1,
>>   };
>>
>> +static struct tsc2005_platform_data tsc2005_pdata = {
>> +	.ts_pressure_max	= 2048,
>> +	.ts_pressure_fudge	= 2,
>> +	.ts_x_max		= 4096,
>> +	.ts_x_fudge		= 4,
>> +	.ts_y_max		= 4096,
>> +	.ts_y_fudge		= 4,
>> +	.ts_x_plate_ohm		= 320,
>> +	.esd_timeout_ms		= 8000,
>> +};
>> +
>>   static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
>>   	[RX51_SPI_WL1251] = {
>>   		.modalias		= "wl1251",
>> @@ -167,10 +182,10 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
>>   		.modalias		= "tsc2005",
>>   		.bus_num		= 1,
>>   		.chip_select		= 0,
>> -		/* .irq = OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),*/
>> +		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
>>   		.max_speed_hz		= 6000000,
>>   		.controller_data	=&tsc2005_mcspi_config,
>> -		/* .platform_data =&tsc2005_config,*/
>> +		.platform_data		=&tsc2005_pdata,
>>   	},
>>   };
>>
>> @@ -1086,6 +1101,31 @@ error:
>>   	 */
>>   }
>>
>> +static void rx51_tsc2005_set_reset(bool enable)
>> +{
>> +	gpio_set_value(RX51_TSC2005_RESET_GPIO, enable);
>> +}
>> +
>> +static void __init rx51_init_tsc2005(void)
>> +{
>> +	int r;
>> +
>> +	r = gpio_request(RX51_TSC2005_IRQ_GPIO, "tsc2005 IRQ");
>> +	if (r>= 0)
>> +		gpio_direction_input(RX51_TSC2005_IRQ_GPIO);
>> +	else
>> +		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 IRQ");
>> +
>> +	r = gpio_request(RX51_TSC2005_RESET_GPIO, "tsc2005 reset");
>> +	if (r>= 0) {
>> +		gpio_direction_output(RX51_TSC2005_RESET_GPIO, 1);
>> +		tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
>> +	} else {
>> +		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
>> +		tsc2005_pdata.esd_timeout_ms = 0;
>> +	}
>
> I would suggest using gpio_request_array() here,
> or if those pins are independent from each other, for some reason,
> then gpio_request_one() would do.

These pins are actually independent, but I agree that it would be 
simpler and therefore better to use gpio_request_array() here.

> Also, don't you need to setup the mux for these GPIOs?
> Or is it done in some other place (like bootloader)?

I presume it's done in the original bootloader, however it won't harm to 
add explicit pin mux definitions.

>> +}
>> +
>>   void __init rx51_peripherals_init(void)
>>   {
>>   	rx51_i2c_init();
>> @@ -1094,6 +1134,7 @@ void __init rx51_peripherals_init(void)
>>   	board_smc91x_init();
>>   	rx51_add_gpio_keys();
>>   	rx51_init_wl1251();
>> +	rx51_init_tsc2005();
>>   	rx51_init_si4713();
>>   	spi_register_board_info(rx51_peripherals_spi_board_info,
>>   				ARRAY_SIZE(rx51_peripherals_spi_board_info));
>

--
With best wishes,
Vladimir
