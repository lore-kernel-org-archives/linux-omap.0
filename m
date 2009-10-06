From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] [OMAP1] mux: Add MMC mux pins for omap7xx
Date: Tue, 6 Oct 2009 12:30:40 -0500
Message-ID: <4ACB7EC0.3010401@ti.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41524 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbZJFRbS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Oct 2009 13:31:18 -0400
In-Reply-To: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Cory Maccarrone had written, on 10/06/2009 08:53 AM, the following:
> There are three mux pins needed for omap7xx that differ
> from the other omap configurations.  This change adds the
> declarations into mux.c and mux.h.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/mach-omap1/mux.c             |    5 +++++
>  arch/arm/plat-omap/include/mach/mux.h |    5 +++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
> index d59899d..feb6d8c 100644
> --- a/arch/arm/mach-omap1/mux.c
> +++ b/arch/arm/mach-omap1/mux.c
> @@ -51,6 +51,11 @@ MUX_CFG_7XX("E3_7XX_KBC4",        13,   25,    0,
> 24,   1, 0)
>  MUX_CFG_7XX("AA17_7XX_USB_DM",     2,   21,    0,   20,   0, 0)
>  MUX_CFG_7XX("W16_7XX_USB_PU_EN",   2,   25,    0,   24,   0, 0)
>  MUX_CFG_7XX("W17_7XX_USB_VBUSI",   2,   29,    0,   28,   0, 0)
> +
> +/* MMC Pins */
> +MUX_CFG_7XX("MMC_7XX_CMD",         2,    9,    0,    8,   1, 0)
> +MUX_CFG_7XX("MMC_7XX_CLK",         2,   13,    0,   12,   1, 0)
> +MUX_CFG_7XX("MMC_7XX_DAT0",        2,   17,    0,   16,   1, 0)
>  };
>  #define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
>  #else
> diff --git a/arch/arm/plat-omap/include/mach/mux.h
> b/arch/arm/plat-omap/include/mach/mux.h
> index f3c1d8a..56e357e 100644
> --- a/arch/arm/plat-omap/include/mach/mux.h
> +++ b/arch/arm/plat-omap/include/mach/mux.h
> @@ -219,6 +219,11 @@ enum omap7xx_index {
>  	AA17_7XX_USB_DM,
>  	W16_7XX_USB_PU_EN,
>  	W17_7XX_USB_VBUSI,
> +
> +	/* MMC */
> +	MMC_7XX_CMD,
> +	MMC_7XX_CLK,
> +	MMC_7XX_DAT0,
probably a dumb question -> but should'nt these go off to bootloader 
perhaps?

-- 
Regards,
Nishanth Menon
