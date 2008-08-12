From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 5/9] OMAP2 SDRC: add timing data for Micron MT46H32M32LF-6
Date: Tue, 12 Aug 2008 10:07:28 -0700
Message-ID: <5e088bd90808121007w3f1587dehf6b827658a9e3d6b@mail.gmail.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
	 <20080708025447.11646.48874.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:30766 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYHLRHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 13:07:30 -0400
Received: by yw-out-2324.google.com with SMTP id 9so936136ywe.1
        for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 10:07:29 -0700 (PDT)
In-Reply-To: <20080708025447.11646.48874.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Many early EVMs used Samsung memory (mine for example).  Are these
timings compatible or is a separate Samsung header required?

Steve

On Mon, Jul 7, 2008 at 7:54 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Add timing data for the Micron MT46H32M32LF-6 SDRAM chip, used on the
> OMAP3 Beagle and EVM boards.  Original timing data is from the Micron
> datasheet PDF downloaded from:
>
> http://download.micron.com/pdf/datasheets/dram/mobile/1gb_ddr_mobile_sdram_t48m.pdf
>
> Thanks to Rajendra Nayak <rnayak@ti.com> for his help identifying
> the chips used on Beagle & OMAP3EVM.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>
>  arch/arm/mach-omap2/board-omap3beagle.c           |    4 +-
>  arch/arm/mach-omap2/board-omap3evm.c              |    4 +-
>  arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h |   55 +++++++++++++++++++++
>  include/asm-arm/arch-omap/sdrc.h                  |    2 -
>  4 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 3523611..bf4b430 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -33,6 +33,8 @@
>  #include <asm/arch/hsmmc.h>
>  #include <asm/arch/common.h>
>
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
>  static struct omap_uart_config omap3_beagle_uart_config __initdata = {
>        .enabled_uarts  = ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
> @@ -47,7 +49,7 @@ static int __init omap3_beagle_i2c_init(void)
>
>  static void __init omap3_beagle_init_irq(void)
>  {
> -       omap2_init_common_hw(NULL);
> +       omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
>        omap_init_irq();
>        omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 1ba8a45..df81706 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -37,6 +37,8 @@
>  #include <asm/arch/common.h>
>  #include <asm/arch/mcspi.h>
>
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
>  static struct resource omap3evm_smc911x_resources[] = {
>        [0] =   {
>                .start  = OMAP3EVM_ETHR_START,
> @@ -188,7 +190,7 @@ static struct platform_device omap3evm_kp_device = {
>
>  static void __init omap3_evm_init_irq(void)
>  {
> -       omap2_init_common_hw(NULL);
> +       omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
>        omap_init_irq();
>        omap_gpio_init();
>        omap3evm_init_smc911x();
> diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
> new file mode 100644
> index 0000000..f0ec104
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
> @@ -0,0 +1,55 @@
> +/*
> + * SDRC register values for the Micron MT46H32M32LF-6
> + *
> + * Copyright (C) 2008 Texas Instruments, Inc.
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
> +#define ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
> +
> +#include <asm/arch/sdrc.h>
> +
> +/* Micron MT46H32M32LF-6 */
> +/* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
> +static struct omap_sdrc_params mt46h32m32lf_sdrc_params[] = {
> +       [0] = {
> +               .rate        = 165941176,
> +               .actim_ctrla = 0x9a9db4c6,
> +               .actim_ctrlb = 0x00011217,
> +               .rfr_ctrl    = 0x0004dc01,
> +               .mr          = 0x00000032,
> +       },
> +       [1] = {
> +               .rate        = 133333333,
> +               .actim_ctrla = 0x7a19b485,
> +               .actim_ctrlb = 0x00011213,
> +               .rfr_ctrl    = 0x0003de01,
> +               .mr          = 0x00000032,
> +       },
> +       [2] = {
> +               .rate        = 82970588,
> +               .actim_ctrla = 0x51512283,
> +               .actim_ctrlb = 0x0001120c,
> +               .rfr_ctrl    = 0x00025501,
> +               .mr          = 0x00000032,
> +       },
> +       [3] = {
> +               .rate        = 66666666,
> +               .actim_ctrla = 0x410d2243,
> +               .actim_ctrlb = 0x0001120a,
> +               .rfr_ctrl    = 0x0001d601,
> +               .mr          = 0x00000032,
> +       },
> +       [4] = {
> +               .rate        = 0
> +       },
> +};
> +
> +#endif
> diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
> index 00ba539..1d974a0 100644
> --- a/include/asm-arm/arch-omap/sdrc.h
> +++ b/include/asm-arm/arch-omap/sdrc.h
> @@ -102,7 +102,7 @@ struct omap_sdrc_params {
>        u32 mr;
>  };
>
> -void __init omap2_sdrc_init(void);
> +void __init omap2_sdrc_init(struct omap_sdrc_params *);
>  struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
>
>  #ifdef CONFIG_ARCH_OMAP2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
