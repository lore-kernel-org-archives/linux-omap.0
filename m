From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] extcon: palmas: am57xx-beagle-x15: use palmas for VBUS/ID detection
Date: Mon, 13 Jul 2015 16:01:29 +0300
Message-ID: <1436792491-19431-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com, tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

am57xx-beagle-x15 uses a variant of the Palmas chip and has
USB1 port's VBUS and ID connected to it.

However this Palmas variant does not support OTG ID detection but
does have GPIO support on the pin where ID line is connected.

This series adds GPIO based ID detection to the Palmas extcon
driver and updates am57xx-beagle-x15.dts to use Palmas
for VBUS and ID detection for USB1 port.

cheers,
-roger

Roger Quadros (2):
  extcon: palmas: Support GPIO based USB ID detection
  ARM: dts: am57xx-beagle-x15: use palmas-usb for USB2

 .../devicetree/bindings/extcon/extcon-palmas.txt   |   5 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  25 +++--
 drivers/extcon/extcon-palmas.c                     | 116 ++++++++++++++++++---
 include/linux/mfd/palmas.h                         |   6 ++
 4 files changed, 129 insertions(+), 23 deletions(-)

-- 
2.1.4
