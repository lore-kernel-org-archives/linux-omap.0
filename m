From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] phy: omap-usb2: Fixes for v4.9
Date: Tue, 23 Aug 2016 11:57:38 +0300
Message-ID: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kishon & Tony,

Here are some fixes found in the TI vendor tree for omap-usb2 PHY
and are important for upstream. Please queue for -next if OK. Thanks.

The 3rd patch should probably go via Tony's SoC DT tree.

cheers,
-roger

Sekhar Nori (3):
  phy: omap-usb2: support suspend/resume
  dt-bindings: phy: ti: add documentation for ti,dra7x-usb2
  ARM: dts: dra7: workaround silicon limitation i845

 Documentation/devicetree/bindings/phy/ti-phy.txt |   2 +
 arch/arm/boot/dts/dra7.dtsi                      |   2 +-
 drivers/phy/phy-omap-usb2.c                      | 100 +++++++++++------------
 3 files changed, 49 insertions(+), 55 deletions(-)

-- 
2.7.4
