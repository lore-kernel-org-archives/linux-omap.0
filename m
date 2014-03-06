From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 00/13][RESEND] ARM: OMAP: SATA support for OMAP5 & DRA7
Date: Thu, 6 Mar 2014 16:38:36 +0200
Message-ID: <1394116729-28811-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kishon@ti.com, tony@atomide.com, balbi@ti.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

[Resending cause I messed up Kishon's email ID in the original v2.]

This series adds SATA support for OMAP5 uevm and DRA7-evm boards.

- Cleans up the ti-pipe3 PHY driver
- Adds SATA DPLL support to ti-pipe3 PHY driver
- Adds SATA nodes to hwmod and SoC DT data

Patches are based on 3.14-rc4 with balbi/next, linux-phy/next and
omap-for-v3.15/dt merged on top..

To test SATA you will also need [1].

[1] - http://article.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7285

Changelog:

v2
- use 'depends on' instead of 'select' OCP2SCP bus driver.
- Changed DT bindings for dra7-usb2 and am437-usb2 phy.

cheers,
-roger

---
Balaji T K (2):
  ARM: dts: omap5: add sata node
  ARM: dts: dra7: add OCP2SCP3 and SATA nodes

Keshava Munegowda (1):
  ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods

Kishon Vijay Abraham I (1):
  phy: rename struct omap_control_usb to struct omap_control_phy

Nikhil Devshatwar (1):
  ARM: DRA7: hwmod: Add ocp2scp3 and sata hwmods

Roger Quadros (8):
  phy: omap-control: Update DT binding information
  phy: omap-control: update dra7 and am437 usb2 bindings
  phy: ti-pipe3: cleanup clock handling
  phy: ti-pipe3: Add SATA DPLL support
  phy: ti-pipe3: Don't get 'wkupclk' and 'refclk' for SATA PHY
  phy: ti-pipe3: streamline PHY operations
  phy: ti-pipe3: Fix suspend/resume and module reload
  phy: omap: Depend on OMAP_OCP2SCP bus driver

 Documentation/devicetree/bindings/phy/ti-phy.txt   |  40 ++-
 Documentation/devicetree/bindings/usb/omap-usb.txt |  24 --
 arch/arm/boot/dts/dra7.dtsi                        |  39 +++
 arch/arm/boot/dts/omap5.dtsi                       |  47 +++-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  73 ++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  31 ++-
 drivers/phy/Kconfig                                |  16 +-
 drivers/phy/Makefile                               |   1 +
 drivers/{usb => }/phy/phy-omap-control.c           | 169 ++++++-------
 drivers/phy/phy-omap-usb2.c                        |   8 +-
 drivers/phy/phy-ti-pipe3.c                         | 269 +++++++++++++--------
 drivers/usb/musb/omap2430.c                        |   2 +-
 drivers/usb/phy/Kconfig                            |  10 -
 drivers/usb/phy/Makefile                           |   1 -
 .../omap_control_usb.h => phy/omap_control_phy.h}  |  36 +--
 15 files changed, 509 insertions(+), 257 deletions(-)
 rename drivers/{usb => }/phy/phy-omap-control.c (53%)
 rename include/linux/{usb/omap_control_usb.h => phy/omap_control_phy.h} (68%)

-- 
1.8.3.2
