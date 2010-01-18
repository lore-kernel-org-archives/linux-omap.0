From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 1/3] DSPBRIDGE: Fix header locations mach to plat
Date: Mon, 18 Jan 2010 11:55:12 +0200
Message-ID: <1263808512.1968.6.camel@sanganak>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32102 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab0ARJz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 04:55:58 -0500
In-Reply-To: <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>

On Sat, 2010-01-16 at 03:01 +0100, ext Omar Ramirez Luna wrote:
> Fix header locations, replaced mach to plat
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-omap2/dspbridge.c                |    2 +-
>  arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
>  drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
> index ea109a3..4150896 100644
> --- a/arch/arm/mach-omap2/dspbridge.c
> +++ b/arch/arm/mach-omap2/dspbridge.c
> @@ -14,7 +14,7 @@
>  #include <linux/platform_device.h>
>  
>  #ifdef CONFIG_BRIDGE_DVFS
> -#include <mach/omap-pm.h>
> +#include <plat/omap-pm.h>
>  #endif
>  
>  #include <dspbridge/host_os.h>
> diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
> index 6fe1462..74cf6d4 100644
> --- a/arch/arm/plat-omap/include/dspbridge/host_os.h
> +++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
> @@ -54,7 +54,7 @@
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
>  #include <dspbridge/dbtype.h>
> -#include <mach/clock.h>
> +#include <plat/clock.h>
>  #include <linux/clk.h>
>  #include <linux/pagemap.h>
>  #include <asm/cacheflush.h>
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
> index 7138396..b123707 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -34,7 +34,7 @@
>  #include <mach-omap2/cm.h>
>  #include <mach-omap2/prm-regbits-34xx.h>
>  #include <mach-omap2/cm-regbits-34xx.h>
> -#include <mach/control.h>
> +#include <plat/control.h>
>  
>  /*  ----------------------------------- DSP/BIOS Bridge */
>  #include <dspbridge/std.h>

Acked-by: Ameya Palande <ameya.palande@nokia.com>

