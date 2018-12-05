From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/4] phy: ti: Don't depend on OMAP_OCP2SCP
Date: Wed, 5 Dec 2018 17:03:24 +0200
Message-ID: <1544022206-2300-3-git-send-email-rogerq@ti.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

TI_PIPE3 and OMAP_USB2 don't depend on OMAP_OCP2SCP
for build.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/ti/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 2050356..4fdbe06 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -38,7 +38,6 @@ config OMAP_USB2
 	select GENERIC_PHY
 	select USB_PHY
 	select OMAP_CONTROL_PHY
-	depends on OMAP_OCP2SCP
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.
@@ -50,7 +49,6 @@ config TI_PIPE3
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select GENERIC_PHY
 	select OMAP_CONTROL_PHY
-	depends on OMAP_OCP2SCP
 	help
 	  Enable this to support the PIPE3 PHY that is part of TI SOCs. This
 	  driver takes care of all the PHY functionality apart from comparator.
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
