From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] dt: omap3: add device tree support
Date: Thu, 14 Jul 2011 03:06:11 +0500
Message-ID: <1310592975-25773-1-git-send-email-manjugk@ti.com>
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
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


This patch series is for migrating omap3 beagle board file and to use
device tree data structures in i2c-omap driver.

These are basic changes in order to adopt device tree for using generic
board file with omap3 platforms. Existing non dt setup and build is not 
disturbed and device tree boot needs to be explicitly enabled through
menuconfig option by selecting CONFIG_OMAP3_DT

Build and boot tested for both dt and not dt options on omap3 beagle
board.

Initial review comments and alignment can be found at:
http://comments.gmane.org/gmane.linux.drivers.devicetree/6188

Baseline:
Applies cleanly on top of:
git://git.secretlab.ca/git/linux-2.6
Branch: origin/devicetree/test
commit 88c559f5479ec28a1acd38c081d89f90a059a6ef
Author: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

    drivercore: Add driver probe deferral mechanism

G, Manjunath Kondaiah (4):
  DT: OMAP3: Add SoC file for handling i2c controllers
  DT: OMAP3: Beagle board: set clock freq for i2c devices
  DT: OMAP3: Add generic board file for dt support
  DT: OMAP: Convert I2C driver to use device tree

 arch/arm/boot/dts/omap3-beagle-nunchuck.dts |   11 +-
 arch/arm/boot/dts/omap3-beagle.dts          |   29 ++-
 arch/arm/boot/dts/omap3-soc.dtsi            |   65 +++
 arch/arm/mach-omap2/Kconfig                 |   12 +
 arch/arm/mach-omap2/Makefile                |    2 +
 arch/arm/mach-omap2/board-omap3-dt.c        |  623 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c     |   13 -
 drivers/i2c/busses/i2c-omap.c               |   48 ++-
 8 files changed, 777 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
 create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c

-- 
1.7.4.1
