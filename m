From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 00/12] ARM: dts: TI: Add DCAN support
Date: Tue, 9 Sep 2014 17:55:22 +0300
Message-ID: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add DCAN support for am43xx and dra7xx platforms.
We also update the am33xx DCAN nodes to support the driver changes
in the RAMINIT mechanism.

These patches must go in together with [1] (or its revisions)

Patches are available along with dependency [1] patches at

git@github.com:rogerq/linux.git [for-v3.18/dcan-omap]

Changelog:

v2:
- Added vendor prefix "ti," to raminit properties
- Updated am335x dcan nodes

[1] - CAN driver RAMINIT support
http://article.gmane.org/gmane.linux.ports.arm.omap/118368

cheers,
-roger

---

Afzal Mohammed (1):
  arm: dts: am4372: Add dcan nodes

Dave Gerlach (1):
  ARM: dts: am437x-gp-evm: Add pinctrl sleep states for dcan pins

Mugunthan V N (1):
  arm: dts: am437x-gp: Add dcan support

Roger Quadros (9):
  ARM: dts: dra7: Add syscon regmap for CORE CONTROL area
  ARM: dts: DRA7: Add DCAN nodes
  ARM: dts: dra7-evm: Add CAN support
  ARM: dts: dra72-evm: Add CAN support
  ARM: dts: AM43xx: Add aliases to d_can nodes
  ARM: dts: am4372: Add control module syscon node
  ARM: dts: am4372: Add dcan raminit bits
  ARM: dts: am33xx: Add control module syscon node
  ARM: dts: am33xx: Add dcan raminit bits

 arch/arm/boot/dts/am33xx.dtsi       | 19 +++++++++++++----
 arch/arm/boot/dts/am4372.dtsi       | 35 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 42 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts      | 21 +++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi         | 35 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts     | 23 ++++++++++++++++++++
 6 files changed, 171 insertions(+), 4 deletions(-)

-- 
1.8.3.2

