From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mfd: Combine MFD_SUPPORT and MFD_CORE
Date: Thu, 15 Sep 2011 11:16:34 -0600
Message-ID: <20110915171634.GD3523@ponder.secretlab.ca>
References: <20110829102732.03f0f05d.rdunlap@xenotime.net>
 <1314643307-17780-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314643307-17780-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, matti.j.aaltonen@nokia.com, johannes@sipsolutions.net, linux-kernel@vger.kernel.org, sameo@linux.intel.com, mchehab@infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 29, 2011 at 09:41:47PM +0300, Luciano Coelho wrote:
> ---
> @@ -417,7 +417,6 @@ config GPIO_TIMBERDALE
>  config GPIO_RDC321X
>  	tristate "RDC R-321x GPIO support"
>  	depends on PCI
> -	select MFD_SUPPORT
>  	select MFD_CORE
>  	select MFD_RDC321X
>  	help
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 21574bd..1836cdf 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2,10 +2,9 @@
>  # Multifunction miscellaneous devices
>  #
>  
> -menuconfig MFD_SUPPORT
> -	bool "Multifunction device drivers"
> +menuconfig MFD_CORE
> +	tristate "Multifunction device drivers"
>  	depends on HAS_IOMEM
> -	default y

Looks like there is a bug here.  Kconfig symbols with dependencies
(HAS_IOMEM) must not ever be selected by other symbols because Kconfig
doesn't implement a way to resolve them.  This patch means that every
"select MFD_CORE" just assumes that HAS_IOMEM is also selected.

g.
