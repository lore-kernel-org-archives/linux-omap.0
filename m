From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v5 0/5] misc serdev: new serdev based driver for Wi2Wi w2sg00x4 GPS module
Date: Fri,  1 Dec 2017 08:49:33 +0100
Message-ID: <cover.1512114576.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Changes V5:
* clarified to keep it in drivers/misc and not create a new group drivers/gps
* fix formatting of new entry in omap3-gta04.dtsi (suggested by Tony Lindgren)
* removed MODULE_ALIAS (suggested by Andrew F. Davis)
* some more formatting, code&style fixes (suggested by Andrew F. Davis)
* apply __maybe_unused for PM (suggested by Andrew F. Davis)
* fixed copyright and author records (suggested by Andrew F. Davis)

2017-11-15 22:38:01: Changes V4:
* removed all pdata remains (suggested by Arnd Bergmann and Rob Herring)
* fixed minor issues and subject/commit messages (suggested by Rob Herring)
* added one missing Signed-off-By: (suggested by Andreas Färber)
* added SPDX header (suggested by Rob Herring)

2017-11-15 16:19:17: Changes V3:
* worked in suggestions by kbuild test robot
* added misc+serdev to the subject

2017-11-12 22:00:02: Changes V2:
* reduced to submit only w2sg00x4 GPS driver code
* add DT node for GTA04 device to make use of the driver
* split into base code and a debugging Kconfig option (brings device into false power state after boot)
* worked in comments by kbuild robot and Rob Herring

2017-05-21 12:44:07: RFC V1
* RFC concerning new serdev based drivers for Wi2Wi w2sg00x4 GPS module and w2cbw003 bluetooth

Years long history of getting this devices supported (original work by Neil Brown).

H. Nikolaus Schaller (5):
  dt-bindings: define vendor prefix for Wi2Wi, Inc.
  dt-bindings: gps: add w2sg00x4 bindings documentation (GPS module with
    UART))
  misc serdev: Add w2sg0004 (gps receiver) power control driver
  DTS: gta04: add uart2 child node for w2sg00x4
  misc serdev: w2sg0004: add debugging code and Kconfig

 .../devicetree/bindings/gps/wi2wi,w2sg0004.txt     |  24 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   7 +
 drivers/misc/Kconfig                               |  18 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/w2sg0004.c                            | 590 +++++++++++++++++++++
 6 files changed, 641 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gps/wi2wi,w2sg0004.txt
 create mode 100644 drivers/misc/w2sg0004.c

-- 
2.12.2
