From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPDSS: move 'compatible' converter to omapdss driver
Date: Thu, 15 May 2014 11:13:54 -0700
Message-ID: <20140515181354.GB23659@atomide.com>
References: <1400141136-25358-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29978 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaEOSN7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 14:13:59 -0400
Content-Disposition: inline
In-Reply-To: <1400141136-25358-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 01:06]:
> Move the panel/encoder driver compatible-string converter from
> arch/arm/mach-omap2/display.c to omapdss driver. That is a more logical
> place for it, as it's really an omapdss internal hack.

Thanks, maybe also consider just using the compatible flags
instead as discussed in the other thread. Anyways for moving
this out of mach-omap2:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/display.c                     |  56 -----------
>  drivers/video/fbdev/omap2/Makefile                |   2 +-
>  drivers/video/fbdev/omap2/dss/Kconfig             |   4 +
>  drivers/video/fbdev/omap2/dss/Makefile            |   1 +
>  drivers/video/fbdev/omap2/dss/omapdss-boot-init.c | 112 ++++++++++++++++++++++
>  5 files changed, 118 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 16d33d831287..519a20fc0432 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -555,65 +555,9 @@ int omap_dss_reset(struct omap_hwmod *oh)
>  	return r;
>  }
>  
> -/* list of 'compatible' nodes to convert to omapdss specific */
> -static const char * const dss_compat_conv_list[] __initconst = {
> -	"composite-connector",
> -	"dvi-connector",
> -	"hdmi-connector",
> -	"panel-dpi",
> -	"panel-dsi-cm",
> -	"sony,acx565akm",
> -	"svideo-connector",
> -	"ti,tfp410",
> -	"ti,tpd12s015",
> -};
> -
> -/* prepend compatible string with "omapdss," */
> -static __init void omapdss_omapify_node(struct device_node *node,
> -	const char *compat)
> -{
> -	char *new_compat;
> -	struct property *prop;
> -
> -	new_compat = kasprintf(GFP_KERNEL, "omapdss,%s", compat);
> -
> -	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> -
> -	if (!prop) {
> -		pr_err("omapdss_omapify_node: kzalloc failed\n");
> -		return;
> -	}
> -
> -	prop->name = "compatible";
> -	prop->value = new_compat;
> -	prop->length = strlen(new_compat) + 1;
> -
> -	of_update_property(node, prop);
> -}
> -
> -/*
> - * As omapdss panel drivers are omapdss specific, but we want to define the
> - * DT-data in generic manner, we convert the compatible strings of the panel
> - * nodes from "panel-foo" to "omapdss,panel-foo". This way we can have both
> - * correct DT data and omapdss specific drivers.
> - *
> - * When we get generic panel drivers to the kernel, this will be removed.
> - */
>  void __init omapdss_early_init_of(void)
>  {
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(dss_compat_conv_list); ++i) {
> -		const char *compat = dss_compat_conv_list[i];
> -		struct device_node *node = NULL;
> -
> -		while ((node = of_find_compatible_node(node, NULL, compat))) {
> -			if (!of_device_is_available(node))
> -				continue;
>  
> -			omapdss_omapify_node(node, compat);
> -		}
> -	}
>  }
>  
>  struct device_node * __init omapdss_find_dss_of_node(void)
> diff --git a/drivers/video/fbdev/omap2/Makefile b/drivers/video/fbdev/omap2/Makefile
> index bf8127df8c71..f8745ec369cc 100644
> --- a/drivers/video/fbdev/omap2/Makefile
> +++ b/drivers/video/fbdev/omap2/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
>  
> -obj-$(CONFIG_OMAP2_DSS) += dss/
> +obj-y += dss/
>  obj-y += displays-new/
>  obj-$(CONFIG_FB_OMAP2) += omapfb/
> diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
> index dde4281663b1..a28f3a39ab1b 100644
> --- a/drivers/video/fbdev/omap2/dss/Kconfig
> +++ b/drivers/video/fbdev/omap2/dss/Kconfig
> @@ -1,6 +1,10 @@
> +config OMAP2_DSS_INIT
> +	bool
> +
>  menuconfig OMAP2_DSS
>          tristate "OMAP2+ Display Subsystem support"
>  	select VIDEOMODE_HELPERS
> +	select OMAP2_DSS_INIT
>          help
>  	  OMAP2+ Display Subsystem support.
>  
> diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbdev/omap2/dss/Makefile
> index 8aec8bda27cc..3b79ad74f2e1 100644
> --- a/drivers/video/fbdev/omap2/dss/Makefile
> +++ b/drivers/video/fbdev/omap2/dss/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_OMAP2_DSS_INIT) += omapdss-boot-init.o
>  obj-$(CONFIG_OMAP2_DSS) += omapdss.o
>  # Core DSS files
>  omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
> diff --git a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> new file mode 100644
> index 000000000000..468f6eff370c
> --- /dev/null
> +++ b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> @@ -0,0 +1,112 @@
> +/*
> + * Copyright (C) 2014 Texas Instruments
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
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
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +/* list of 'compatible' nodes to convert to omapdss specific */
> +static const char * const dss_compat_conv_list[] __initconst = {
> +	"composite-connector",
> +	"dvi-connector",
> +	"hdmi-connector",
> +	"panel-dpi",
> +	"panel-dsi-cm",
> +	"sony,acx565akm",
> +	"svideo-connector",
> +	"ti,tfp410",
> +	"ti,tpd12s015",
> +};
> +
> +/* prepend compatible string with "omapdss," */
> +static __init void omapdss_omapify_node(struct device_node *node,
> +	const char *compat)
> +{
> +	char *new_compat;
> +	struct property *prop;
> +
> +	new_compat = kasprintf(GFP_KERNEL, "omapdss,%s", compat);
> +
> +	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +
> +	if (!prop) {
> +		pr_err("omapdss_omapify_node: kzalloc failed\n");
> +		return;
> +	}
> +
> +	prop->name = "compatible";
> +	prop->value = new_compat;
> +	prop->length = strlen(new_compat) + 1;
> +
> +	of_update_property(node, prop);
> +}
> +
> +static struct device_node * __init omapdss_find_dss_of_node(void)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,omap2-dss");
> +	if (node)
> +		return node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,omap3-dss");
> +	if (node)
> +		return node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,omap4-dss");
> +	if (node)
> +		return node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,omap5-dss");
> +	if (node)
> +		return node;
> +
> +	return NULL;
> +}
> +
> +/*
> + * As omapdss panel drivers are omapdss specific, but we want to define the
> + * DT-data in generic manner, we convert the compatible strings of the panel
> + * nodes from "panel-foo" to "omapdss,panel-foo". This way we can have both
> + * correct DT data and omapdss specific drivers.
> + *
> + * When we get generic panel drivers to the kernel, this will be removed.
> + */
> +static int __init omap_dss_boot_init(void)
> +{
> +	int i;
> +
> +	/* do we have omapdss device? */
> +	if (omapdss_find_dss_of_node() == NULL)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(dss_compat_conv_list); ++i) {
> +		const char *compat = dss_compat_conv_list[i];
> +		struct device_node *node = NULL;
> +
> +		while ((node = of_find_compatible_node(node, NULL, compat))) {
> +			if (!of_device_is_available(node))
> +				continue;
> +
> +			omapdss_omapify_node(node, compat);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +subsys_initcall(omap_dss_boot_init);
> -- 
> 1.9.1
> 
