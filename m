From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/6] USB: phy: phy-nop: Use RESET controller for managing the
 reset line
Date: Thu, 18 Jul 2013 11:53:04 +0300
Message-ID: <1374137590-17865-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Till now we were modelling the RESET line as a voltage regulator and
using the regulator framework to manage it.

[1] introduces a GPIO based reset controller driver. We use that
to manage the PHY reset line, at least for DT boots. For legacy boots,
will still need to use the regulator framework for reset lines.

Felipe,

The first patch is for you. The Kconfig change might conflict if
you apply this on top of my PHY Kconfig cleanup series.

Benoit,

Patches 2 to 6 are for you.

NOTE: All patches depend on [1] which is yet to be merged in.

cheers,
-roger

[1] - http://thread.gmane.org/gmane.linux.drivers.devicetree/41348

Roger Quadros (6):
  usb: phy-nop: Use RESET Controller for managing the reset line
  ARM: dts: omap3-beagle: Use reset-gpio driver for hsusb2_reset
  ARM: dts: omap4-panda: Use reset-gpio driver for hsusb1_reset
  ARM: dts: omap5-uevm: Use reset-gpio driver for hsusb2_reset
  ARM: dts: omap3-beagle-xm: Add USB Host support
  ARM: dts: omap3-beagle: Make USB host pin naming consistent

 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   10 ++-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   75 +++++++++++++++++---
 arch/arm/boot/dts/omap3-beagle.dts                 |   41 +++++------
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   22 ++----
 arch/arm/boot/dts/omap5-uevm.dts                   |   17 ++---
 drivers/usb/phy/Kconfig                            |    1 +
 drivers/usb/phy/phy-nop.c                          |   48 ++++++++++---
 7 files changed, 146 insertions(+), 68 deletions(-)

-- 
1.7.4.1
