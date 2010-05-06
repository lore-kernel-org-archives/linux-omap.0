From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 1/5] OMAP: RX51: Add LCD Panel support
Date: Thu, 06 May 2010 11:27:26 -0700
Message-ID: <87hbmkvqb5.fsf@deeprootsystems.com>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
	<1271333181-23609-2-git-send-email-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52343 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0EFS1j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 14:27:39 -0400
In-Reply-To: <1271333181-23609-2-git-send-email-roger.quadros@nokia.com> (Roger Quadros's message of "Thu\, 15 Apr 2010 15\:06\:17 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: Tomi.Valkeinen@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Roger Quadros <roger.quadros@nokia.com> writes:

> From: Roger Quadros <roger.quadros@nokia.com>
>
> Adds basic support for LCD Panel on Nokia N900
>
> Signed-off-by: Roger Quadros <roger.quadros@nokia.com>

Just noticed a compile problem here...

[...]

> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c

[...]

> +void __init rx51_video_mem_init(void)
> +{
> +	/*
> +	 * GFX 864x480x32bpp
> +	 * VID1/2 1280x720x32bpp double buffered
> +	 */
> +	omap_vram_set_sdram_vram(PAGE_ALIGN(864 * 480 * 4) +
> +			2 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
> +}
> +
> +#endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */

This function is available conditionally based on the #ifdefs, but...

> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index b155c36..1b86b5b 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -36,6 +36,7 @@
>  #define RX51_GPIO_SLEEP_IND 162
>  
>  struct omap_sdrc_params *rx51_get_sdram_timings(void);
> +extern void rx51_video_mem_init(void);
>  
>  static struct gpio_led gpio_leds[] = {
>  	{
> @@ -143,6 +144,7 @@ static void __init rx51_init(void)
>  static void __init rx51_map_io(void)
>  {
>  	omap2_set_globals_343x();
> +	rx51_video_mem_init();

... here it is always called, giving a compiler error when building
without FB support.

Kevin


