From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: add missing ARCH_HAS_OPP
Date: Wed, 29 Jan 2014 07:27:15 -0600
Message-ID: <52E901B3.5070307@ti.com>
References: <1389816038-17363-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbaA2N1m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jan 2014 08:27:42 -0500
In-Reply-To: <1389816038-17363-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nikhil.nd@ti.com, t-kristo@ti.com, Nishanth Menon <nm@ti.com>

Hi Tony,
On 01/15/2014 02:00 PM, Nishanth Menon wrote:
> OMAP5, DRA7, AM43xx all have OPPs. So select the same to allow SoC
> only configuration boot to work with OPP.
> 
> Reported-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> For DRA7, depends on: https://patchwork.kernel.org/patch/3465411/

Considering that dependent patch is now on linus master,
a gentle ping -> The patch does apply on latest linus master commit
0e47c969c65e213421450c31043353ebe3c67e0c

patchworks reference: https://patchwork.kernel.org/patch/3493581/

> 
>  arch/arm/mach-omap2/Kconfig |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 35c23e5..66a9c4a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -50,6 +50,7 @@ config SOC_OMAP5
>  	bool "TI OMAP5"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> +	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select ARM_GIC
>  	select CPU_V7
> @@ -63,6 +64,7 @@ config SOC_AM33XX
>  	bool "TI AM33XX"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> +	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select CPU_V7
>  	select MULTI_IRQ_HANDLER
> @@ -72,6 +74,7 @@ config SOC_AM43XX
>  	depends on ARCH_MULTI_V7
>  	select CPU_V7
>  	select ARCH_OMAP2PLUS
> +	select ARCH_HAS_OPP
>  	select MULTI_IRQ_HANDLER
>  	select ARM_GIC
>  	select MACH_OMAP_GENERIC
> @@ -80,6 +83,7 @@ config SOC_DRA7XX
>  	bool "TI DRA7XX"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> +	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select ARM_GIC
>  	select CPU_V7
> 


-- 
Regards,
Nishanth Menon
