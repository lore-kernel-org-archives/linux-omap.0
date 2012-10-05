From: Shubhrajyoti <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 02/16] ARM: OMAP: Split plat-omap/i2c.c into mach-omap1
 and mach-omap2
Date: Fri, 05 Oct 2012 14:23:30 +0530
Message-ID: <506EA00A.3050508@gmail.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local> <20121004220436.26676.33938.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38367 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab2JEIzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 04:55:20 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1476896oag.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 01:55:20 -0700 (PDT)
In-Reply-To: <20121004220436.26676.33938.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 05 October 2012 03:34 AM, Tony Lindgren wrote:
> There's no need to keep the device related things in the
> common i2c.c as omap2+ is using hwmod. Split the code to
> mach-omap1 and mach-omap2 parts and only leave common
> code to plat-omap/i2c.c.
>
> Note that as omap1 only has one i2c controller, we can
> now remove the old device related macros.
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/common.h               |    3 +
>  arch/arm/mach-omap1/i2c.c                  |   59 +++++++++++
>  arch/arm/mach-omap2/board-rm680.c          |    1 
>  arch/arm/mach-omap2/common.h               |    4 +
>  arch/arm/mach-omap2/i2c.c                  |   72 +++++++++++++
>  arch/arm/mach-omap2/i2c.h                  |   25 +----
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    4 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    4 +
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 -
>  arch/arm/mach-omap2/twl-common.c           |    1 
>  arch/arm/plat-omap/i2c.c                   |  152 +---------------------------
>  arch/arm/plat-omap/i2c.h                   |   46 ++++++++
>  arch/arm/plat-omap/include/plat/common.h   |    1 
>  15 files changed, 202 insertions(+), 181 deletions(-)
>  rename arch/arm/{plat-omap/include/plat/i2c.h => mach-omap2/i2c.h} (66%)
>  create mode 100644 arch/arm/plat-omap/i2c.h
>
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index c2552b2..306b7ac 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -28,6 +28,9 @@
>  
>  #include <plat/common.h>
>  #include <linux/mtd/mtd.h>
> +#include <linux/i2c-omap.h>
> +
> +#include "../plat-omap/i2c.h"
>  
>  #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
>  void omap7xx_map_io(void);
> diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
> index a0551a6..a6f465a 100644
> --- a/arch/arm/mach-omap1/i2c.c
> +++ b/arch/arm/mach-omap1/i2c.c
> @@ -19,11 +19,25 @@
>   *
>   */
>  
> -#include <plat/i2c.h>
> +#include <linux/i2c-omap.h>
>  #include <mach/mux.h>
>  #include <plat/cpu.h>
>  
> -void __init omap1_i2c_mux_pins(int bus_id)
> +#include "../plat-omap/i2c.h"
> +
> +#define OMAP_I2C_SIZE		0x3f
> +#define OMAP1_I2C_BASE		0xfffb3800
> +#define OMAP1_INT_I2C		(32 + 4)
> +
> +static const char name[] = "omap_i2c";
> +
> +static struct resource i2c_resources[2] = {
> +};
> +
> +static struct platform_device omap_i2c_devices[1] = {
> +};
> +
> +static void __init omap1_i2c_mux_pins(int bus_id)
>  {
>  	if (cpu_is_omap7xx()) {
>  		omap_cfg_reg(I2C_7XX_SDA);
> @@ -33,3 +47,44 @@ void __init omap1_i2c_mux_pins(int bus_id)
>  		omap_cfg_reg(I2C_SCL);
>  	}
>  }
> +
> +int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
> +				int bus_id)
> +{
> +	struct platform_device *pdev;
> +	struct resource *res;
> +
> +	omap1_i2c_mux_pins(bus_id);
> +
> +	pdev = &omap_i2c_devices[bus_id - 1];
> +	pdev->id = bus_id;
> +	pdev->name = name;
> +	pdev->num_resources = ARRAY_SIZE(i2c_resources);
> +	res = i2c_resources;
> +	res[0].start = OMAP1_I2C_BASE;
> +	res[0].end = res[0].start + OMAP_I2C_SIZE;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[1].start = OMAP1_INT_I2C;
> +	res[1].flags = IORESOURCE_IRQ;
> +	pdev->resource = res;
> +
> +	/* all OMAP1 have IP version 1 register set */
> +	pdata->rev = OMAP_I2C_IP_VERSION_1;
> +
> +	/* all OMAP1 I2C are implemented like this */
> +	pdata->flags = OMAP_I2C_FLAG_NO_FIFO |
> +		       OMAP_I2C_FLAG_SIMPLE_CLOCK |
> +		       OMAP_I2C_FLAG_16BIT_DATA_REG |
> +		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
> +
> +	/* how the cpu bus is wired up differs for 7xx only */
> +
> +	if (cpu_is_omap7xx())
> +		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_1;
> +	else
> +		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
> +
> +	pdev->dev.platform_data = pdata;
> +
> +	return platform_device_register(pdev);
> +}
> diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
> index 45997bf..a57ed21 100644
> --- a/arch/arm/mach-omap2/board-rm680.c
> +++ b/arch/arm/mach-omap2/board-rm680.c
> @@ -22,7 +22,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  
> -#include <plat/i2c.h>
>  #include <plat/mmc.h>
>  #include <plat/usb.h>
>  #include <plat/gpmc.h>
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 7045e4d..a68b421 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -28,7 +28,9 @@
>  
>  #include <linux/irq.h>
>  #include <linux/delay.h>
> +#include <linux/i2c.h>
>  #include <linux/i2c/twl.h>
> +#include <linux/i2c-omap.h>
>  
>  #include <asm/proc-fns.h>
>  
> @@ -36,6 +38,8 @@
>  #include <plat/serial.h>
>  #include <plat/common.h>
>  
> +#include "i2c.h"
> +
>  #define OMAP_INTC_START		NR_IRQS
>  
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
> index fc57e67..b15416c 100644
> --- a/arch/arm/mach-omap2/i2c.c
> +++ b/arch/arm/mach-omap2/i2c.c
> @@ -19,11 +19,15 @@
>   *
>   */
>  
> -#include <plat/i2c.h>
> +#include <linux/i2c-omap.h>
> +
>  #include "common.h"
>  #include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
>  
>  #include "mux.h"
> +#include "i2c.h"
>  
>  /* In register I2C_CON, Bit 15 is the I2C enable bit */
>  #define I2C_EN					BIT(15)
> @@ -33,7 +37,9 @@
>  /* Maximum microseconds to wait for OMAP module to softreset */
>  #define MAX_MODULE_SOFTRESET_WAIT	10000
>  
> -void __init omap2_i2c_mux_pins(int bus_id)
> +#define MAX_OMAP_I2C_HWMOD_NAME_LEN	16
> +
> +static void __init omap2_i2c_mux_pins(int bus_id)
>  {
>  	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
>  
> @@ -104,3 +110,65 @@ int omap_i2c_reset(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +/*
> + * XXX This function is a temporary compatibility wrapper - only
> + * needed until the I2C driver can be converted to call
> + * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
> + */
> +static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
> +{
> +	omap_pm_set_max_mpu_wakeup_lat(dev, t);
> +}
> +
> +static const char name[] = "omap_i2c";
> +
> +int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
> +				int bus_id)
> +{
> +	int l;
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
> +	struct omap_i2c_bus_platform_data *pdata;
> +	struct omap_i2c_dev_attr *dev_attr;
> +
> +	omap2_i2c_mux_pins(bus_id);
> +
> +	l = snprintf(oh_name, MAX_OMAP_I2C_HWMOD_NAME_LEN, "i2c%d", bus_id);
> +	WARN(l >= MAX_OMAP_I2C_HWMOD_NAME_LEN,
> +		"String buffer overflow in I2C%d device setup\n", bus_id);
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +			pr_err("Could not look up %s\n", oh_name);
> +			return -EEXIST;
> +	}
> +
> +	pdata = i2c_pdata;
> +	/*
> +	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
> +	 * use, and functionality implementation flags, up to the OMAP I2C
> +	 * driver via platform data
> +	 */
> +	pdata->rev = oh->class->rev;
> +
> +	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
> +	pdata->flags = dev_attr->flags;
> +
> +	/*
> +	 * When waiting for completion of a i2c transfer, we need to
> +	 * set a wake up latency constraint for the MPU. This is to
> +	 * ensure quick enough wakeup from idle, when transfer
> +	 * completes.
> +	 * Only omap3 has support for constraints
> +	 */
> +	if (cpu_is_omap34xx())
> +		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
this part is touched by Jean also so maybe one of the patch has to be
rebased.

> +	pdev = omap_device_build(name, bus_id, oh, pdata,
>

