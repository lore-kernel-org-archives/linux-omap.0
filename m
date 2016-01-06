From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/2] dra72: add support for PCIE 2 lane mode
Date: Wed, 6 Jan 2016 16:29:06 +0530
Message-ID: <1452077948-26232-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: kishon@ti.com
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

dra72 reuse the USB PHY for the PCIe 2n lane. So in order for PCIe x2 mode
to work in dra72, certain special configuration has to be made in
USB PHY. This patch series adds those configurations.

In order to enable PCIe x2 mode in DRA72, USB should be disabled.

Certain board modifications has to be done in order to test
x2 mode in dra72-evm.

Patch series is rebased on top of linux-phy next

Kishon Vijay Abraham I (2):
  phy: ti-pipe3: get tx and rx MEM resource
  phy: ti-pipe3: configure usb3 phy to be used as pcie phy

 Documentation/devicetree/bindings/phy/ti-phy.txt |    2 +
 drivers/phy/phy-ti-pipe3.c                       |   57 +++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

-- 
1.7.9.5
