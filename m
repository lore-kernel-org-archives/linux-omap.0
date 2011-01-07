From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 06/17] OMAP2,3: DSS2: Create new file display.c for central dss driver registration.
Date: Fri, 07 Jan 2011 13:26:33 -0800
Message-ID: <87d3o8mmly.fsf@ti.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com>
	<1294399551-10457-7-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48284 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753441Ab1AGV0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 16:26:37 -0500
Received: by mail-yx0-f177.google.com with SMTP id 34so7474529yxm.36
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 13:26:37 -0800 (PST)
In-Reply-To: <1294399551-10457-7-git-send-email-sumit.semwal@ti.com> (Sumit
	Semwal's message of "Fri, 7 Jan 2011 16:55:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

Sumit Semwal <sumit.semwal@ti.com> writes:

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

Minor nit: the hwmod and omap_device headers are not needed for this
patch.  Please add them when needed (PATCH 8)

Kevin
