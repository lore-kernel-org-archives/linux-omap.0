From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCHv2 08/27] OMAPDSS: add of helpers
Date: Tue, 17 Dec 2013 12:30:21 +0530
Message-ID: <52AFF685.6010209@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39593 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab3LQHA0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 02:00:26 -0500
In-Reply-To: <1387205794-32246-9-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

Hi,

On Monday 16 December 2013 08:26 PM, Tomi Valkeinen wrote:
> Add helpers to get ports and endpoints from DT data.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/Makefile |   2 +-
>   drivers/video/omap2/dss/dss-of.c | 162 +++++++++++++++++++++++++++++++++++++++
>   include/video/omapdss.h          |  14 ++++
>   3 files changed, 177 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/video/omap2/dss/dss-of.c
>
> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
> index d3aa91bdd6a8..8aec8bda27cc 100644
> --- a/drivers/video/omap2/dss/Makefile
> +++ b/drivers/video/omap2/dss/Makefile
> @@ -1,7 +1,7 @@
>   obj-$(CONFIG_OMAP2_DSS) += omapdss.o
>   # Core DSS files
>   omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
> -	output.o
> +	output.o dss-of.o
>   # DSS compat layer files
>   omapdss-y += manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o \
>   	dispc-compat.o display-sysfs.o
> diff --git a/drivers/video/omap2/dss/dss-of.c b/drivers/video/omap2/dss/dss-of.c
> new file mode 100644
> index 000000000000..59213cf2ffa2
> --- /dev/null
> +++ b/drivers/video/omap2/dss/dss-of.c
> @@ -0,0 +1,162 @@
> +/*
> + * Copyright (C) 2013 Texas Instruments
> + * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/seq_file.h>
> +
> +#include <video/omapdss.h>
> +
> +#include "dss.h"
> +#include "dss_features.h"

Minor nitpick. The above 2 headers aren't needed.

Archit

