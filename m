From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] OMAP3:Zoom2: Add TWL4030 support
Date: Mon, 22 Jun 2009 15:51:36 +0300
Message-ID: <20090622125136.GF7352@atomide.com>
References: <1245363264-6162-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54092 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbZFVMvg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 08:51:36 -0400
Content-Disposition: inline
In-Reply-To: <1245363264-6162-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

* Vikram Pandita <vikram.pandita@ti.com> [090619 01:18]:
> Add TWL4030 CORE and TWL4030 drivers to Zoom2 board file
> TWL drivers enabled are:
> 	bci
> 	madc
> 	usb
> 	keypad
> 	mmc
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom2.c |  209 +++++++++++++++++++++++++++++++++++--
>  1 files changed, 198 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> index bcc0f76..443859c 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -12,17 +12,88 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/input.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/regulator/machine.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
>  #include <mach/common.h>
>  #include <mach/usb.h>
> +#include <mach/keypad.h>
>  
>  #include "mmc-twl4030.h"
>  
> +#ifndef CONFIG_TWL4030_CORE
> +#error "no power companion board defined!"
> +#endif

This does not look right. You should still be able to boot the board even without
twl compiled in. Or compile twl as a module. Currently we do have a bug where
mmc-twl4030.c forces mmc core to be compiled in because of the regulator fwk, but
that should be fixed by moving the regulator fwk calls to drivers/mmc/host/omap_hsmmc.c.

Regards,

Tony
