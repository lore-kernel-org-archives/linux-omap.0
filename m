From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/5] Regulator: Creating regulator hookup file for
 OMAP3 platforms
Date: Thu, 05 Nov 2009 16:58:15 +0000
Message-ID: <1257440295.3603.1185.camel@odin>
References: <1257439164-28467-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56558 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbZKEQ6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2009 11:58:13 -0500
Received: by ewy3 with SMTP id 3so185397ewy.37
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2009 08:58:17 -0800 (PST)
In-Reply-To: <1257439164-28467-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com

On Thu, 2009-11-05 at 22:09 +0530, Anuj Aggarwal wrote:
> This newly created board-omap35x-pmic.c will be used to provide
> the board specific regulator hookup code for various TI PMICs (like
> TWL4030/TPS65950, TPS65023) on different EVMs like OMAP3, AM3517.
> 
> PMIC initialization routine is called from the board-evm file
> which will initialize the configured PMIC appropriately.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap35x-pmic.c |   71 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c     |    8 +++
>  2 files changed, 79 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap35x-pmic.c
> 
> diff --git a/arch/arm/mach-omap2/board-omap35x-pmic.c b/arch/arm/mach-omap2/board-omap35x-pmic.c
> new file mode 100644
> index 0000000..aae07ab
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap35x-pmic.c
> @@ -0,0 +1,71 @@
> +/*
> + * board-omap35x-pmic.c
> + *
> + * Board specific information for different regulators and platforms.
> + *
> + * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/platform_device.h>
> +#include <plat/common.h>
> +
> +/*
> + * Definitions specific to TWL4030/TPS65950
> + */
> +#if defined(CONFIG_PMIC_TWL4030)
> +static inline void pmic_twl4030_init(void)
> +{
> +	/* TWL4030 specific init code */

Would this not be per board per pmic i.e.

pmic_x_board_y_init() ?

I can see pmic init sometimes being different across boards here (for
the same pmic). Although this probably depends on how complex/flexible
your pmic init needs to be in the first place.

Liam


