From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap1_defconfig build broken in linux next
Date: Mon, 11 Feb 2013 14:31:56 -0800
Message-ID: <20130211223155.GA4801@atomide.com>
References: <20130211193132.GV4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34319 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932771Ab3BKWb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 17:31:58 -0500
Content-Disposition: inline
In-Reply-To: <20130211193132.GV4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130211 11:35]:
> FYI, looks like something broke compile recently, have not yet
> figured out the breaking commit. Might be the same issue
> with some other defconfigs too.
> 
> Probably something was indirectly included earlier?
> 
> This fixes it, still need to dig the breaking commit
> for the description.

Seems to be caused by 16559ae4 (kgdb: remove #include
<linux/serial_8250.h> from kgdb.h), will post a proper
patch.
 
> Regards,
> 
> Tony
> 
> 
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -31,6 +31,8 @@
>  
>  #include <plat/i2c.h>
>  
> +#include <mach/irqs.h>
> +
>  #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
>  void omap7xx_map_io(void);
>  #else
> --- a/drivers/video/omap/lcd_ams_delta.c
> +++ b/drivers/video/omap/lcd_ams_delta.c
> @@ -27,6 +27,7 @@
>  #include <linux/lcd.h>
>  #include <linux/gpio.h>
>  
> +#include <mach/hardware.h>
>  #include <mach/board-ams-delta.h>
>  
>  #include "omapfb.h"
> --- a/drivers/video/omap/lcd_osk.c
> +++ b/drivers/video/omap/lcd_osk.c
> @@ -24,7 +24,10 @@
>  #include <linux/platform_device.h>
>  
>  #include <asm/gpio.h>
> +
> +#include <mach/hardware.h>
>  #include <mach/mux.h>
> +
>  #include "omapfb.h"
>  
>  static int osk_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
