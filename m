From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 07/11] phy: exynos7-usbdrd: Update dependency for ARCH_EXYNOS
Date: Fri, 21 Nov 2014 19:05:50 +0530
Message-ID: <1416576954-11997-8-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

This PHY controller is also present on Exynos7 platform
in arch-exynos family.
So PHY_EXYNOS5_USBDRD should now depend on ARCH_EXYNOS.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/phy/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2a436e6..1514e40 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -193,7 +193,7 @@ config PHY_EXYNOS5250_USB2
 
 config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
-	depends on ARCH_EXYNOS5 && OF
+	depends on ARCH_EXYNOS && OF
 	depends on HAS_IOMEM
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
-- 
1.7.10.4
