From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/3] ARM: omap2plus_defconfig: Enable TI TVP5150 video decoder support
Date: Mon,  8 Feb 2016 14:53:03 -0300
Message-ID: <1454953983-8894-4-git-send-email-javier@osg.samsung.com>
References: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Many OMAP3 boards have a TVP5150/1 video decoder attached to the OMAP3
ISP so enable support for its driver as a module to be able to test it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 792a56d5f45c..9fc172373aa3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -295,6 +295,7 @@ CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_TVP5150=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
2.5.0
