From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Update the Kconfig entry for omap-bl
Date: Thu, 24 May 2007 17:31:21 -0700
Message-ID: <20070525003121.GC19506@atomide.com>
References: <fb249edb0705221020t271c2229m78808edfed2cb3d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0705221020t271c2229m78808edfed2cb3d2@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [070522 10:25]:
> - CONFIG_BACKLIGHT_DEVICE now became CONFIG_BACKLIGHT_CLASS_DEVICE.
> - Re-add OMAPBL_MAX_INTENSITY usage that was removed in last commit
> and the macro became unused.
>
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

> From feb798039e5c6e06f64556ad482dbbd021153a1b Mon Sep 17 00:00:00 2001
> From: Andrzej Zaborowski <balrog@zabor.org>
> Date: Tue, 22 May 2007 19:59:11 +0200
> Subject: [PATCH] OMAP: Update omap-bl Kconfig entry.
> 
>  - CONFIG_BACKLIGHT_DEVICE is now CONFIG_BACKLIGHT_CLASS_DEVICE.
>  - Re-add OMAPBL_MAX_INTENSITY usage that became unused after last commit.
> ---
>  drivers/video/backlight/Kconfig   |    2 +-
>  drivers/video/backlight/omap_bl.c |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 33d71c1..b705415 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -58,7 +58,7 @@ config BACKLIGHT_HP680
>  
>  config BACKLIGHT_OMAP
>  	tristate "OMAP LCD Backlight"
> -	depends on BACKLIGHT_DEVICE && (ARCH_OMAP1 || ARCH_OMAP2)
> +	depends on BACKLIGHT_CLASS_DEVICE && (ARCH_OMAP1 || ARCH_OMAP2)
>  	default y
>  	help
>  	  This driver controls the LCD backlight level and power
> diff --git a/drivers/video/backlight/omap_bl.c b/drivers/video/backlight/omap_bl.c
> index a9532fd..3249bf8 100644
> --- a/drivers/video/backlight/omap_bl.c
> +++ b/drivers/video/backlight/omap_bl.c
> @@ -170,6 +170,7 @@ static int omapbl_probe(struct platform_device *pdev)
>  	omap_cfg_reg(PWL);	/* Conflicts with UART3 */
>  
>  	dev->props.fb_blank = FB_BLANK_UNBLANK;
> +	dev->props.max_brightness = OMAPBL_MAX_INTENSITY;
>  	dev->props.brightness = pdata->default_intensity;
>  	omapbl_update_status(dev);

Pushing today.

Tony
