From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
Date: Fri, 1 Apr 2016 17:12:26 +0530
Message-ID: <20160401114226.GD2987@vireshk-i7>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
 <1459510156-9147-2-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459510156-9147-2-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon@ti.com, heiko@sntech.de, maxime.ripard@free-electrons.com, wens@csie.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, cpgs@samsung.com
List-Id: linux-omap@vger.kernel.org

On 01-04-16, 16:59, Vivek Gautam wrote:
> mach-spear enables PHY_ST_SPEAR1310_MIPHY and
> PHY_ST_SPEAR1340_MIPHY, which now fall under PHY_PLAT
> config. So select CONFIG_PHY_PLAT as well to resolve
> dependencies.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> ---
>  arch/arm/mach-spear/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
> index ea9ea95..c0a62fd 100644
> --- a/arch/arm/mach-spear/Kconfig
> +++ b/arch/arm/mach-spear/Kconfig
> @@ -29,6 +29,7 @@ if ARCH_SPEAR13XX
>  config MACH_SPEAR1310
>  	bool "SPEAr1310 Machine support with Device Tree"
>  	select PINCTRL_SPEAR1310
> +	select PHY_PLAT
>  	select PHY_ST_SPEAR1310_MIPHY
>  	help
>  	  Supports ST SPEAr1310 machine configured via the device-tree
> @@ -36,6 +37,7 @@ config MACH_SPEAR1310
>  config MACH_SPEAR1340
>  	bool "SPEAr1340 Machine support with Device Tree"
>  	select PINCTRL_SPEAR1340
> +	select PHY_PLAT
>  	select PHY_ST_SPEAR1340_MIPHY
>  	help
>  	  Supports ST SPEAr1340 machine configured via the device-tree

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
