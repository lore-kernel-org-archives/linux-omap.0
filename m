From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v5 1/5] ARM: l2x0/pl310: Refactor Kconfig to be more
 maintainable
Date: Fri, 16 Dec 2011 17:54:55 +0800
Message-ID: <20111216095454.GD3519@S2100-06.ap.freescale.net>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
 <1323964434-6764-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323964434-6764-2-git-send-email-dave.martin@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <avorontsov@mvista.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Colin Cross <ccross@google.com>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, John Linn <john.linn@xilinx.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2011 at 03:53:50PM +0000, Dave Martin wrote:
> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms have a L2x0 or
> PL310 cache controller to the individual machines.  To enable this,
> a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
> machines to indicate that they may have such a cache controller
> independently of each other.
> 
> Boards/SoCs which cannot reliably operate without the L2 cache
> controller support will need to select CACHE_L2X0 directly from
> their own Kconfigs instead.  This applies to some TrustZone-enabled
> boards where Linux runs in the Normal World, for example.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
>         (for cns3xxx)
> Acked-by: Tony Lindgren <tony@atomide.com>
>         (for omap)
> ---
[...]
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index b3a1f2b..b30708e 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -20,6 +20,7 @@ config ARCH_IMX_V6_V7
>  	bool "i.MX3, i.MX6"
>  	select AUTO_ZRELADDR if !ZBOOT_ROM
>  	select ARM_PATCH_PHYS_VIRT
> +	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  This enables support for systems based on the Freescale i.MX3 and i.MX6
>  	  family.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
