From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Add dm816x hwmod support
Date: Wed, 14 Jan 2015 11:43:01 -0800
Message-ID: <20150114194301.GR2419@atomide.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com>
 <1421191355-12835-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36061 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbbANTqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2015 14:46:45 -0500
Content-Disposition: inline
In-Reply-To: <1421191355-12835-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>, Paul Walmsley <paul@pwsan.com>

* Tony Lindgren <tony@atomide.com> [150113 15:29]:
> Add minimal hwmod support that works at least on dm8168. This
> is based on the code in the earlier TI CDP tree, and an earlier
> patch by Aida Mynzhasova <aida.mynzhasova@skitlab.ru>.
> 
> I've set up things to work pretty much the same way as for
> am33xx. We are basically using cm33xx.c with a different set
> of clocks and clockdomains.
> 
> This code is based on the TI81XX-LINUX-PSP-04.04.00.02 patches
> published at:
> 
> http://downloads.ti.com/dsps/dsps_public_sw/psp/LinuxPSP/TI81XX_04_04/04_04_00_02/index_FDS.html
> 
> Cc: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile               |    1 +
>  arch/arm/mach-omap2/io.c                   |    8 +-
>  arch/arm/mach-omap2/omap_hwmod.c           |    2 +-
>  arch/arm/mach-omap2/omap_hwmod.h           |    1 +
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 1025 ++++++++++++++++++++++++++++
>  5 files changed, 1034 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 352873c..926bc39 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -226,6 +226,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_43xx_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap_hwmod_33xx_43xx_ipblock_data.o
> +obj-$(CONFIG_SOC_TI81XX)		+= omap_hwmod_81xx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
>  obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
>  obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o

Looks like the Makefile needs the following addition for make randconfig
builds to work properly.

Regards,

Tony

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-prcm-4-5-common)
 am33xx-43xx-prcm-common			+= prm33xx.o cm33xx.o
+obj-$(CONFIG_SOC_TI81XX)		+= $(am33xx-43xx-prcm-common)
 obj-$(CONFIG_SOC_AM33XX)		+= $(am33xx-43xx-prcm-common)
 obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common) \
 					   $(am33xx-43xx-prcm-common)
