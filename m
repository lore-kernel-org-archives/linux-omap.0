From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH 1/5] OMAP: RX51: Add LCD Panel support
Date: Tue, 23 Mar 2010 13:20:37 +0200
Message-ID: <4BA8A405.8000307@nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>	 <1269338191-10734-2-git-send-email-roger.quadros@nokia.com> <74d0deb31003230312x1b1160b5v75f182fd3db8ac25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47343 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab0CWLVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 07:21:30 -0400
In-Reply-To: <74d0deb31003230312x1b1160b5v75f182fd3db8ac25@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext pHilipp Zabel <philipp.zabel@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

ext pHilipp Zabel wrote:
> On Tue, Mar 23, 2010 at 10:56 AM, Roger Quadros <roger.quadros@nokia.com> wrote:
>> From: Roger Quadros <roger.quadros@nokia.com>
>>
>> Adds basic support for LCD Panel on Nokia N900
>>
>> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
>> ---
>>  arch/arm/mach-omap2/Makefile                 |    1 +
>>  arch/arm/mach-omap2/board-rx51-peripherals.c |   13 ++++
>>  arch/arm/mach-omap2/board-rx51-video.c       |   95 ++++++++++++++++++++++++++
>>  3 files changed, 109 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> index 4b9fc57..b03cbb4 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -122,6 +122,7 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)               += board-n8x0.o
>>  obj-$(CONFIG_MACH_NOKIA_RX51)          += board-rx51.o \
>>                                           board-rx51-sdram.o \
>>                                           board-rx51-peripherals.o \
>> +                                          board-rx51-video.o \
>>                                           hsmmc.o
>>  obj-$(CONFIG_MACH_OMAP_ZOOM2)          += board-zoom2.o \
>>                                           board-zoom-peripherals.o \
>> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> index 4377a4c..f404537 100644
>> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
>> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> @@ -45,6 +45,7 @@
>>  /* list all spi devices here */
>>  enum {
>>        RX51_SPI_WL1251,
>> +       RX51_SPI_MIPID,         /* LCD panel */
>>  };
>>
>>  static struct wl12xx_platform_data wl1251_pdata;
>> @@ -54,6 +55,11 @@ static struct omap2_mcspi_device_config wl1251_mcspi_config = {
>>        .single_channel = 1,
>>  };
>>
>> +static struct omap2_mcspi_device_config mipid_mcspi_config = {
>> +       .turbo_mode     = 0,
>> +       .single_channel = 1,
>> +};
>> +
>>  static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
>>        [RX51_SPI_WL1251] = {
>>                .modalias               = "wl1251",
>> @@ -64,6 +70,13 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
>>                .controller_data        = &wl1251_mcspi_config,
>>                .platform_data          = &wl1251_pdata,
>>        },
>> +       [RX51_SPI_MIPID] = {
>> +               .modalias               = "acx565akm",
>> +               .bus_num                = 1,
>> +               .chip_select            = 2,
>> +               .max_speed_hz           = 6000000,
>> +               .controller_data        = &mipid_mcspi_config,
>> +       },
>>  };
>>
>>  #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
>> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
>> new file mode 100644
>> index 0000000..e3e22a8
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/board-rx51-video.c
>> @@ -0,0 +1,95 @@
>> +/*
>> + * linux/arch/arm/mach-omap2/board-rx51-peripherals.c
> 
> board-rx51-video.c
> 
yup. thanks :P

-roger
