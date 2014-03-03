From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 06/12] phy: omap: Select OMAP_OCP2SCP bus driver
Date: Mon, 3 Mar 2014 17:07:28 +0200
Message-ID: <1393859254-10937-7-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, balbi@ti.com, tony@atomide.com
Cc: george.cherian@ti.com, balajitk@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

The OMAP_USB2 and OMAP_PIP3 phy devices will not be
detected if the OMAP_OCP2SCP driver is not present.
So select it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2f02ec8..afdab3e 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -44,6 +44,7 @@ config OMAP_USB2
 	depends on USB_PHY
 	select GENERIC_PHY
 	select OMAP_CONTROL_PHY
+	select OMAP_OCP2SCP
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.
@@ -55,6 +56,7 @@ config TI_PIPE3
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select GENERIC_PHY
 	select OMAP_CONTROL_PHY
+	select OMAP_OCP2SCP
 	help
 	  Enable this to support the PIPE3 PHY that is part of TI SOCs. This
 	  driver takes care of all the PHY functionality apart from comparator.
-- 
1.8.3.2
