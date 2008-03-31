From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] i2c: Update twl4030's includes
Date: Mon, 31 Mar 2008 11:54:36 +0300
Message-ID: <20080331085436.GA4467@kedavra.cpe.vivax.com.br>
References: <1206817219-22322-1-git-send-email-francisco.alecrim@indt.org.br>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45650 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbYCaIw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 04:52:29 -0400
Content-Disposition: inline
In-Reply-To: <1206817219-22322-1-git-send-email-francisco.alecrim@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <francisco.alecrim@indt.org.br>
Cc: linux-omap@vger.kernel.org

On Sat, Mar 29, 2008 at 09:00:19PM +0200, Francisco Alecrim wrote:
> Update twl4030's includes. Headers now available under include/linux/i2c.
> 
> arch/arm/mach-omap2/board-2430sdp.c:41:34: error: asm/arch/twl4030-rtc.h: No such file or directory
> drivers/video/omap/lcd_2430sdp.c:30:30: error: asm/arch/twl4030.h: No such file or directory
> 
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>

Good catch, thanks.
Stupid grep not working :-p

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    2 +-
>  drivers/video/omap/lcd_2430sdp.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index c2d3c4d..5228d29 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -24,6 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/i2c/twl4030-rtc.h>
>  
>  #include <asm/hardware.h>
>  #include <asm/mach-types.h>
> @@ -38,7 +39,6 @@
>  #include <asm/arch/keypad.h>
>  #include <asm/arch/gpmc.h>
>  #include <asm/arch/mcspi.h>
> -#include <asm/arch/twl4030-rtc.h>
>  
>  #include <asm/io.h>
>  
> diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
> index 2464e85..8ba15dc 100644
> --- a/drivers/video/omap/lcd_2430sdp.c
> +++ b/drivers/video/omap/lcd_2430sdp.c
> @@ -23,11 +23,11 @@
>  
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/i2c/twl4030.h>
>  
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/mux.h>
>  #include <asm/arch/omapfb.h>
> -#include <asm/arch/twl4030.h>
>  #include <asm/mach-types.h>
>  
>  #define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
> -- 
> 1.5.4.23.gef5b9
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
