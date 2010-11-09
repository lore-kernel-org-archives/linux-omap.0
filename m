From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Tue, 09 Nov 2010 12:23:03 +0200
Message-ID: <1289298183.3297.154.camel@tubuntu>
References: <1289252700-3482-1-git-send-email-bryan.wu@canonical.com>
	 <1289252700-3482-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:25180 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab0KIKVl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 05:21:41 -0500
In-Reply-To: <1289252700-3482-2-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

Hi,

On Mon, 2010-11-08 at 22:44 +0100, ext Bryan Wu wrote:
> Generic DPI panel driver includes the driver and 4 similar panel configurations. It
> will match the panel name which is passed from platform data and setup the
> right configurations.
> 
> With generic DPI panel driver, we can remove those 4 duplicated panel display
> drivers. In the future, it is simple for us just add new panel configuration
> date in panel-generic-dpi.c to support new display panel.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  .../arm/plat-omap/include/plat/panel-generic-dpi.h |   31 ++
>  drivers/video/omap2/displays/Kconfig               |    8 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  314 ++++++++++++++++++++
>  4 files changed, 354 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>  create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
> 
> diff --git a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
> new file mode 100644
> index 0000000..da50756
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
> @@ -0,0 +1,31 @@
> +/*
> + * Header for generic DPI panel driver
> + *
> + * Copyright (C) 2010 Canonical Ltd.
> + * Author: Bryan Wu <bryan.wu@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ARCH_ARM_PLAT_OMAP_GENERIC_DPI_PANEL_H
> +#define __ARCH_ARM_PLAT_OMAP_GENERIC_DPI_PANEL_H

Should be __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H

> +
> +/**
> + * struct panel_data - panel driver configuration
> + * @name: panel name
> + */
> +struct generic_dpi_panel_data {

I think the struct name should be panel_generic_dpi_data.

> +	const char *name;
> +};

Please add here also the fields platform_enable/disable and use them
instead of the ones in dssdev.

 Tomi


