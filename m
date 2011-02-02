From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: Kconfig: allow OMAP to use sparse IRQ
 numbering
Date: Wed, 2 Feb 2011 12:20:26 -0800
Message-ID: <20110202202026.GH3322@atomide.com>
References: <1296664315-32108-1-git-send-email-balbi@ti.com>
 <1296664315-32108-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296664315-32108-3-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [110202 08:31]:
> Select HAVE_SPARSE_IRQ to allow OMAP to use
> sparse IRQ numbering scheme. The main difference
> is that irq_descs will be added to a radix tree
> instead of a static array.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Assuming these two will go through Russell's tree:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 09a5c11..2ca24ad 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -857,6 +857,7 @@ config ARCH_DAVINCI
>  config ARCH_OMAP
>  	bool "TI OMAP"
>  	select HAVE_CLK
> +	select HAVE_SPARSE_IRQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_CPUFREQ
>  	select GENERIC_CLOCKEVENTS
> -- 
> 1.7.4.rc2
> 
