From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] phy: ti: Add AM654 USB2 support
Date: Wed, 5 Dec 2018 17:03:22 +0200
Message-ID: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

This series extends omap-usb2 PHY driver to be used
for AM654 USB2 PHY.

cheers,
-roger

Roger Quadros (4):
  phy: ti: usb2: Fix logic on -EPROBE_DEFER
  phy: ti: Don't depend on OMAP_OCP2SCP
  dt-bindings: phy: ti: Add support for AM654x USB2 PHY
  phy: ti: usb2: Add support for AM654 USB2 PHY

 Documentation/devicetree/bindings/phy/ti-phy.txt |   1 +
 drivers/phy/ti/Kconfig                           |   6 +-
 drivers/phy/ti/phy-omap-usb2.c                   | 105 ++++++++++++++---------
 3 files changed, 67 insertions(+), 45 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
