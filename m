From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v5 06/17] OMAP2,3: DSS2: Create new file display.c for
 central dss driver registration.
Date: Fri, 07 Jan 2011 16:03:34 +0200
Message-ID: <1294409014.3968.94.camel@nubuntu>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
	 <1294399551-10457-7-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:40629 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab1AGODj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 09:03:39 -0500
In-Reply-To: <1294399551-10457-7-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sumit Semwal <sumit.semwal@ti.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Hi,

On Fri, 2011-01-07 at 16:55 +0530, ext Sumit Semwal wrote:
> A new file display.c is introduced for display driver init, which adds a function
> omap_display_init to do the DSS driver registration. This is the first step in moving
> away registration of DSS from board files into a common place.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile              |    2 +
>  arch/arm/mach-omap2/display.c             |   57 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/display.h |    4 ++
>  3 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/display.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4ab82f6..57b89e6 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -237,3 +237,5 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
>  
>  smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
>  obj-y					+= $(smsc911x-m) $(smsc911x-y)
> +
> +obj-y					+= display.o
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> new file mode 100644
> index 0000000..26d3feb
> --- /dev/null
> +++ b/arch/arm/mach-omap2/display.c
> @@ -0,0 +1,57 @@
> +/*
> + * OMAP2plus display device setup / initialization.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + * 	Senthilvadivu Guruswamy
> + *      Sumit Semwal
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +#include <plat/display.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +
> +#ifdef CONFIG_OMAP2_DSS

This also needs to be built in when DSS is configured as module. The
define above is only valid when DSS is configured as built-in.

So you can either check for both CONFIG_OMAP2_DSS and
CONFIG_OMAP2_DSS_MODULE here, or, I think a bit more cleanly:

- Compile display.c only if CONFIG_OMAP2_DSS[_MODULE] is defined (see
the Makefile, look for example how i2c-omap is handled).
- Check for CONFIG_OMAP2_DSS[_MODULE] in the header file, and define an
empty static inline function for omap_display_init() if DSS is disabled.

 Tomi


