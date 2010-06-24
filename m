From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Wed, 23 Jun 2010 23:11:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006232310110.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39143 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab0FXFLT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 01:11:19 -0400
In-Reply-To: <1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Rajendra

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 

Please add a brief patch changelog entry here.  Maybe just say this is 
necessary for integration code using omap_device to work on OMAP4?

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
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
> -- 
> 1.7.0.2
> 


- Paul
