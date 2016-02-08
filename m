From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/3] ARM: omap2plus_defconfig: Enable OMAP IOMMU support
Date: Mon,  8 Feb 2016 14:53:01 -0300
Message-ID: <1454953983-8894-2-git-send-email-javier@osg.samsung.com>
References: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

OMAP3 media platform drivers (i.e: omap3isp) needs IOMMU support so
enable it to be able to test the OMAP3 Image Signal Processor (ISP).

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/omap2plus_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a7151744b85c..c53d21c30b20 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -412,7 +412,8 @@ CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
-# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IOMMU_SUPPORT=y
+CONFIG_OMAP_IOMMU=y
 CONFIG_EXTCON=m
 CONFIG_EXTCON_USB_GPIO=m
 CONFIG_EXTCON_PALMAS=m
-- 
2.5.0
