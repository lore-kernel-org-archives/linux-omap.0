From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 14/14] dt: omap3: enable dt support for i2c1
 controller
Date: Wed, 17 Aug 2011 00:14:26 +0530
Message-ID: <20110816184426.GA23980@manju-desktop>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
 <1312897232-4792-15-git-send-email-manjugk@ti.com>
 <4E428031.8070600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50412 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753080Ab1HPSon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 14:44:43 -0400
Received: by mail-gx0-f169.google.com with SMTP id 23so162924gxk.28
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 11:44:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E428031.8070600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

On Wed, Aug 10, 2011 at 02:57:21PM +0200, Cousson, Benoit wrote:
> On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
> >
> >Adapt dt for omap i2c1 controller and remove legacy i2c
> >initilization in omap3 generic board file.
> >
> >Tested on omap3 beagle board for dt and non-dt builds.
> >
> >Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> >---
> >  arch/arm/boot/dts/omap3-soc.dtsi     |    6 ++--
> >  arch/arm/mach-omap2/board-omap3-dt.c |   14 +++++-----
> >  drivers/i2c/busses/i2c-omap.c        |   23 ++++++++++++++++--
> >  drivers/of/platform.c                |   41 +++++++++++++++++++++++++++++++++-
> 
> It looks like this patch is doing a lot of things. You should
> probably hack the DT core first and then update the driver and the
> DTS.
> 
> >  4 files changed, 70 insertions(+), 14 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
> >index 85de92f..bcff63b 100644
> >--- a/arch/arm/boot/dts/omap3-soc.dtsi
> >+++ b/arch/arm/boot/dts/omap3-soc.dtsi
> >@@ -31,7 +31,7 @@
> >  		i2c1: i2c@70000 {
> >  			#address-cells =<1>;
> >  			#size-cells =<0>;
> >-			compatible = "ti,omap3-i2c";
> >+			compatible = "ti,omap3-i2c", "ti,omap3-device";
> 
> In that case the compatible is just a tagto identify an OMAP type of
> devices. You should use a more generic "ti,omap-device" entry.
> This is similar to the "arm,primecell" used to tag the primecell IPs.
> 
> >  			reg =<0x70000 0x100>;
> >  			interrupts =<  88>;
> >  		};
> >@@ -39,7 +39,7 @@
> >  		i2c2: i2c@72000 {
> >  			#address-cells =<1>;
> >  			#size-cells =<0>;
> >-			compatible = "ti,omap3-i2c";
> >+			compatible = "ti,omap3-i2c", "ti,omap3-device";
> >  			reg =<0x72000 0x100>;
> >  			interrupts =<  89>;
> >  		};
> >@@ -47,7 +47,7 @@
> >  		i2c3: i2c@60000 {
> >  			#address-cells =<1>;
> >  			#size-cells =<0>;
> >-			compatible = "ti,omap3-i2c";
> >+			compatible = "ti,omap3-i2c", "ti,omap3-device";
> >  			reg =<0x60000 0x100>;
> >  			interrupts =<  93>;
> >  		};
> >diff --git a/arch/arm/mach-omap2/board-omap3-dt.c b/arch/arm/mach-omap2/board-omap3-dt.c
> >index 4b76e19..16cf283 100644
> >--- a/arch/arm/mach-omap2/board-omap3-dt.c
> >+++ b/arch/arm/mach-omap2/board-omap3-dt.c
> >@@ -36,11 +36,11 @@ static struct twl4030_platform_data beagle_twldata = {
> >  	/* platform_data for children goes here */
> >  };
> >
> >-static int __init omap3_beagle_i2c_init(void)
> >-{
> >-	omap3_pmic_init("twl4030",&beagle_twldata);
> >-	return 0;
> >-}
> >+struct of_dev_auxdata omap3_auxdata_lookup[] __initdata = {
> >+	OF_DEV_AUXDATA_ID_PDSIZE("ti,omap3-i2c", 0x48070000, "i2c1", 1,\
> >+				&beagle_twldata, sizeof(beagle_twldata)),
> >+	{}
> >+};
> >
> >  static void __init omap3_init_early(void)
> >  {
> >@@ -70,11 +70,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
> >
> >  static void __init omap3_init(void)
> >  {
> >-	omap3_beagle_i2c_init();
> >  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> >  	omap_serial_init();
> >
> >-	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> >+	of_platform_populate(NULL, omap_dt_match_table, omap3_auxdata_lookup,
> >+									 NULL);
> >  }
> >
> >  static const char *omap3_dt_match[] __initdata = {
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> >index ae1545b..5167737 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -38,6 +38,7 @@
> >  #include<linux/clk.h>
> >  #include<linux/io.h>
> >  #include<linux/of_i2c.h>
> >+#include<linux/of_device.h>
> >  #include<linux/slab.h>
> >  #include<linux/i2c-omap.h>
> >  #include<linux/pm_runtime.h>
> >@@ -972,6 +973,16 @@ static const struct i2c_algorithm omap_i2c_algo = {
> >  	.functionality	= omap_i2c_func,
> >  };
> >
> >+#if defined(CONFIG_OF)
> >+static const struct of_device_id omap_i2c_of_match[] = {
> >+	{.compatible = "ti,omap3-i2c", },.
> 
> This is a generic OMAP driver, so a "ti,omap-i2c" is probably much
> more appropriate. We should always avoid adding OMAP version
> information into a generic driver. Only the IP version should matter
> for a driver.
> 
> >+	{},
> >+}
> >+MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> >+#else
> >+#define omap_i2c_of_match NULL
> >+#endif
> >+
> >  static int __devinit
> >  omap_i2c_probe(struct platform_device *pdev)
> >  {
> >@@ -1008,12 +1019,17 @@ omap_i2c_probe(struct platform_device *pdev)
> >  		goto err_release_region;
> >  	}
> >
> >+	speed = 100;	/* Default speed */
> >  	if (pdata != NULL) {
> >  		speed = pdata->clkrate;
> >  		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> >-	} else {
> >-		speed = 100;	/* Default speed */
> >-		dev->set_mpu_wkup_lat = NULL;
> >+#if defined(CONFIG_OF)
> >+	} else if (pdev->dev.of_node) {
> >+		u32 prop;
> >+		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> >+									&prop))
> >+			speed = prop/100;
> >+#endif
> >  	}
> >
> >  	dev->speed = speed;
> >@@ -1178,6 +1194,7 @@ static struct platform_driver omap_i2c_driver = {
> >  		.name	= "omap_i2c",
> >  		.owner	= THIS_MODULE,
> >  		.pm	= OMAP_I2C_PM_OPS,
> >+		.of_match_table = omap_i2c_of_match,
> >  	},
> >  };
> >
> >diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >index 4b27286..4d8a2fa 100644
> >--- a/drivers/of/platform.c
> >+++ b/drivers/of/platform.c
> >@@ -24,6 +24,10 @@
> >  #include<linux/of_platform.h>
> >  #include<linux/platform_device.h>
> >
> >+#ifdef CONFIG_ARCH_OMAP2PLUS
> >+#include<plat/omap_device.h>
> >+#endif
> >+
> >  const struct of_device_id of_default_bus_match_table[] = {
> >  	{ .compatible = "simple-bus", },
> >  #ifdef CONFIG_ARM_AMBA
> >@@ -544,6 +548,36 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
> >  	return NULL;
> >  }
> >
> >+static struct omap_device_pm_latency omap_device_latency[] = {
> >+	[0] = {
> >+		.deactivate_func	= omap_device_idle_hwmods,
> >+		.activate_func		= omap_device_enable_hwmods,
> >+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> >+	},
> >+};
> >+
> >+int of_omap_device_create(struct device_node *np, const char *name, int id,
> >+							void *platform_data,
> >+							int pd_size)
> >+{
> >+	struct omap_hwmod *oh;
> >+	struct platform_device *pdev;
> >+
> >+	oh = omap_hwmod_lookup(name);
> 
> This is not enough to handle multiple hwmod entries. Moreover you
> will force the device to be named like the hwmod. This is not
> necessarily bad, but we should be able to have a distinct name if
> needed.

I agree it supports only single hwmod entries. As of now, only mcbsp uses
multiple hwmod entries. With dt enabled, most of the drivers can use single
hwmod entry for omap device creation and we can upgrade this api for handling
mutiple hwmod entries.

#>git grep omap_device_build_ss
arch/arm/mach-omap2/devices.c:  pdev = omap_device_build_ss(NULL, "omap_l3_noc",
0, oh, 3, NULL,
arch/arm/mach-omap2/mcbsp.c:    pdev = omap_device_build_ss(NULL, name, id,
oh_device, count, pdata,
arch/arm/plat-omap/include/plat/omap_device.h:struct platform_device
*omap_device_build_ss(struct device_node *np,
arch/arm/plat-omap/omap_device.c: * The function is called from inside
omap_device_build_ss(), after
arch/arm/plat-omap/omap_device.c: * omap_device @od.  Used by
omap_device_build_ss() to determine how
arch/arm/plat-omap/omap_device.c: * omap_device_build_ss() after calling
omap_device_count_resources().
arch/arm/plat-omap/omap_device.c: * platform_device record.  See
omap_device_build_ss() for more
arch/arm/plat-omap/omap_device.c: * passes along the return value of
omap_device_build_ss().
arch/arm/plat-omap/omap_device.c:       return omap_device_build_ss(np,
pdev_name, pdev_id, ohs, 1, pdata,
arch/arm/plat-omap/omap_device.c: * platform_device record.  See
omap_device_build_ss() for more
arch/arm/plat-omap/omap_device.c: * passes along the return value of
omap_device_build_ss().
arch/arm/plat-omap/omap_device.c:       return omap_device_build_ss(NULL,
pdev_name, pdev_id, ohs, 1, pdata,
arch/arm/plat-omap/omap_device.c: * omap_device_build_ss - build and register an
omap_device with multiple hwmods
arch/arm/plat-omap/omap_device.c:struct platform_device
*omap_device_build_ss(struct device_node *np,
#>

-M
