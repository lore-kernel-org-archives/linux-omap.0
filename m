From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Devkit8000: Add DDC i2c_bus_num
Date: Fri, 14 Dec 2012 09:21:11 -0800
Message-ID: <20121214172111.GQ4989@atomide.com>
References: <1353003123-7335-1-git-send-email-thomas@tomweber.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353003123-7335-1-git-send-email-thomas@tomweber.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <thomas@tomweber.eu>
Cc: Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "moderated list:ARM SUB-ARCHITECT..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Thomas Weber <thomas@tomweber.eu> [121115 10:14]:
> Add i2c bus number for DVI output.
> The driver uses this to detect if a panel is connected and to read EDID.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> Signed-off-by: Thomas Weber <thomas@tomweber.eu>
> ---
>  arch/arm/mach-omap2/board-devkit8000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index 1fd161e..6f04f0f 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -139,6 +139,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
>  
>  static struct tfp410_platform_data dvi_panel = {
>  	.power_down_gpio	= -1,
> +	.i2c_bus_num		= 1,
>  };
>  
>  static struct omap_dss_device devkit8000_dvi_device = {
> -- 
> 1.8.0
> 
