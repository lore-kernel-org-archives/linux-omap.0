From: yegorslists@googlemail.com
Subject: [PATCH v4 0/3] Adding DT support for TI HECC module
Date: Fri, 17 Feb 2017 14:45:55 +0100
Message-ID: <1487339158-18809-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, tony@atomide.com, mkl@pengutronix.de, andrej.skvortzov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This is an attempt to revive DT support for TI HECC that was started in 2015 [1].

Changes v3 -> v4:
  - implement tranciever handling via regulator API (suggested by Marc Kleine-Budde)
  - convert the driver to DT only driver, i.e. remove legacy platform struct and header
    (suggested by Marc Kleine-Budde)

Changes v2 -> v3:
  - rename compatible property to "ti,am3517-hecc" (though there is a stipped
    device named 3505, EMAC driver already uses am3517-emac name, so keep this
    property consistent)
  - use reg-names to specify different HECC I/O mapping (suggested by Tony Lindgren)
  - provide fallback offsets and sizes for board files
  - convert optional property ti,int_line to ti,use-hecc1int and add proper
    description

Changes v1 -> v2:
  - change compatible to "ti,am3505
  - remove CONFIG_OF
  - don't set int_line to 0 explicitly

[1] http://comments.gmane.org/gmane.linux.can/8616

Yegor Yefremov (3):
  ARM: dts: AM35x: Add hecc node
  can: ti_hecc: Add TI HECC DT binding documentation
  can: ti_hecc: Add DT support for TI HECC module

 .../devicetree/bindings/net/can/ti_hecc.txt        |  33 ++++
 arch/arm/boot/dts/am3517.dtsi                      |  12 ++
 drivers/net/can/ti_hecc.c                          | 166 +++++++++++----------
 include/linux/can/platform/ti_hecc.h               |  44 ------
 4 files changed, 133 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
 delete mode 100644 include/linux/can/platform/ti_hecc.h

-- 
2.1.4

