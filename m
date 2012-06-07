From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [CFT 01/11] dmaengine: add OMAP DMA engine driver
Date: Thu, 7 Jun 2012 18:10:45 +0530
Message-ID: <CANfBPZ_q97M4k8c8+7rBOpuBv99gfzNA1Q-SLesGP8c0AayBpw@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScaXw-0003tR-U8@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:48650 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682Ab2FGMlI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 08:41:08 -0400
Received: by bkcjg15 with SMTP id jg15so500966bkc.10
        for <linux-omap@vger.kernel.org>; Thu, 07 Jun 2012 05:41:05 -0700 (PDT)
In-Reply-To: <E1ScaXw-0003tR-U8@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, Jun 7, 2012 at 4:36 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0drivers/dma/Kconfig =A0 =A0 =A0| =A0 =A06 +
> =A0drivers/dma/Makefile =A0 =A0 | =A0 =A01 +
> =A0drivers/dma/omap-dma.c =A0 | =A0522 ++++++++++++++++++++++++++++++=
++++++++++++++++
> =A0include/linux/omap-dma.h | =A0 24 ++
> =A04 files changed, 553 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/dma/omap-dma.c
> =A0create mode 100644 include/linux/omap-dma.h
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index eb2b60e..8be3bf6 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -261,6 +261,12 @@ config DMA_SA11X0
> =A0 =A0 =A0 =A0 =A0SA-1110 SoCs. =A0This DMA engine can only be used =
with on-chip
> =A0 =A0 =A0 =A0 =A0devices.
>
> +config DMA_OMAP
> + =A0 =A0 =A0 tristate "OMAP DMA support"
> + =A0 =A0 =A0 depends on ARCH_OMAP
> + =A0 =A0 =A0 select DMA_ENGINE
> + =A0 =A0 =A0 select DMA_VIRTUAL_CHANNELS
> +
> =A0config DMA_ENGINE
> =A0 =A0 =A0 =A0bool
>
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index fc05f7d..ddc291a 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_PCH_DMA) +=3D pch_dma.o
> =A0obj-$(CONFIG_AMBA_PL08X) +=3D amba-pl08x.o
> =A0obj-$(CONFIG_EP93XX_DMA) +=3D ep93xx_dma.o
> =A0obj-$(CONFIG_DMA_SA11X0) +=3D sa11x0-dma.o
> +obj-$(CONFIG_DMA_OMAP) +=3D omap-dma.o
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> new file mode 100644
> index 0000000..500bc71
> --- /dev/null
> +++ b/drivers/dma/omap-dma.c
> @@ -0,0 +1,522 @@
> +/*
> + * OMAP DMAengine support
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/omap-dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include "virt-dma.h"
Russell,
  I applied your entire series on 3.5-rc1 and build fails as it can't
find virt-dma.h
Perhaps a missed "git add" ?

> +#include <plat/dma.h>
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
