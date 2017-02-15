From: yegorslists@googlemail.com
Subject: [PATCH v3 0/3] Adding DT support for TI HECC module
Date: Wed, 15 Feb 2017 15:48:42 +0100
Message-ID: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, tony@atomide.com, mkl@pengutronix.de, andrej.skvortzov@gmail.com, hs@denx.de, anton.a.glukhov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This is an attempt to revive DT support for TI HECC that was started in 2015 [1].

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

 .../devicetree/bindings/net/can/ti_hecc.txt        |  32 +++++
 arch/arm/boot/dts/am3517.dtsi                      |  12 ++
 drivers/net/can/ti_hecc.c                          | 157 +++++++++++++++------
 3 files changed, 156 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

-- 
2.1.4

