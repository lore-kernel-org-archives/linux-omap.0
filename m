From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ARM: config: Remove left-over BACKLIGHT_LCD_SUPPORT
Date: Tue, 4 Jun 2019 09:58:02 +0100
Message-ID: <20190604085802.GB23250@e107533-lin.cambridge.arm.com>
References: <1559633061-28003-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559633061-28003-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arm@kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>, Sudeep Holla <sudeep.holla@arm.co>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 04, 2019 at 09:24:21AM +0200, Krzysztof Kozlowski wrote:
> The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
> ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
> symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
> available directly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Change also mini2440_defconfig.
> ---
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index 484d77a7f589..d170da388389 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -86,7 +86,6 @@ CONFIG_DRM_PANEL_SIMPLE=y
>  CONFIG_DRM_SII902X=y
>  CONFIG_DRM_PL111=y
>  CONFIG_FB_MODE_HELPERS=y
> -CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
>  CONFIG_LOGO=y
>  # CONFIG_LOGO_LINUX_MONO is not set

For vexpress,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
