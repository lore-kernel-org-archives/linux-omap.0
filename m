From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC 6/6] omap: enable remoteproc building
Date: Tue, 27 Jul 2010 21:19:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA223F@dbde02.ent.ti.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
 <1278022994-28476-7-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33296 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab0G0Pte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 11:49:34 -0400
In-Reply-To: <1278022994-28476-7-git-send-email-ohad@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ben-cohen, Ohad" <ohadb@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen
> Sent: Friday, July 02, 2010 3:53 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ben-cohen, Ohad
> Subject: [RFC 6/6] omap: enable remoteproc building
> 
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Make it possible to build omap's remoteproc module
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    6 ++++++
>  arch/arm/plat-omap/Kconfig   |    7 +++++++
>  arch/arm/plat-omap/Makefile  |    1 +
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile 
> b/arch/arm/mach-omap2/Makefile
> index 307f8b0..edb65b3 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -59,6 +59,12 @@ obj-$(CONFIG_OMAP3_EMU)		+= emu.o
>  obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
>  mailbox_mach-objs			:= mailbox.o
>  
> +ifneq ($(CONFIG_OMAP_REMOTE_PROC),)
> +obj-$(CONFIG_ARCH_OMAP2)		+= remoteproc24xx.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= remoteproc3xxx.o

[sp] Since the compilation of this file depends upon CONFIG_ARCH_OMAP3,
     the "big" ifdef CONFIG_ARCH_OMAP3 in the file remoteproc3xxx.c
     is not useful at all.

> +obj-$(CONFIG_ARCH_OMAP4)		+= remoteproc44xx.o
> +endif
> +
>  iommu-y					+= iommu2.o
>  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
>  
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index e2ea04a..e7d7372 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -96,6 +96,13 @@ config OMAP_MBOX_FWK
>  	  Say Y here if you want to use OMAP Mailbox framework 
> support for
>  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
>  
> +config OMAP_REMOTE_PROC
> +	bool "Remote Processor framework support"
> +	depends on ARCH_OMAP
> +	help
> +	  Say Y here if you want to use OMAP Remote Processor framework
> +	  support for DSP, Tesla and/or Ducati (OMAP3/4).
> +
>  config OMAP_IOMMU
>  	tristate
>  
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 98f0191..bacb5c3 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -29,5 +29,6 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  
>  # OMAP mailbox framework
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
> +obj-$(CONFIG_OMAP_REMOTE_PROC) += remoteproc.o
>  
>  obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> \ No newline at end of file

[sp] You need to fix this as well.

> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 