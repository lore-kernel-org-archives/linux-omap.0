From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: omap2plus_defconfig: Update for dropped options
Date: Mon,  4 Feb 2019 12:33:35 -0800
Message-ID: <20190204203336.7031-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

These are all now selected by default so we can drop them
from omap2plus_defconfig.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -155,7 +155,6 @@ CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_DM816=m
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 CONFIG_DM9000=y
@@ -283,11 +282,9 @@ CONFIG_HWMON=m
 CONFIG_SENSORS_GPIO_FAN=m
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_TMP102=m
-CONFIG_THERMAL=m
 CONFIG_THERMAL_GOV_FAIR_SHARE=y
 CONFIG_THERMAL_GOV_USER_SPACE=y
 CONFIG_CPU_THERMAL=y
-CONFIG_TI_SOC_THERMAL=m
 CONFIG_TI_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
@@ -381,7 +378,6 @@ CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_SOC_TLV320AIC3X=m
 CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_NOKIA_RX51=m
 CONFIG_SND_SOC_OMAP_HDMI=m
@@ -475,8 +471,6 @@ CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_RTC_DRV_CPCAP=m
 CONFIG_DMADEVICES=y
-CONFIG_DMA_OMAP=y
-CONFIG_TI_EDMA=y
 CONFIG_OMAP_IOMMU=y
 CONFIG_REMOTEPROC=m
 CONFIG_OMAP_REMOTEPROC=m
-- 
2.20.1
