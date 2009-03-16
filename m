From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] OV3640: Make camera sensor goto standby.
Date: Sun, 15 Mar 2009 19:20:32 -0500
Message-ID: <200903151920.32085.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43642 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbZCPAUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Mar 2009 20:20:41 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2G0KWiF015592
	for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 19:20:37 -0500
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n2G0KWRl002355
	for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 19:20:32 -0500 (CDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] OV3640: Make camera sensor goto standby.

This patch ensures that the OV3640 goes/comes back from standby 
when the kernel requests the appropriate power state.

This also seems to fix an issue where ECC errors are seen at STREAMON time.
This could possibly be because the sensor is probably still streaming when the 
receiver is being setup. Putting the sensor into standby would stop it 
streaming until setup of reciever is complete.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    4 +++-
 arch/arm/mach-omap2/board-ldp.c     |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -908,7 +908,8 @@ static int ov3640_sensor_power_set(enum 
 			mdelay(10);
 			enable_fpga_vio_1v8(1);
 			udelay(100);
-		}
+		} else
+			omap_set_gpio_dataout(OV3640_STANDBY_GPIO, 0);
 		break;
 	case V4L2_POWER_OFF:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(OFF)\n");
@@ -932,6 +933,7 @@ static int ov3640_sensor_power_set(enum 
 		break;
 	case V4L2_POWER_STANDBY:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(STANDBY)\n");
+		omap_set_gpio_dataout(OV3640_STANDBY_GPIO, 1);
 		break;
 	}
 	previous_power = power;
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -742,7 +742,8 @@ static int ov3640_sensor_power_set(enum 
 			omap_set_gpio_dataout(OV3640_RESET_GPIO, 0);
 			udelay(100);
 			omap_set_gpio_dataout(OV3640_RESET_GPIO, 1);
-		}
+		} else
+			omap_set_gpio_dataout(OV3640_STANDBY_GPIO, 0);
 		break;
 	case V4L2_POWER_OFF:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(OFF)\n");
@@ -764,6 +765,7 @@ static int ov3640_sensor_power_set(enum 
 		break;
 	case V4L2_POWER_STANDBY:
 		printk(KERN_DEBUG "ov3640_sensor_power_set(STANDBY)\n");
+		omap_set_gpio_dataout(OV3640_STANDBY_GPIO, 1);
 		break;
 	}
 	previous_power = power;
