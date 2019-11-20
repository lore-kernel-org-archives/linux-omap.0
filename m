From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH] ARM: Fix Kconfig indentation
Date: Wed, 20 Nov 2019 19:23:58 +0100
Message-ID: <20191120192358.389c43da67a4d07c0d19b90d@gmail.com>
References: <20191120133734.12345-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120133734.12345-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Hartley Sweeten <hsweeten@visionengravers.com>, Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Lubomir Rintel <lkundrak@v3.sk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Barry Song <baohua@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Krzysztof,

for the EP93xx part,

On Wed, 20 Nov 2019 21:37:34 +0800
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/Kconfig-nommu        | 10 +++++-----
>  arch/arm/Kconfig.debug        |  4 ++--
>  arch/arm/mach-ep93xx/Kconfig  |  8 ++++----
>  arch/arm/mach-ixp4xx/Kconfig  | 16 ++++++++--------
>  arch/arm/mach-mmp/Kconfig     |  2 +-
>  arch/arm/mach-omap1/Kconfig   | 14 +++++++-------
>  arch/arm/mach-prima2/Kconfig  |  6 +++---
>  arch/arm/mach-s3c24xx/Kconfig |  4 ++--
>  arch/arm/mach-s3c64xx/Kconfig |  6 +++---
>  arch/arm/plat-samsung/Kconfig |  2 +-
>  10 files changed, 36 insertions(+), 36 deletions(-)
> 

[...]

> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index f2db5fd38145..bf81dfab7f1b 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -126,10 +126,10 @@ config MACH_MICRO9S
>  	  Contec Micro9-Slim board.
>  
>  config MACH_SIM_ONE
> -        bool "Support Simplemachines Sim.One board"
> -        help
> -          Say 'Y' here if you want your kernel to support the
> -          Simplemachines Sim.One board.
> +	bool "Support Simplemachines Sim.One board"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Simplemachines Sim.One board.
>  
>  config MACH_SNAPPER_CL15
>  	bool "Support Bluewater Systems Snapper CL15 Module"


-- 
Alexander Sverdlin.
