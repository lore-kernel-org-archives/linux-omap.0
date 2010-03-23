From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH 1/5] OMAP: RX51: Add LCD Panel support
Date: Tue, 23 Mar 2010 15:55:39 +0200
Message-ID: <4BA8C85B.1030606@nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com> <1269338191-10734-2-git-send-email-roger.quadros@nokia.com> <E0D41E29EB0DAC4E9F3FF173962E9E94026F1D1D6C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48207 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab0CWN4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 09:56:15 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F1D1D6C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

ext G, Manjunath Kondaiah wrote:
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Roger Quadros
>> Sent: Tuesday, March 23, 2010 3:26 PM
>> To: tony@atomide.com
>> Cc: Tomi.Valkeinen@nokia.com; linux-omap@vger.kernel.org; 
>> linux-fbdev@vger.kernel.org
>> Subject: [PATCH 1/5] OMAP: RX51: Add LCD Panel support
>>
>> From: Roger Quadros <roger.quadros@nokia.com>
>>
>> Adds basic support for LCD Panel on Nokia N900
>>
>> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
>> ---
>>  arch/arm/mach-omap2/Makefile                 |    1 +
>>  arch/arm/mach-omap2/board-rx51-peripherals.c |   13 ++++
>>  arch/arm/mach-omap2/board-rx51-video.c       |   95 
>> ++++++++++++++++++++++++++
>>  3 files changed, 109 insertions(+), 0 deletions(-)  create 
>> mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile 
>> b/arch/arm/mach-omap2/Makefile index 4b9fc57..b03cbb4 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -122,6 +122,7 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)		
>> += board-n8x0.o
>>  obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
>>  					   board-rx51-sdram.o \
>>  					   board-rx51-peripherals.o \
>> +					   board-rx51-video.o \
>>  					   hsmmc.o
>>  obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
>>  					   board-zoom-peripherals.o \
>> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c 
>> b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> index 4377a4c..f404537 100644
>> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
>> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> @@ -45,6 +45,7 @@
>>  /* list all spi devices here */
>>  enum {
>>  	RX51_SPI_WL1251,
>> +	RX51_SPI_MIPID,		/* LCD panel */
>>  };
>>  
>>  static struct wl12xx_platform_data wl1251_pdata; @@ -54,6 
>> +55,11 @@ static struct omap2_mcspi_device_config 
>> wl1251_mcspi_config = {
>>  	.single_channel	= 1,
>>  };
>>  
>> +static struct omap2_mcspi_device_config mipid_mcspi_config = {
>> +	.turbo_mode	= 0,
> 
> Any specific reason for not enabling turbo mode? 
> It will increase throughput if it is configured in single channel mode.
> 
No specific reason. That was the original configuration, in previous versions of 
the code. It shouldn't make much difference as mipid is only used for panel
detection, enable/disable, and backlight control. Need to test if it works with 
turbo mode.

>> +	.single_channel	= 1,
>> +};
>> +
>>  static struct spi_board_info 
>> rx51_peripherals_spi_board_info[] __initdata = {
>>  	[RX51_SPI_WL1251] = {
>>  		.modalias		= "wl1251",

>> +static int __init rx51_video_init(void) {
>> +	if (!machine_is_nokia_rx51())
>> +		return 0;
>> +
>> +	if (omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT)) {
>> +		pr_err("%s cannot configure MUX for LCD 
>> RESET\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	if (gpio_request(RX51_LCD_RESET_GPIO, "LCD ACX565AKM reset")) {
>> +		pr_err("%s failed to get LCD Reset GPIO\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
>> +
>> +	platform_add_devices(rx51_video_devices,
>> +				ARRAY_SIZE(rx51_video_devices));
>> +	return 0;
>> +}
> 
> Since this functional always returns 0, you can make return value of this 
> function as void.
> 

I guess it is better to return non zero on failure paths then.

thanks.
-roger
