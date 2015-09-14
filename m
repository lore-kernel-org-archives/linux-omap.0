From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: make PCF857x built-in
Date: Mon, 14 Sep 2015 12:09:39 -0700
Message-ID: <20150914190938.GW4215@atomide.com>
References: <1438782229-25118-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438782229-25118-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150805 06:47]:
> One of the lines from PCF857x is connected to the vdd line of MMC1
> in DRA74x and DRA72x EVMs and is modelled as a regulator. If PCF857x
> is not made as built-in, the regulator_get in omap_hsmmc fails making
> it difficult to use MMC1 as rootfs.
> 
> Make PCF857x built-in.

OK applying as it's a common boot device. But once we're done with
the legacy code removal and initcall clean-up, let's plan on making
everything modular and using a initramfs. People can still change
their .config files to have things built in and the modular .config
should be usable as is for distros.

Regards,

Tony
 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index ac521e7..7cedfe9 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -236,7 +236,7 @@ CONFIG_SSI_PROTOCOL=m
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_GPIO_SYSFS=y
> -CONFIG_GPIO_PCF857X=m
> +CONFIG_GPIO_PCF857X=y
>  CONFIG_GPIO_TWL4030=y
>  CONFIG_GPIO_PALMAS=y
>  CONFIG_W1=m
> -- 
> 1.7.9.5
> 
