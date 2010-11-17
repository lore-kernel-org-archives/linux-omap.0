From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Wed, 17 Nov 2010 21:43:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247387FCD@dbde02.ent.ti.com>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
 <1290000875-11508-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56159 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934791Ab0KQQNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 11:13:47 -0500
In-Reply-To: <1290000875-11508-2-git-send-email-bryan.wu@canonical.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Bryan Wu
> Sent: Wednesday, November 17, 2010 7:05 PM
> To: tomi.valkeinen@nokia.com; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Gadiyar, Anand
> Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
> 
> Generic DPI panel driver includes the driver and 4 similar 
> panel configurations. It
> will match the panel name which is passed from platform data 
> and setup the
> right configurations.
> 
> With generic DPI panel driver, we can remove those 4 
> duplicated panel display
> drivers. In the future, it is simple for us just add new 
> panel configuration
> date in panel-generic-dpi.c to support new display panel.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 ++
>  drivers/video/omap2/displays/Kconfig               |    8 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  355 
> ++++++++++++++++++++
>  4 files changed, 401 insertions(+), 0 deletions(-)
>  create mode 100644 
> arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>  create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
> 
> diff --git 
> a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h 
> b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
> new file mode 100644
> index 0000000..7906197
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
> @@ -0,0 +1,37 @@
> +/*
> + * Header for generic DPI panel driver
> + *
> + * Copyright (C) 2010 Canonical Ltd.
> + * Author: Bryan Wu <bryan.wu@canonical.com>
> + *
> + * This program is free software; you can redistribute it 
> and/or modify it
> + * under the terms of the GNU General Public License version 
> 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be 
> useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of 
> MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General 
> Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public 
> License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
> +#define __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
> +
> +#include "display.h"
> +
> +/**
> + * struct panel_generic_dpi_data - panel driver configuration data
> + * @name: panel name
> + * @platform_enable: platform specific panel enable function
> + * @platform_disable: platform specific panel disable function
> + */
> +struct panel_generic_dpi_data {
> +	const char *name;
> +	int (*platform_enable)(struct omap_dss_device *dssdev);
> +	void (*platform_disable)(struct omap_dss_device *dssdev);
> +};
> +
> +#endif /* __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H */
> diff --git a/drivers/video/omap2/displays/Kconfig 
> b/drivers/video/omap2/displays/Kconfig
> index 12327bb..cb3e339 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -1,6 +1,14 @@
>  menu "OMAP2/3 Display Device Drivers"
>          depends on OMAP2_DSS
>  
> +config PANEL_GENERIC_DPI
> +        tristate "Generic DPI Panel"
> +        help
> +	  Generic DPI panel driver.
> +	  Supports DVI output for Beagle and OMAP3 SDP.
> +	  Supports LCD Panel used in TI SDP3430 and EVM boards,
> +	  OMAP3517 EVM boards and CM-T35.
> +
>  config PANEL_GENERIC
>          tristate "Generic Panel"
>          help
> diff --git a/drivers/video/omap2/displays/Makefile 
> b/drivers/video/omap2/displays/Makefile
> index aa38609..022058c 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_PANEL_GENERIC_DPI) += panel-generic-dpi.o
>  obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
>  obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
>  obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c 
> b/drivers/video/omap2/displays/panel-generic-dpi.c
> new file mode 100644
> index 0000000..6702cf6
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -0,0 +1,355 @@
> +/*
> + * Generic DPI Panels support
> + *
> + * Copyright (C) 2010 Canonical Ltd.
> + * Author: Bryan Wu <bryan.wu@canonical.com>
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> + *

[sp] Shouldn't all authors (from the files being coalesced) be
     listed here.

     I see this missing from PATCH3/3 in your series:

[quote]
- * LCD panel driver for Sharp LQ043T1DG01
- *
- * Copyright (C) 2009 Texas Instruments Inc
- * Author: Vaibhav Hiremath <hvaibhav@ti.com>
- *
[/quote]


[snip]...[snip]

