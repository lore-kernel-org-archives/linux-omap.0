From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 6/6] Regulator: Makefile modified to include TWL4030-PMIC
 specific file
Date: Mon, 11 Jan 2010 13:43:55 +0200
Message-ID: <4B4B0EFB.5050008@compulab.co.il>
References: <1262973498-32685-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:33395 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab0AKLoG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:44:06 -0500
In-Reply-To: <1262973498-32685-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

Anuj Aggarwal wrote:
> Makefile is modified so that board-omap35x-twl4030-pmic.c gets compiled
> for the platforms having TWL4030 as the PMIC.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Can you combine this patch with "Modifying Kconfig to choose from the
available PMICs" patch?
Moreover, I think the patches should be reordered so that kernel build
won't be broken. Maybe something like:
1 - Creating TWL4030 specific file having supplies & init data
2 - Modifying Kconfig and Makefile to choose from the available PMICs
3 - Kconfig modified to select TWL4030 for OMAP3 based platforms
4 - Use common regulator supplies and init data structs

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b32678b..181be39 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
>  					   mmc-twl4030.o
>  obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
>  					   mmc-twl4030.o
> +obj-$(CONFIG_PMIC_TWL4030)		+= board-omap35x-twl4030-pmic.o
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
>  
>  obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o


-- 
Sincerely yours,
Mike.
