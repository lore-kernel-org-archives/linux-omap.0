From: "arun c" <arun.edarath@gmail.com>
Subject: Re: [PATCH] omap3beagle: add driver to turn on the TFP410 framer to get DVI output
Date: Fri, 16 May 2008 12:32:00 +0530
Message-ID: <c656a4d20805160002u32ff68e3wde41b5b270e40526@mail.gmail.com>
References: <1210835035-26299-1-git-send-email-koen@openembedded.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:8012 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbYEPHCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 03:02:03 -0400
Received: by ti-out-0910.google.com with SMTP id b6so354407tic.23
        for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 00:02:00 -0700 (PDT)
In-Reply-To: <1210835035-26299-1-git-send-email-koen@openembedded.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@openembedded.org>
Cc: linux-omap@vger.kernel.org

Hi Koen,

> diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
> new file mode 100644
> index 0000000..f5b7466
> --- /dev/null
> +++ b/drivers/video/omap/lcd_omap3beagle.c
> @@ -0,0 +1,135 @@
> +/*
> + * LCD panel support for the TI OMAP3 Beagle board
> + *
> + * Author: Koen Kooi <koen@openembedded.org>
> + *
> + * Derived from drivers/video/omap/lcd-omap3evm.c
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/mux.h>
> +#include <asm/arch/omapfb.h>
> +#include <asm/mach-types.h>
> +
> +#define LCD_PANEL_ENABLE_GPIO       170
> +
> +#define LCD_XRES               1024
> +#define LCD_YRES               768

I don't think there is a need for LCD_PIXCLOCK_MAX
and LCD_PIXCLOCK_MIN. It should be changed to
LCD_PIXCLOCK, am I right?

> +#define LCD_PIXCLOCK_MAX        64000 /* in kHz */
> +#define LCD_PIXCLOCK_MIN        64000 /* in kHz */

 Regards,
Arun C
