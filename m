From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/2] add omap mcspi device tree data
Date: Wed, 30 Jan 2013 19:18:53 +0530
Message-ID: <1359553733-12066-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com
Cc: Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

Patch series adds omap5 evm mcspi nodes and pinctrl 
data in omap5.dtsi and omap5-evm.dts files.

Felipe Balbi (1):
  arm: dts: omap5: add SPI devices to OMAP5 DeviceTree file

Sourav Poddar (1):
  arm: dts: omap5-evm: Add mcspi data

 arch/arm/boot/dts/omap5-evm.dts |   46 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 0 deletions(-)
