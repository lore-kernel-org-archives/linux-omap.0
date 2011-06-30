From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/5] OMAP: I2C: Add device tree support
Date: Thu, 30 Jun 2011 15:07:22 +0500
Message-ID: <1309426647-31587-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org


As a part of arm consolidation activity, the OMAP board files needs to
be converted to use device tree.

To begin with, two board files are selected to use device tree for I2C
device registration. The I2C and it's child devices existing on beagle
and panda boards are modified in order to use device tree nodes created
in device tree blob.

This patch series demonstrates i2c nodes creation and it's usage in i2c
and it's client drivers. Since, current implementation of OMAP I2C driver
uses SoC specific HWMOD framework for clock initilization, enable/disable
and other PM functionalities, the patch series cannot work independently
since device registration through device tree bypasses HWMOD framework.

There should be method to control peripheral level clock and to use 
existing hwmod framework api's and features through device tree.
This might require alignment and suggestions from hwmod maintainers and
contributors so that it can be adapted for other drivers also.

TODO: 
1. The board file changes will move to new file board_dt.c once board file
   is completly migrated to DT.

2. Look up table can be provided if specific device names are required and
   also platform_data can be passed through lookup table while populating
   device nodes.

Applies on top of:
git://git.secretlab.ca/git/linux-2.6
Branch:devicetree/test

Compilation:
Compiles for omap2plus_defconfig

Testing:
Boot testing is done on beagle and panda and in i2c driver, the device tree
node data is verified manually in i2c driver and i2c driver will not work after
the probe due to non availability of clock for I2C controllers(Testing is
exempted for I2C1 since it interfaces with power chip).

G, Manjunath Kondaiah (5):
  OMAP3:I2C: Add device tree nodes for beagle board
  OMAP4:I2C: Add device tree nodes for panda board
  OMAP3: Beagle: Update beagle board file to use DT
  OMAP4: Panda: Update panda board file to use DT
  OMAP: I2C: Convert I2C driver to use device tree

 arch/arm/boot/dts/omap3-beagle-nunchuck.dts |    5 --
 arch/arm/boot/dts/omap3-beagle.dts          |   42 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts           |   57 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c     |   24 +++++++++--
 arch/arm/mach-omap2/board-omap4panda.c      |   22 ++++++++++
 drivers/i2c/busses/i2c-omap.c               |   30 ++++++++++++++-
 6 files changed, 170 insertions(+), 10 deletions(-)

-- 
1.7.4.1
