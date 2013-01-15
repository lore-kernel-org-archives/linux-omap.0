From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/7] usb: musb: add driver for control module
Date: Tue, 15 Jan 2013 14:12:51 +0530
Message-ID: <1358239378-10030-1-git-send-email-kishon@ti.com>
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
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Added a new driver for the usb part of control module. This has an API
to power on the USB2 phy and an API to write to the mailbox depending on
whether MUSB has to act in host mode or in device mode.

Writing to control module registers for doing the above task which was
previously done in omap glue and in omap-usb2 phy is removed.

Also added the dt data to get MUSB working in OMAP platforms.
This series has patches for both drivers and ARCH folders, so If it has to
be split I'll do it.

This series was developed on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv

Did basic enumeration testing in omap4 beagle, omap4 sdp and omap3 beagle.

Kishon Vijay Abraham I (7):
  drivers: usb: phy: add a new driver for usb part of control module
  ARM: OMAP: devices: create device for usb part of control module
  ARM: OMAP2: MUSB: Specify omap4 has mailbox
  drivers: usb: start using the control module driver
  ARM: dts: omap: Add usb_otg and glue data
  ARM: dts: omap: Add omap-usb2 dt data
  ARM: dts: omap: Add omap control usb data

 Documentation/devicetree/bindings/usb/omap-usb.txt |   25 ++-
 Documentation/devicetree/bindings/usb/usb-phy.txt  |    7 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    6 +
 arch/arm/boot/dts/omap3-evm.dts                    |    6 +
 arch/arm/boot/dts/omap3-overo.dtsi                 |    6 +
 arch/arm/boot/dts/omap3.dtsi                       |   11 ++
 arch/arm/boot/dts/omap4-panda.dts                  |    6 +
 arch/arm/boot/dts/omap4-sdp.dts                    |    6 +
 arch/arm/boot/dts/omap4.dtsi                       |   24 +++
 arch/arm/mach-omap2/devices.c                      |   50 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 --
 arch/arm/mach-omap2/usb-musb.c                     |    3 +
 drivers/usb/musb/Kconfig                           |    1 +
 drivers/usb/musb/omap2430.c                        |   64 +++---
 drivers/usb/musb/omap2430.h                        |    9 -
 drivers/usb/phy/Kconfig                            |   10 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/omap-control-usb.c                 |  204 ++++++++++++++++++++
 drivers/usb/phy/omap-usb2.c                        |   38 +---
 include/linux/usb/musb.h                           |    2 +
 include/linux/usb/omap_control_usb.h               |   73 +++++++
 include/linux/usb/omap_usb.h                       |    4 +-
 22 files changed, 469 insertions(+), 100 deletions(-)
 create mode 100644 drivers/usb/phy/omap-control-usb.c
 create mode 100644 include/linux/usb/omap_control_usb.h

-- 
1.7.9.5
