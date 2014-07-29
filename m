From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable TI PIPE3 PHY driver
Date: Tue, 29 Jul 2014 02:01:21 -0700
Message-ID: <20140729090120.GJ29045@atomide.com>
References: <1406540737-9493-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406540737-9493-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140728 02:48]:
> This driver is needed by SATA, PCIe and USB modules on TI SoCs.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

You need to send this to arm@kernel.org to avoid conflicts.

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5348364..e411a37 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -368,6 +368,7 @@ CONFIG_PWM=y
>  CONFIG_PWM_TEGRA=y
>  CONFIG_PWM_VT8500=y
>  CONFIG_OMAP_USB2=y
> +CONFIG_TI_PIPE3=y
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_EXT4_FS=y
>  CONFIG_VFAT_FS=y
> -- 
> 1.8.3.2
> 
