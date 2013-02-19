From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 5/8] ARM: OMAP2+: am43: Kconfig
Date: Tue, 19 Feb 2013 15:57:07 +0530
Message-ID: <5123537B.8050709@ti.com>
References: <cover.1361186097.git.afzal@ti.com> <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
> Add Kconfig option for AM43 family of SoC's, these are ARM Cortex A9
> based (SMP configuration with 1 core).
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>   arch/arm/mach-omap2/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 49ac3df..683fbaa 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -141,6 +141,17 @@ config SOC_AM33XX
>   	select MULTI_IRQ_HANDLER
>   	select COMMON_CLK
>
> +config SOC_AM43
> +	bool "TI AM43"
> +	depends on ARCH_OMAP2PLUS
> +	default y
> +	select CPU_V7
> +	select HAVE_SMP
You don't need this
> +	select LOCAL_TIMERS if SMP
This one as well

> +	select MULTI_IRQ_HANDLER
And this one too I guess.

Rest is fine.

regards,
Santosh
