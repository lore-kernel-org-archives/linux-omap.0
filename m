From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/3] ARM: omap2plus_defconfig: Enable ISP support and
 dependencies
Date: Mon,  8 Feb 2016 14:53:02 -0300
Message-ID: <1454953983-8894-3-git-send-email-javier@osg.samsung.com>
References: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The OMAP3 SoC has a Image Signal Processor (ISP) that's used to accelerate
camera images processing. The ISP driver implements V4L2, Media Controller
and V4L2 sub-dev interfaces so enable support for the driver and all these
dependencies to allow video capture to be tested using this HW IP block.

Also, disable the I2C ancillary drivers auto-select option since the media
driver does not auto-select the ancillary devices that are attached to the
bridge because this depends on what's present in the supported OMAP boards.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c53d21c30b20..792a56d5f45c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -288,6 +288,13 @@ CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_OMAP3=m
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
2.5.0
