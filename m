From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH] phy: cpcap-usb: only build if CPCAP is enabled
Date: Wed, 12 Jul 2017 17:30:22 +0200
Message-ID: <20170712153022.25910-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

CPCAP phy can only be used with CPCAP MFD, so let's add
a dependency. There is no need to ask for it on e.g. x86
systems. Since nobody complained about compilation errors
in a couple of weeks it is safe to ignore the dependency
for COMPILE_TEST, though.

Also enable CPCAP phy support by default if the main
CPCAP driver is enabled.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/phy/motorola/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
index 6bb7d6bdf1bf..c718b971ee2c 100644
--- a/drivers/phy/motorola/Kconfig
+++ b/drivers/phy/motorola/Kconfig
@@ -5,6 +5,8 @@ config PHY_CPCAP_USB
 	tristate "CPCAP PMIC USB PHY driver"
 	depends on USB_SUPPORT && IIO
 	depends on USB_MUSB_HDRC || USB_MUSB_HDRC=n
+	depends on MFD_CPCAP || COMPILE_TEST
+	default MFD_CPCAP
 	select GENERIC_PHY
 	select USB_PHY
 	help
-- 
2.13.2
