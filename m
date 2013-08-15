From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/9] USB: phy: phy-nop: Manage RESET GPIO in the driver
Date: Thu, 15 Aug 2013 13:18:20 +0300
Message-ID: <1376561909-4406-1-git-send-email-rogerq@ti.com>
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
To: balbi@ti.com, tony@atomide.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Modelling the RESET line as a regulator supply wasn't a good idea
as it abuses the regulator framework and makes adaptation
code/data more complex.

Instead, manage the RESET gpio line directly in the driver.

This also makes us easy to migrate to a dedicated GPIO RESET controller
whenever it becomes available. As of now, it doesn't seem to be making
it into 3.12.

*NOTE:* As there are changes to platform data, Patch 1 needs to be shared
between the arm-soc tree and usb tree.

Patch 1 is available at repo
	git://github.com/rogerq/linux.git
in branch
	phy-reset-common

Patch 2 contains the phy-nop driver changes
Patches 3 and 4 adapt legacy boot code to the phy-nop driver changes.
Patches 5, 6 and 7 adapt DT data to the binding changes.
Patch 8 is cleanup of omap3-beagle DT.
Patch 9 adds USB host support to omap3-beagle-xm using the new binding.

Patches are based on v3.11-rc5.
Tested leacy boot on omap3-beagle and omap3-beagle-xm
Tested DT boot on omap3-beagle, omap3-beagle-xm and omap4-panda-es

v2:
- Added RESET GPIO polarity feature
- Changed to gpio_set_value_cansleep()

cheers,
-roger

---
Roger Quadros (9):
  usb: phy: nop: Add gpio_reset to platform data
  usb: phy: nop: Don't use regulator framework for RESET line
  ARM: OMAP2+: omap-usb-host: Get rid of platform_data from struct
    usbhs_phy_data
  ARM: OMAP2+: usb-host: Adapt to USB phy-nop RESET line changes
  ARM: dts: omap3-beagle: Use reset-gpios for hsusb2_reset
  ARM: dts: omap4-panda: Use reset-gpios for hsusb1_reset
  ARM: dts: omap5-uevm: Use reset-gpios for hsusb2_reset
  ARM: dts: omap3-beagle: Make USB host pin naming consistent
  ARM: dts: omap3-beagle-xm: Add USB Host support

 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |    7 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   65 +++++++++++++++---
 arch/arm/boot/dts/omap3-beagle.dts                 |   37 ++++-------
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   18 +-----
 arch/arm/boot/dts/omap5-uevm.dts                   |   13 +---
 arch/arm/mach-omap2/board-omap3beagle.c            |    6 --
 arch/arm/mach-omap2/usb-host.c                     |   18 +++---
 arch/arm/mach-omap2/usb.h                          |    1 -
 drivers/usb/phy/phy-nop.c                          |   71 ++++++++++++++-----
 include/linux/usb/nop-usb-xceiv.h                  |    4 +-
 10 files changed, 138 insertions(+), 102 deletions(-)

-- 
1.7.4.1
