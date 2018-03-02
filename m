From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Enable various USB PHYs found on
 omap variants
Date: Fri,  2 Mar 2018 09:32:18 -0800
Message-ID: <20180302173219.46112-3-tony@atomide.com>
References: <20180302173219.46112-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180302173219.46112-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With MUSB USB OTG controller enabled, let's now enable the USB PHYs
found on omap varian SoCs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -722,6 +722,9 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
+CONFIG_NOP_USB_XCEIV=m
+CONFIG_AM335X_PHY_USB=m
+CONFIG_TWL6030_USB=m
 CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MSM_OTG=m
@@ -912,9 +915,12 @@ CONFIG_E1000E=y
 CONFIG_PWM_STI=y
 CONFIG_PWM_BCM2835=y
 CONFIG_PWM_BRCMSTB=m
+CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_TWL4030_USB=m
 CONFIG_PHY_BERLIN_USB=y
+CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_ROCKCHIP_DP=m
 CONFIG_PHY_ROCKCHIP_USB=y
-- 
2.16.2
