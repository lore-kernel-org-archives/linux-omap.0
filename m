From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 21/28] [OMAPZOOM] OMAP34XX: CAM: Remove the need for RESUME
 state
Date: Wed, 15 Oct 2008 20:33:12 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568855@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41875 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbYJPBdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:33:19 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1XD7p016547
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:33:18 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1XDYK019166
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:33:13 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP34XX: CAM: Remove the need for RESUME state

In RESUME power state, we were only switching a GPIO for that, and we
weren't executing again the whole POWER_ON commands.

Sakari Ailus removed the RESUME power state from his patchset,
rendering the RESUME uncompilable. So, for compensating that, i'm
storing now the previous power state, to know what is the intended
transition:

- Off -> On, or
- standby -> on (which is the resume case now)

This patch Keeps the same functionality without the need for a resume
state.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   92 ++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

Index: omapkernel/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapkernel.orig/arch/arm/mach-omap2/board-3430sdp.c 2008-10-14 18:51:36.000000000 -0500
+++ omapkernel/arch/arm/mach-omap2/board-3430sdp.c      2008-10-14 18:51:36.000000000 -0500
@@ -611,6 +611,7 @@

 static int mt9p012_sensor_power_set(enum v4l2_power power)
 {
+       static enum v4l2_power previous_power = V4L2_POWER_OFF;
        switch (power) {
        case V4L2_POWER_OFF:
                /* Power Down Sequence */
@@ -626,69 +627,72 @@
                omap_free_gpio(MT9P012_STANDBY_GPIO);
                break;
        case V4L2_POWER_ON:
-               /* Power Up Sequence */
-               isp_configure_interface(&mt9p012_if_config);
+               if (previous_power == V4L2_POWER_OFF) {
+                       /* Power Up Sequence */
+                       isp_configure_interface(&mt9p012_if_config);
+
+                       /* Request and configure gpio pins */
+                       if (omap_request_gpio(MT9P012_STANDBY_GPIO) != 0) {
+                               printk(KERN_WARNING "Could not request GPIO %d"
+                                                       " for MT9P012\n",
+                                                       MT9P012_STANDBY_GPIO);
+                               return -EIO;
+                       }
+
+                       /* Request and configure gpio pins */
+                       if (omap_request_gpio(MT9P012_RESET_GPIO) != 0)
+                               return -EIO;
+
+                       /* set to output mode */
+                       omap_set_gpio_direction(MT9P012_STANDBY_GPIO, 0);
+                       /* set to output mode */
+                       omap_set_gpio_direction(MT9P012_RESET_GPIO, 0);

-               /* Request and configure gpio pins */
-               if (omap_request_gpio(MT9P012_STANDBY_GPIO) != 0) {
-                       printk(KERN_WARNING "Could not request GPIO %d for "
-                                       "AF D88\n", MT9P012_STANDBY_GPIO);
-                       return -EIO;
-               }
-
-               /* Request and configure gpio pins */
-               if (omap_request_gpio(MT9P012_RESET_GPIO) != 0)
-                       return -EIO;
-
-               /* set to output mode */
-               omap_set_gpio_direction(MT9P012_STANDBY_GPIO, 0);
-               /* set to output mode */
-               omap_set_gpio_direction(MT9P012_RESET_GPIO, 0);
+                       /* STANDBY_GPIO is active HIGH for set LOW to release */
+                       omap_set_gpio_dataout(MT9P012_STANDBY_GPIO, 1);

-               /* STANDBY_GPIO is active HIGH for set LOW to release */
-               omap_set_gpio_dataout(MT9P012_STANDBY_GPIO, 1);
+                       /* nRESET is active LOW. set HIGH to release reset */
+                       omap_set_gpio_dataout(MT9P012_RESET_GPIO, 1);

-               /* nRESET is active LOW. set HIGH to release reset */
-               omap_set_gpio_dataout(MT9P012_RESET_GPIO, 1);
-
-               /* turn on digital power */
-               enable_fpga_vio_1v8(1);
+                       /* turn on digital power */
+                       enable_fpga_vio_1v8(1);
 #ifdef CONFIG_TWL4030_CORE
-               /* turn on analog power */
-               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                       /* turn on analog power */
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
                                        VAUX_2_8_V, TWL4030_VAUX2_DEDICATED);
-               twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+                       twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
                                        VAUX_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
 #else
 #error "no power companion board defined!"
 #endif
+               }

+               /* out of standby */
                omap_set_gpio_dataout(MT9P012_STANDBY_GPIO, 0);
-
                udelay(1000);

-               /* have to put sensor to reset to guarantee detection */
-               omap_set_gpio_dataout(MT9P012_RESET_GPIO, 0);
-
-               udelay(1500);
-
-               /* nRESET is active LOW. set HIGH to release reset */
-               omap_set_gpio_dataout(MT9P012_RESET_GPIO, 1);
-               /* give sensor sometime to get out of the reset. Datasheet says
-                  2400 xclks. At 6 MHz, 400 usec are enough */
-               udelay(300);
+               if (previous_power == V4L2_POWER_OFF) {
+                       /* have to put sensor to reset to guarantee detection */
+                       omap_set_gpio_dataout(MT9P012_RESET_GPIO, 0);
+
+                       udelay(1500);
+
+                       /* nRESET is active LOW. set HIGH to release reset */
+                       omap_set_gpio_dataout(MT9P012_RESET_GPIO, 1);
+                       /* give sensor sometime to get out of the reset.
+                        * Datasheet says 2400 xclks. At 6 MHz, 400 usec is
+                        * enough
+                        */
+                       udelay(300);
+               }
                break;
        case V4L2_POWER_STANDBY:
                /* stand by */
                omap_set_gpio_dataout(MT9P012_STANDBY_GPIO, 1);
                break;
-       case V4L2_POWER_RESUME:
-               /* out of standby */
-               omap_set_gpio_dataout(MT9P012_STANDBY_GPIO, 0);
-               udelay(1000);
-               break;
        }
-
+       /* Save powerstate to know what was before calling POWER_ON. */
+       previous_power = power;
        return 0;
 }

