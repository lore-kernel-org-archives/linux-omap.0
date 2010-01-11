From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 4/6] Regulator: Modifying Kconfig to choose from the available
 PMICs
Date: Mon, 11 Jan 2010 13:38:22 +0200
Message-ID: <4B4B0DAE.1030604@compulab.co.il>
References: <1262973486-32610-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:33361 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab0AKLid (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 06:38:33 -0500
In-Reply-To: <1262973486-32610-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

Anuj Aggarwal wrote:
> Kconfig is modified for OMAP3 EVM so that user can choose the appropriate
> PMIC (currently only TWL4030). Config options for other PMICs will be
> added later on.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 606bf04..95b8eb2 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -82,6 +82,15 @@ config MACH_OMAP3EVM
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  	select OMAP_PACKAGE_CBB
>  
> +config PMIC_TWL4030
> +	bool "TWL4030/TPS65950 Power Module"
> +	default y
> +	depends on TWL4030_CORE && MACH_OMAP3EVM

I don't think PMIC_TWL4030 should depend on MACH_OMAP3EVM

> +	select REGULATOR_TWL4030 if REGULATOR
> +	help
> +	  Say yes here if you are using the TWL4030/TPS65950 based power module
> +	  for the EVM boards.
> +
>  config MACH_OMAP3517EVM
>  	bool "OMAP3517/ AM3517 EVM board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX


-- 
Sincerely yours,
Mike.
