From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 5/6] memory: omap-gpmc: Enable omap-gpmc by default when
 dependency is met
Date: Thu, 9 Jun 2016 20:45:03 +0200
Message-ID: <20160609204503.46a33844@bbrezillon>
References: <1465491777-20033-1-git-send-email-fcooper@ti.com>
	<1465491777-20033-6-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465491777-20033-6-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: tony@atomide.com, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu,  9 Jun 2016 12:02:56 -0500
Franklin S Cooper Jr <fcooper@ti.com> wrote:

> When dependencies are met enable OMAP GPMC by default. Later patches will
> prevent OMAP GPMC from being automatically selected by mach-omap2 Kconfig.
> Therefore, this will sure after that change the current behavior is still
> maintained when dependencies are met.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/memory/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 81ddb17..56a1c66 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -51,6 +51,7 @@ config TI_EMIF
>  
>  config OMAP_GPMC
>  	bool
> +	default y

	depends ARCH_OMAP2PLUS

>  	select GPIOLIB
>  	help
>  	  This driver is for the General Purpose Memory Controller (GPMC)



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
