From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH 14/14] dt: omap3: enable dt support for i2c1 controller
Date: Wed, 10 Aug 2011 14:57:21 +0200
Message-ID: <4E428031.8070600@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-15-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1312897232-4792-15-git-send-email-manjugk@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
>
> Adapt dt for omap i2c1 controller and remove legacy i2c
> initilization in omap3 generic board file.
>
> Tested on omap3 beagle board for dt and non-dt builds.
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> ---
>   arch/arm/boot/dts/omap3-soc.dtsi     |    6 ++--
>   arch/arm/mach-omap2/board-omap3-dt.c |   14 +++++-----
>   drivers/i2c/busses/i2c-omap.c        |   23 ++++++++++++++++--
>   drivers/of/platform.c                |   41 +++++++++++++++++++++++++++++++++-

It looks like this patch is doing a lot of things. You should probably 
hack the DT core first and then update the driver and the DTS.

>   4 files changed, 70 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
> index 85de92f..bcff63b 100644
> --- a/arch/arm/boot/dts/omap3-soc.dtsi
> +++ b/arch/arm/boot/dts/omap3-soc.dtsi
> @@ -31,7 +31,7 @@
>   		i2c1: i2c@70000 {
>   			#address-cells =<1>;
>   			#size-cells =<0>;
> -			compatible = "ti,omap3-i2c";
> +			compatible = "ti,omap3-i2c", "ti,omap3-device";

In that case the compatible is just a tagto identify an OMAP type of 
devices. You should use a more generic "ti,omap-device" entry.
This is similar to the "arm,primecell" used to tag the primecell IPs.

>   			reg =<0x70000 0x100>;
>   			interrupts =<  88>;
>   		};
> @@ -39,7 +39,7 @@
>   		i2c2: i2c@72000 {
>   			#address-cells =<1>;
>   			#size-cells =<0>;
> -			compatible = "ti,omap3-i2c";
> +			compatible = "ti,omap3-i2c", "ti,omap3-device";
>   			reg =<0x72000 0x100>;
>   			interrupts =<  89>;
>   		};
> @@ -47,7 +47,7 @@
>   		i2c3: i2c@60000 {
>   			#address-cells =<1>;
>   			#size-cells =<0>;
> -			compatible = "ti,omap3-i2c";
> +			compatible = "ti,omap3-i2c", "ti,omap3-device";
>   			reg =<0x60000 0x100>;
>   			interrupts =<  93>;
>   		};
> diff --git a/arch/arm/mach-omap2/board-omap3-dt.c b/arch/arm/mach-omap2/board-omap3-dt.c
> index 4b76e19..16cf283 100644
> --- a/arch/arm/mach-omap2/board-omap3-dt.c
> +++ b/arch/arm/mach-omap2/board-omap3-dt.c
> @@ -36,11 +36,11 @@ static struct twl4030_platform_data beagle_twldata = {
>   	/* platform_data for children goes here */
>   };
>
> -static int __init omap3_beagle_i2c_init(void)
> -{
> -	omap3_pmic_init("twl4030",&beagle_twldata);
> -	return 0;
> -}
> +struct of_dev_auxdata omap3_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA_ID_PDSIZE("ti,omap3-i2c", 0x48070000, "i2c1", 1,\
> +				&beagle_twldata, sizeof(beagle_twldata)),
> +	{}
> +};
>
>   static void __init omap3_init_early(void)
>   {
> @@ -70,11 +70,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>
>   static void __init omap3_init(void)
>   {
> -	omap3_beagle_i2c_init();
>   	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>   	omap_serial_init();
>
> -	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> +	of_platform_populate(NULL, omap_dt_match_table, omap3_auxdata_lookup,
> +									 NULL);
>   }
>
>   static const char *omap3_dt_match[] __initdata = {
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ae1545b..5167737 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -38,6 +38,7 @@
>   #include<linux/clk.h>
>   #include<linux/io.h>
>   #include<linux/of_i2c.h>
> +#include<linux/of_device.h>
>   #include<linux/slab.h>
>   #include<linux/i2c-omap.h>
>   #include<linux/pm_runtime.h>
> @@ -972,6 +973,16 @@ static const struct i2c_algorithm omap_i2c_algo = {
>   	.functionality	= omap_i2c_func,
>   };
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id omap_i2c_of_match[] = {
> +	{.compatible = "ti,omap3-i2c", },.

This is a generic OMAP driver, so a "ti,omap-i2c" is probably much more 
appropriate. We should always avoid adding OMAP version information into 
a generic driver. Only the IP version should matter for a driver.

> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> +#else
> +#define omap_i2c_of_match NULL
> +#endif
> +
>   static int __devinit
>   omap_i2c_probe(struct platform_device *pdev)
>   {
> @@ -1008,12 +1019,17 @@ omap_i2c_probe(struct platform_device *pdev)
>   		goto err_release_region;
>   	}
>
> +	speed = 100;	/* Default speed */
>   	if (pdata != NULL) {
>   		speed = pdata->clkrate;
>   		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> -	} else {
> -		speed = 100;	/* Default speed */
> -		dev->set_mpu_wkup_lat = NULL;
> +#if defined(CONFIG_OF)
> +	} else if (pdev->dev.of_node) {
> +		u32 prop;
> +		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> +									&prop))
> +			speed = prop/100;
> +#endif
>   	}
>
>   	dev->speed = speed;
> @@ -1178,6 +1194,7 @@ static struct platform_driver omap_i2c_driver = {
>   		.name	= "omap_i2c",
>   		.owner	= THIS_MODULE,
>   		.pm	= OMAP_I2C_PM_OPS,
> +		.of_match_table = omap_i2c_of_match,
>   	},
>   };
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 4b27286..4d8a2fa 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -24,6 +24,10 @@
>   #include<linux/of_platform.h>
>   #include<linux/platform_device.h>
>
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +#include<plat/omap_device.h>
> +#endif
> +
>   const struct of_device_id of_default_bus_match_table[] = {
>   	{ .compatible = "simple-bus", },
>   #ifdef CONFIG_ARM_AMBA
> @@ -544,6 +548,36 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
>   	return NULL;
>   }
>
> +static struct omap_device_pm_latency omap_device_latency[] = {
> +	[0] = {
> +		.deactivate_func	= omap_device_idle_hwmods,
> +		.activate_func		= omap_device_enable_hwmods,
> +		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	},
> +};
> +
> +int of_omap_device_create(struct device_node *np, const char *name, int id,
> +							void *platform_data,
> +							int pd_size)
> +{
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +
> +	oh = omap_hwmod_lookup(name);

This is not enough to handle multiple hwmod entries. Moreover you will 
force the device to be named like the hwmod. This is not necessarily 
bad, but we should be able to have a distinct name if needed.

Benoit
