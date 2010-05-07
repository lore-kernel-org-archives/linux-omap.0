From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCHv3 1/5] OMAP: RX51: Add LCD Panel support
Date: Fri, 07 May 2010 10:03:57 +0300
Message-ID: <4BE3BB5D.2000105@nokia.com>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>	<1271333181-23609-2-git-send-email-roger.quadros@nokia.com> <87hbmkvqb5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33007 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0EGHET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 03:04:19 -0400
In-Reply-To: <87hbmkvqb5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Kevin,

ext Kevin Hilman wrote:
> Roger Quadros <roger.quadros@nokia.com> writes:
> 
>> From: Roger Quadros <roger.quadros@nokia.com>
>>
>> Adds basic support for LCD Panel on Nokia N900
>>
>> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
> 
> Just noticed a compile problem here...
> 
> [...]
> 
>> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
> 
> [...]
> 
>> +void __init rx51_video_mem_init(void)
>> +{
>> +	/*
>> +	 * GFX 864x480x32bpp
>> +	 * VID1/2 1280x720x32bpp double buffered
>> +	 */
>> +	omap_vram_set_sdram_vram(PAGE_ALIGN(864 * 480 * 4) +
>> +			2 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
>> +}
>> +
>> +#endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
> 
> This function is available conditionally based on the #ifdefs, but...
> 
>> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
>> index b155c36..1b86b5b 100644
>> --- a/arch/arm/mach-omap2/board-rx51.c
>> +++ b/arch/arm/mach-omap2/board-rx51.c
>> @@ -36,6 +36,7 @@
>>  #define RX51_GPIO_SLEEP_IND 162
>>  
>>  struct omap_sdrc_params *rx51_get_sdram_timings(void);
>> +extern void rx51_video_mem_init(void);
>>  
>>  static struct gpio_led gpio_leds[] = {
>>  	{
>> @@ -143,6 +144,7 @@ static void __init rx51_init(void)
>>  static void __init rx51_map_io(void)
>>  {
>>  	omap2_set_globals_343x();
>> +	rx51_video_mem_init();
> 
> ... here it is always called, giving a compiler error when building
> without FB support.

Thanks for pointing this out. will send another revision for this patch.

cheers,
-roger
