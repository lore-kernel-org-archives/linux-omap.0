From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
Date: Wed, 13 Mar 2019 22:28:43 +0100
Message-ID: <9f6201c2-b62f-ac5d-a24b-a51da1b5e900@gmail.com>
References: <1552312598-25574-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552312598-25574-1-git-send-email-info@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: andrew@aj.id.au, hsweeten@visionengravers.com, kaloz@openwrt.org, khalasa@piap.pl, lkundrak@v3.sk, aaro.koskinen@iki.fi, tony@atomide.com, baohua@kernel.org, kgene@kernel.org, krzk@kernel.org, linux@prisktech.co.nz, mcuos.com@gmail.com, matthias.bgg@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

On 11/03/2019 14:56, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/arm/Kconfig              | 24 +++++++++++-----------
>  arch/arm/mach-aspeed/Kconfig  | 10 ++++-----
>  arch/arm/mach-ep93xx/Kconfig  |  8 ++++----
>  arch/arm/mach-hisi/Kconfig    | 14 ++++++-------
>  arch/arm/mach-ixp4xx/Kconfig  | 32 ++++++++++++++---------------
>  arch/arm/mach-mmp/Kconfig     |  2 +-
>  arch/arm/mach-omap1/Kconfig   | 36 ++++++++++++++++----------------
>  arch/arm/mach-omap2/Kconfig   | 12 +++++------
>  arch/arm/mach-prima2/Kconfig  |  6 +++---
>  arch/arm/mach-s3c24xx/Kconfig | 32 ++++++++++++++---------------
>  arch/arm/mach-s3c64xx/Kconfig | 16 +++++++--------
>  arch/arm/mach-sa1100/Kconfig  |  4 ++--
>  arch/arm/mach-vt8500/Kconfig  |  6 +++---
>  arch/arm/mach-w90x900/Kconfig |  6 +++---
>  arch/arm/mm/Kconfig           | 48 +++++++++++++++++++++----------------------
>  arch/arm/plat-samsung/Kconfig | 26 +++++++++++------------
>  16 files changed, 140 insertions(+), 142 deletions(-)
> 

[...]

> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index c095236..597ea24 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -125,10 +125,10 @@ config MACH_MICRO9S
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

For EP93xx part:
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

It makes no sense to split the patch, one of the ARM maintainers
shall decide on this patch anyway. In my personal opinion such a patch
makes little sense if it's not tree-wide.

--
Regards,
Alexander.
