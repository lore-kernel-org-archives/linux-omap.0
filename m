From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/5] OMAP: Zoom2: Release Dbg board detect gpio
Date: Fri, 28 Aug 2009 10:19:15 +0300
Message-ID: <87y6p41k3w.fsf@deeprootsystems.com>
References: <1250878280-10667-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53279 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbZH1HTS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 03:19:18 -0400
Received: by bwz19 with SMTP id 19so1436421bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 00:19:19 -0700 (PDT)
In-Reply-To: <1250878280-10667-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Fri\, 21 Aug 2009 13\:11\:20 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Vikram Pandita <vikram.pandita@ti.com> writes:

> Release the Dbg board detection gpio once its purpose is served
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Looks fine, I'll pull into my fixes queue.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> index 4dd714d..d80e448 100644
> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> @@ -130,6 +130,7 @@ static inline void __init zoom2_init_quaduart(void)
>  static inline int omap_zoom2_debugboard_detect(void)
>  {
>  	int debug_board_detect = 0;
> +	int ret = 1;
>  
>  	debug_board_detect = ZOOM2_SMSC911X_GPIO;
>  
> @@ -141,10 +142,10 @@ static inline int omap_zoom2_debugboard_detect(void)
>  	gpio_direction_input(debug_board_detect);
>  
>  	if (!gpio_get_value(debug_board_detect)) {
> -		gpio_free(debug_board_detect);
> -		return 0;
> +		ret = 0;
>  	}
> -	return 1;
> +	gpio_free(debug_board_detect);
> +	return ret;
>  }
>  
>  static struct platform_device *zoom2_devices[] __initdata = {
> -- 
> 1.6.3.3.334.g916e1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
