From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/6] Generic PHY Framework
Date: Wed, 20 Mar 2013 14:41:59 +0530
Message-ID: <1363770725-13717-1-git-send-email-kishon@ti.com>
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
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added a generic PHY framework that provides a set of APIs for the PHY drivers
to create/destroy a PHY and APIs for the PHY users to obtain a reference to
the PHY with or without using phandle. To obtain a reference to the PHY
without using phandle, the platform specfic intialization code (say from board
file) should have already called phy_bind with the binding information. The
binding information consists of phy's device name, phy user device name and an
index. The index is used when the same phy user binds to mulitple phys.

This framework will be of use only to devices that uses external PHY (PHY
functionality is not embedded within the controller).

The intention of creating this framework is to bring the phy drivers spread
all over the Linux kernel to drivers/phy to increase code re-use and to
increase code maintainability.

Comments to make PHY as bus wasn't done because PHY devices can be part of
other bus and making a same device attached to multiple bus leads to bad
design.

Making omap-usb2 and twl4030 to use this framework is provided as a sample.

This patch series is developed on 3.9-rc3. Once the patch series gets finalised
I'll resend omap-usb2 and twl4030 part based on Felipe's tree.

Changes from v2:
* removed phy_descriptor structure completely so changed the APIs which were
  taking phy_descriptor as parameters
* Added 2 more APIs *of_phy_get_byname* and *devm_of_phy_get_byname* to be used
  by PHY user drivers which has *phy* and *phy-names* binding in the dt data
* Fixed a few typos
* Removed phy_list and we now use class_dev_iter_init, class_dev_iter_next and
  class_dev_iter_exit for traversing through the phy list. (Note we still need
  phy_bind list and phy_bind_mutex).
* Changed the sysfs entry name from *bind* to *phy_bind*.

Changes from v1:
* Added Documentation for the PHY framework
* Added few more APIs mostly w.r.t devres
* Modified omap-usb2 and twl4030 to make use of the new framework

Did USB enumeration testing in panda and beagle.
Kishon Vijay Abraham I (6):
  drivers: phy: add generic PHY framework
  usb: phy: omap-usb2: use the new generic PHY framework
  usb: otg: twl4030: use the new generic PHY framework
  ARM: OMAP: USB: Add phy binding information
  ARM: dts: omap: update usb_otg_hs data
  usb: musb: omap2430: use the new generic PHY framework

 Documentation/ABI/testing/sysfs-class-phy          |   15 +
 Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
 Documentation/phy.txt                              |  108 ++++
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/omap3.dtsi                       |    2 +
 arch/arm/boot/dts/omap4.dtsi                       |    2 +
 arch/arm/mach-omap2/board-2430sdp.c                |    2 +
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +
 arch/arm/mach-omap2/board-devkit8000.c             |    2 +
 arch/arm/mach-omap2/board-igep0020.c               |    2 +
 arch/arm/mach-omap2/board-ldp.c                    |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +
 arch/arm/mach-omap2/board-omap3logic.c             |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 +
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c         |    2 +
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +
 arch/arm/mach-omap2/board-overo.c                  |    2 +
 arch/arm/mach-omap2/board-rm680.c                  |    2 +
 arch/arm/mach-omap2/board-rx51.c                   |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    2 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/phy/Kconfig                                |   13 +
 drivers/phy/Makefile                               |    5 +
 drivers/phy/phy-core.c                             |  574 ++++++++++++++++++++
 drivers/usb/musb/musb_core.h                       |    2 +
 drivers/usb/musb/omap2430.c                        |   22 +-
 drivers/usb/otg/twl4030-usb.c                      |   36 ++
 drivers/usb/phy/omap-usb2.c                        |   47 ++
 include/linux/phy/phy.h                            |  218 ++++++++
 34 files changed, 1090 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-phy
 create mode 100644 Documentation/phy.txt
 create mode 100644 drivers/phy/Kconfig
 create mode 100644 drivers/phy/Makefile
 create mode 100644 drivers/phy/phy-core.c
 create mode 100644 include/linux/phy/phy.h

-- 
1.7.10.4
