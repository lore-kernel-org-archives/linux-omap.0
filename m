From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/10] ARM: omap2plus_defconfig: Switch to use omapdrm by
 default
Date: Thu,  1 Mar 2018 14:17:03 -0800
Message-ID: <20180301221704.104530-10-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

We've had omapdrm working for few years now so let's use it by
default.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 39 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -335,28 +335,30 @@ CONFIG_VIDEO_OMAP3=m
 CONFIG_CEC_PLATFORM_DRIVERS=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_TVP5150=m
+CONFIG_DRM=m
+CONFIG_DRM_OMAP=m
+CONFIG_OMAP5_DSS_HDMI=y
+CONFIG_OMAP2_DSS_SDI=y
+CONFIG_OMAP2_DSS_DSI=y
+CONFIG_DRM_OMAP_ENCODER_OPA362=m
+CONFIG_DRM_OMAP_ENCODER_TFP410=m
+CONFIG_DRM_OMAP_ENCODER_TPD12S015=m
+CONFIG_DRM_OMAP_CONNECTOR_DVI=m
+CONFIG_DRM_OMAP_CONNECTOR_HDMI=m
+CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV=m
+CONFIG_DRM_OMAP_PANEL_DPI=m
+CONFIG_DRM_OMAP_PANEL_DSI_CM=m
+CONFIG_DRM_OMAP_PANEL_SONY_ACX565AKM=m
+CONFIG_DRM_OMAP_PANEL_LGPHILIPS_LB035Q02=m
+CONFIG_DRM_OMAP_PANEL_SHARP_LS037V7DW01=m
+CONFIG_DRM_OMAP_PANEL_TPO_TD028TTEC1=m
+CONFIG_DRM_OMAP_PANEL_TPO_TD043MTEA1=m
+CONFIG_DRM_OMAP_PANEL_NEC_NL8048HL11=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_OMAP2=m
-CONFIG_FB_OMAP5_DSS_HDMI=y
-CONFIG_FB_OMAP2_DSS_SDI=y
-CONFIG_FB_OMAP2_DSS_DSI=y
-CONFIG_FB_OMAP2_ENCODER_TFP410=m
-CONFIG_FB_OMAP2_ENCODER_TPD12S015=m
-CONFIG_FB_OMAP2_CONNECTOR_DVI=m
-CONFIG_FB_OMAP2_CONNECTOR_HDMI=m
-CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=m
-CONFIG_FB_OMAP2_PANEL_DPI=m
-CONFIG_FB_OMAP2_PANEL_DSI_CM=m
-CONFIG_FB_OMAP2_PANEL_SONY_ACX565AKM=m
-CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02=m
-CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=m
-CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1=m
-CONFIG_FB_OMAP2_PANEL_TPO_TD043MTEA1=m
-CONFIG_FB_OMAP2_PANEL_NEC_NL8048HL11=m
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
@@ -365,7 +367,6 @@ CONFIG_BACKLIGHT_PWM=m
 CONFIG_BACKLIGHT_PANDORA=m
 CONFIG_BACKLIGHT_GPIO=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
-- 
2.16.2
