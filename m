From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/5] misc: new serdev based drivers for Wi2Wi w2sg00x4 GPS module
Date: Sun, 12 Nov 2017 21:59:53 +0100
Message-ID: <cover.1510520397.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Changes V2:
* reduced to submit only w2sg00x4 GPS driver code
* add DT node for GTA04 device to make use of the driver
* split into base code and a debugging Kconfig option (brings device into false power state after boot)
* worked in comments by kbuild robot and Rob Herring

2017-05-21 12:44:07: RFC V1
* RFC concerning new serdev based drivers for Wi2Wi w2sg00x4 GPS module and w2cbw003 bluetooth

H. Nikolaus Schaller (5):
  DT: vendor prefix for Wi2Wi, Inc.
  DT: misc: w2sg0004: add bindings documentation (GPS module with serdev
    UART)
  misc: Add w2sg0004 (gps receiver) power control driver
  DTS: gta04: add serdev node for w2sg00x4
  misc: w2sg0004: add debugging code and Kconfig

 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  24 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   6 +
 drivers/misc/Kconfig                               |  18 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/w2sg0004.c                            | 602 +++++++++++++++++++++
 include/linux/w2sg0004.h                           |  27 +
 7 files changed, 679 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
 create mode 100644 drivers/misc/w2sg0004.c
 create mode 100644 include/linux/w2sg0004.h

-- 
2.12.2
