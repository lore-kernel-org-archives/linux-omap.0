From: Deepthy Ravi <deepthy.ravi@ti.com>
Subject: [PATCH v2 5/5] omap2plus_defconfig: Enable omap3isp and MT9T111 sensor drivers
Date: Tue, 27 Sep 2011 19:10:48 +0530
Message-ID: <1317130848-21136-6-git-send-email-deepthy.ravi@ti.com>
References: <1317130848-21136-1-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317130848-21136-1-git-send-email-deepthy.ravi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, mchehab@infradead.org, tony@atomide.com, hvaibhav@ti.com, linux-media@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.i
Cc: linux-omap@vger.kernel.org, Deepthy Ravi <deepthy.ravi@ti.com>
List-Id: linux-omap@vger.kernel.org

Enables multimedia driver, media controller api,
v4l2-subdev-api, omap3isp and mt9t111 sensor
drivers in omap2plus_defconfig. Also enables
soc-camera and mt9t112 support since mt9t111
sensor is using mt9t112 driver which is based
on soc-camera subsystem.
Loading soc_camera.ko fails. Hence built into
the kernel.

Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..48032b6 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -133,6 +133,15 @@ CONFIG_TWL4030_WATCHDOG=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_DEV=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_VIDEO_MEDIA=y
+CONFIG_VIDEO_MT9T111=m
+CONFIG_VIDEO_OMAP3=m
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_MT9T112=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.0.4
