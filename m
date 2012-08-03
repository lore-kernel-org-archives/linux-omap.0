From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/4] Add device tree data for omap5
Date: Fri, 3 Aug 2012 18:08:02 +0530
Message-ID: <1343997486-710-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

The following patch series add i2c support for omap5.
As well as enable I2C based devices like pressure and temperature
through device tree. Also add onchip keypad dts data.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Sourav Poddar (4):
  arm/dts: omap5-evm: Add I2C support
  arm/dts: omap5-evm: Add tmp102 sensor support
  arm/dts: omap5-evm: Add keypad data
  arm/dts: omap5-evm: Add bmp085 sensor support

 arch/arm/boot/dts/omap5-evm.dts |   30 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)
