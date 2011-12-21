From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] OMAP2+: ads7846_init: put gpio_pendown into pdata if
 it's provided
Date: Wed, 21 Dec 2011 19:22:38 +0200
Message-ID: <4EF215DE.8060002@compulab.co.il>
References: <1324485086-31410-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090005060607030204050504"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:47364
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752554Ab1LURWr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Dec 2011 12:22:47 -0500
In-Reply-To: <1324485086-31410-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

This is a multi-part message in MIME format.
--------------090005060607030204050504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Ilya,

Please, Cc the linux-arm-kernel@lists.infradead.org for patches,
so Tony, or whoever will not need to resend them...

On 12/21/11 18:31, Ilya Yanok wrote:
> If platform data is provided by the caller gpio_pendown is put into
> unused static ads7846_config structure and effectively has no effect.
> Of course caller can set gpio_pendown field in platform data himself
> but it seems natural to do this in ads7846_init to remove duplication.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/arm/mach-omap2/common-board-devices.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index 2d1d775..eb408dd 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -75,7 +75,10 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>  			gpio_set_debounce(gpio_pendown, gpio_debounce);
>  	}
>  
> -	ads7846_config.gpio_pendown = gpio_pendown;
> +	if (!board_pdata)
> +		ads7846_config.gpio_pendown = gpio_pendown;
> +	else
> +		board_pdata->gpio_pendown = gpio_pendown;
>  
>  	spi_bi->bus_num	= bus_num;
>  	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);

The fact that the ads7846_config has no effect in case
the board_pdata is provided does not really meter...
How about reusing the existing "if" instead of adding another one?
Like in the attached patch?


-- 
Regards,
Igor.

--------------090005060607030204050504
Content-Type: text/x-patch;
 name="touch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="touch.patch"

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 94ccf46..e8a7368 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -102,8 +102,10 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
 
-	if (board_pdata)
+	if (board_pdata) {
+		board_pdata->gpio_pendown = gpio_pendown;
 		spi_bi->platform_data = board_pdata;
+	}
 
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }

--------------090005060607030204050504--
