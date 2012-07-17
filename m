From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] memory: emif: add device tree support to emif
 driver
Date: Tue, 17 Jul 2012 10:58:32 -0700
Message-ID: <20120717175832.GA20806@kroah.com>
References: <1340977407-7594-1-git-send-email-santosh.shilimkar@ti.com>
 <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
 <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com>
 <20120630042356.GC1816@kroah.com>
 <CAMQu2gy0MmP4JLW4P1FreJqMMEBYSTjkLHJb8WX=aXLA6hxtZg@mail.gmail.com>
 <CAMQu2gxZ-tWJXAOeh20NsF1uyvs9fqwYtggFv=d7-qX+WFumRQ@mail.gmail.com>
 <CAMQu2gw_ZB7gVyL95B-h27B1fQh0d-YB3weaWRN6DNaGtSypDw@mail.gmail.com>
 <20120717163602.GA7167@kroah.com>
 <CAMQu2gw2Zt3E8byD=_nUXya-xU=gOA71arbbSh7gzxQhet0Vtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64705 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2GQR6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 13:58:36 -0400
Received: by yhmm54 with SMTP id m54so671977yhm.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 10:58:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMQu2gw2Zt3E8byD=_nUXya-xU=gOA71arbbSh7gzxQhet0Vtg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, tony@atomide.com

On Tue, Jul 17, 2012 at 10:37:45PM +0530, Shilimkar, Santosh wrote:
> On Tue, Jul 17, 2012 at 10:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Mon, Jul 09, 2012 at 07:02:36PM +0530, Shilimkar, Santosh wrote:
> >> Greg,
> >>
> 
> [...]
> 
> >> > To elaborate more, I have created below patch.
> >> > Let me know what do you think ?
> >> >
> >> Any comments ??
> >
> > Becides the obvious one of sending a line-wrapped patch that can not be
> > applied?  :)
> >
> My bad. Sorry about that.
> Sending it again and also attaching it in case mailer screws it up.
> 
> -->>
> >From 74688a87fd490909e9122bf757c0096480e9fc11 Mon Sep 17 00:00:00 2001
> From: Aneesh V <aneesh@ti.com>
> Date: Mon, 30 Jan 2012 20:06:30 +0530
> Subject: [PATCH 4/4] memory: emif: add device tree support to emif driver
> 
> Device tree support for the EMIF driver. LPDDR2 generic timings
> extraction from device is managed using couple of helper
> functions which can be used by other memory controller
> drivers.
> 
> Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/memory/Makefile    |    1 +
>  drivers/memory/emif.c      |  182 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/memory/of_memory.c |  153 +++++++++++++++++++++++++++++++++++++
>  drivers/memory/of_memory.h |   36 +++++++++
>  4 files changed, 371 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/memory/of_memory.c
>  create mode 100644 drivers/memory/of_memory.h
> 
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 42b3ce9..cd8486b 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for memory devices
>  #
> 
> +obj-$(CONFIG_OF)		+= of_memory.o
>  obj-$(CONFIG_TI_EMIF)		+= emif.o
>  obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
>  obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
> diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
> index 33a4396..06b4eb7 100644
> --- a/drivers/memory/emif.c
> +++ b/drivers/memory/emif.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/module.h>
> @@ -25,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <memory/jedec_ddr.h>
>  #include "emif.h"
> +#include "of_memory.h"
> 
>  /**
>   * struct emif_data - Per device static data for driver's use
> @@ -49,6 +51,7 @@
>   *				frequency in effect at the moment)
>   * @plat_data:			Pointer to saved platform data.
>   * @debugfs_root:		dentry to the root folder for EMIF in debugfs
> + * @np_ddr:			Pointer to ddr device tree node
>   */
>  struct emif_data {
>  	u8				duplicate;
> @@ -63,6 +66,7 @@ struct emif_data {
>  	struct emif_regs		*curr_regs;
>  	struct emif_platform_data	*plat_data;
>  	struct dentry			*debugfs_root;
> +	struct device_node		*np_ddr;
>  };
> 
>  static struct emif_data *emif1;
> @@ -1148,6 +1152,168 @@ static int is_custom_config_valid(struct
> emif_custom_configs *cust_cfgs,
>  	return valid;
>  }
> 
> +#if defined(CONFIG_OF)
> +static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
> +		struct emif_data *emif)

Why can't all of this code be in the of_memory.c file?


> +static struct emif_data * __init_or_module of_get_device_details(
> +		struct device_node *np_emif, struct device *dev)

of_get_memory_device_details()?

> +{
> +	struct emif_data		*emif = NULL;
> +	struct ddr_device_info		*dev_info = NULL;
> +	struct emif_platform_data	*pd = NULL;
> +	struct device_node		*np_ddr;
> +	int				len;
> +
> +	np_ddr = of_parse_phandle(np_emif, "device-handle", 0);
> +	if (!np_ddr)
> +		goto error;
> +	emif	= devm_kzalloc(dev, sizeof(struct emif_data), GFP_KERNEL);
> +	pd	= devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +	dev_info = devm_kzalloc(dev, sizeof(*dev_info), GFP_KERNEL);
> +
> +	if (!emif || !pd || !dev_info) {
> +		dev_err(dev, "%s: of_get_device_details() failure!!\n",
> +			__func__);

Look at what that error message just printed out.  Redundancy is nice,
but come on, that's not ok :)

thanks,

greg k-h
