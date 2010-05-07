From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Fri, 7 May 2010 13:33:08 -0700
Message-ID: <20100507203308.GO387@atomide.com>
References: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
 <1273248424-15943-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64328 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0EGUdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 16:33:12 -0400
Content-Disposition: inline
In-Reply-To: <1273248424-15943-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

* Benoit Cousson <b-cousson@ti.com> [100507 09:03]:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/Makefile      |    1 +
>  arch/arm/plat-omap/omap_device.c |   12 ++++++++++++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 98f0191..9405831 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>  # omap_device support (OMAP2+ only at the moment)
>  obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
>  obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> +obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 0f51974..b6144ff 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -90,6 +90,18 @@
>  #define USE_WAKEUP_LAT			0
>  #define IGNORE_WAKEUP_LAT		1
>  
> +/* XXX this should be moved into a separate file */
> +#if defined(CONFIG_ARCH_OMAP2420)
> +# define OMAP_32KSYNCT_BASE		0x48004000
> +#elif defined(CONFIG_ARCH_OMAP2430)
> +# define OMAP_32KSYNCT_BASE		0x49020000
> +#elif defined(CONFIG_ARCH_OMAP3430)
> +# define OMAP_32KSYNCT_BASE		0x48320000
> +#elif defined(CONFIG_ARCH_OMAP4)
> +# define OMAP_32KSYNCT_BASE		0x4a304000
> +#else
> +# error Unknown OMAP device
> +#endif
>  
>  #define OMAP_DEVICE_MAGIC 0xf00dcafe

This OMAP_32KSYNCT_BASE stuff will break multi-omap as it's defined
in a different way for for various omaps.

Also, OMAP_32KSYNCT_BASE define should no longer be needed at all,
I think all issues like this have been fixed over past year or so.

Can you please check your patches, if you're OMAP_32KSYNCT_BASE
in your other patches, they should be fixed.

Regards,

Tony
