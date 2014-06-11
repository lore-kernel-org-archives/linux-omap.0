From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] [media] staging: allow omap4iss to be modular
Date: Wed, 11 Jun 2014 09:42:04 -0500
Message-ID: <53986ABC.4070302@ti.com>
References: <5192928.MkINji4uKU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <5192928.MkINji4uKU@wuerfel>
Sender: linux-media-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org
Cc: Tony Lindgren <tony@atomide.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.orgLaurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

On 06/11/2014 09:35 AM, Arnd Bergmann wrote:
> The OMAP4 camera support depends on I2C and VIDEO_V4L2, both
> of which can be loadable modules. This causes build failures
> if we want the camera driver to be built-in.
> 
> This can be solved by turning the option into "tristate",
> which unfortunately causes another problem, because the
> driver incorrectly calls a platform-internal interface
> for omap4_ctrl_pad_readl/omap4_ctrl_pad_writel.
> To work around that, we can export those symbols, but
> that isn't really the correct solution, as we should not
> have dependencies on platform code this way.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is one of just two patches we currently need to get
> 'make allmodconfig' to build again on ARM.
> 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 751f354..05d2d98 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -190,11 +190,13 @@ u32 omap4_ctrl_pad_readl(u16 offset)
>  {
>  	return readl_relaxed(OMAP4_CTRL_PAD_REGADDR(offset));
>  }
> +EXPORT_SYMBOL_GPL(omap4_ctrl_pad_readl);
>  
>  void omap4_ctrl_pad_writel(u32 val, u16 offset)
>  {
>  	writel_relaxed(val, OMAP4_CTRL_PAD_REGADDR(offset));
>  }
> +EXPORT_SYMBOL_GPL(omap4_ctrl_pad_writel);
>  
>  #ifdef CONFIG_ARCH_OMAP3
>  
> diff --git a/drivers/staging/media/omap4iss/Kconfig b/drivers/staging/media/omap4iss/Kconfig
> index 78b0fba..0c3e3c1 100644
> --- a/drivers/staging/media/omap4iss/Kconfig
> +++ b/drivers/staging/media/omap4iss/Kconfig
> @@ -1,5 +1,5 @@
>  config VIDEO_OMAP4
> -	bool "OMAP 4 Camera support"
> +	tristate "OMAP 4 Camera support"
>  	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && I2C && ARCH_OMAP4
>  	select VIDEOBUF2_DMA_CONTIG
>  	---help---
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

This was discussed in detail here:
http://marc.info/?t=140198692500001&r=1&w=2
Direct dependency from a staging driver to mach-omap2 driver is not
something we'd like, right?

-- 
Regards,
Nishanth Menon
