From: "Curran, Dominic" <dcurran@ti.com>
Subject: Question about tput constraint on zoom2 camera
Date: Fri, 31 Jul 2009 17:56:45 -0500
Message-ID: <F12EBA124C6E064B9CF1B45E67DDB7E77D4E028E@dlee02.ent.ti.com>
References: <1248458068-21747-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35921 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbZGaW44 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 18:56:56 -0400
In-Reply-To: <1248458068-21747-2-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Subramaniam, Muthu" <muthu@ti.com>


Hi Kevin

I have been testing the zoom2 camera streaming while using different OPP's.
Following table provides summary of what OPP's caused to happen:

  Streaming      Vdd1(OPP)        Vdd2(OPP)           P/F
 VGA @ 30fps           1                2             Pass
 8MP @ 7.5fps          1                2             Fails (stop streaming)
 8MP @ 7.5fps          1                3             Pass

So table shows that locking Vdd2 to OPP=3 when streaming 8MPixel works, but at OPP=2 then streaming fails (stops).

So I thought the tput constraint made the most sense for camera.
The Zoom2 camera sensor has a max tput of:

    3280 x 2464 x 2bpp x 7.5fps = 121228800 bytes/s
                                = 118387 KB/s

However, this calculated value doesn't constrain Vdd2 to OPP3 (DVFS enabled).

Experimentation shows that a tput value of 350000 KB/s is required to constrain Vdd2 to OPP=3.

Can you explain why the practical tput constraint is so much greater than the theoretical value ?

Thanks
dom

NOTE: Following patch was created against 2.6.29 APG  kernel.




From: Dominic Curran <dcurran@ti.com>
Subject: ZOOM2: Add OMAP3 power constraints for Sony camera.

Adds power constraints for the Zoom2 camera sensor (Sony IMX046).
If no constraint was applied then ISP stopped working if Vdd2 went
to OPP2 when streaming 8MPixel at 7.5fps.

Thus Vdd2 needs to be kept at OPP3 while streaming with this sensor.

In theory the following throughput constraint should be sufficient:

  3280 x 2464 x 2bpp x 7.5fps = 118387 KByte/sec

However, in practice it was found that a tput value of 350000 KB/s
was required in order to constrain Vdd2 to OPP3.

This constraint still allowed Vdd1 to goto OPP1 while streaming
without causing problems.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-zoom2-camera.c |    9 ++++++++-
 drivers/media/video/imx046.c             |    2 +-
 include/media/imx046.h                   |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

Index: google/arch/arm/mach-omap2/board-zoom2-camera.c
===================================================================
--- google.orig/arch/arm/mach-omap2/board-zoom2-camera.c
+++ google/arch/arm/mach-omap2/board-zoom2-camera.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>

 #include <mach/gpio.h>
+#include <mach/omap-pm.h>

 static int cam_inited;
 #include <media/v4l2-int-device.h>
@@ -165,7 +166,7 @@ static struct isp_interface_config imx04
 };


-static int imx046_sensor_power_set(enum v4l2_power power)
+static int imx046_sensor_power_set(struct device *dev, enum v4l2_power power)
 {
        struct isp_csi2_lanes_cfg lanecfg;
        struct isp_csi2_phy_cfg phyconfig;
@@ -176,6 +177,9 @@ static int imx046_sensor_power_set(enum
        case V4L2_POWER_ON:
                /* Power Up Sequence */
                printk(KERN_DEBUG "imx046_sensor_power_set(ON)\n");
+
+               omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, 350000);
+
                isp_csi2_reset();

                lanecfg.clk.pol = IMX046_CSI2_CLOCK_POLARITY;
@@ -245,10 +249,13 @@ static int imx046_sensor_power_set(enum
                twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
                                VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
                gpio_free(IMX046_RESET_GPIO);
+
+               omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, 0);
                break;
        case V4L2_POWER_STANDBY:
                printk(KERN_DEBUG "imx046_sensor_power_set(STANDBY)\n");
                /*TODO*/
+               omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, 0);
                break;
        }

Index: google/drivers/media/video/imx046.c
===================================================================
--- google.orig/drivers/media/video/imx046.c
+++ google/drivers/media/video/imx046.c
@@ -1439,7 +1439,7 @@ static int ioctl_s_power(struct v4l2_int
        else
                sensor->pdata->set_xclk(xclk_current, hw_config.u.sensor.xclk);

-       rval = sensor->pdata->power_set(on);
+       rval = sensor->pdata->power_set(&client->dev, on);
        if (rval < 0) {
                v4l_err(client, "Unable to set the power state: "
                        IMX046_DRIVER_NAME " sensor\n");
Index: google/include/media/imx046.h
===================================================================
--- google.orig/include/media/imx046.h
+++ google/include/media/imx046.h
@@ -28,7 +28,7 @@
  * @priv_data_set: device private data (pointer) access function
  */
 struct imx046_platform_data {
-       int (*power_set)(enum v4l2_power power);
+       int (*power_set)(struct device*, enum v4l2_power power);
        int (*ifparm)(struct v4l2_ifparm *p);
        int (*priv_data_set)(void *);
        u32 (*set_xclk)(u32 xclk, u8 xclksel);

