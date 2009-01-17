From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/6] omap2 iommu: entries for Kconfig and Makefile
Date: Sat, 17 Jan 2009 16:59:20 +0000
Message-ID: <20090117165920.GD12341@n2100.arm.linux.org.uk>
References: <20090116083003.18344.38307.stgit@oreo.research.nokia.com> <20090116083735.18344.92890.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57875 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762716AbZAQQ7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2009 11:59:33 -0500
Content-Disposition: inline
In-Reply-To: <20090116083735.18344.92890.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jan 16, 2009 at 10:37:35AM +0200, Hiroshi DOYU wrote:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
> 
>  arch/arm/mach-omap2/Makefile |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index bbd12bc..443e71f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -24,6 +24,11 @@ endif
>  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
>  
> +obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
> +ifeq ($(CONFIG_ARCH_OMAP3),y)
> +obj-$(CONFIG_OMAP_IOMMU)		+= omap3-iommu.o
> +endif
> +

I can see this expanding still further... so what about nipping it now
before it gets out of hand:

iommu-y					+= iommu2.o
iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o

obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)

>  # Specific board support
>  obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
>  obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
