From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/6] ARM: dts: am335x-sl50: Update to new hardware
Date: Mon, 16 Jan 2017 17:57:30 +0100
Message-ID: <20170116165736.17197-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

The following patches updates the device tree file for the SL50 device, there
are few v1 boards and IMHO doesn't make sense to maintain the device tree
for these old devices, so mostly of the updates are related to changes done in
the next hardware revision v2 (the one that will go out).

Best regards,

Enric Balletbo i Serra (6):
  ARM: dts: am335x-sl50: Remove I2C1 node.
  ARM: dts: am335x-sl50: Enable UART1.
  ARM: dts: am335x-sl50: Enable SPI0 interface and Flash Memory.
  ARM: dts: am335x-sl50: Enable BQ32000 Real Time Clock.
  ARM: dts: am335x-sl50: Enable the MCP23017 GPIO Expander.
  ARM: dts: am335x-sl50: Enable the Ambient Light Sensor.

 arch/arm/boot/dts/am335x-sl50.dts | 70 ++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

-- 
2.9.3
