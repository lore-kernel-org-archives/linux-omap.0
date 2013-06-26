From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v9 0/8] Generic PHY Framework
Date: Wed, 26 Jun 2013 17:17:28 +0530
Message-ID: <1372247257-30186-1-git-send-email-kishon@ti.com>
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
To: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added a generic PHY framework that provides a set of APIs for the PHY drivers
to create/destroy a PHY and APIs for the PHY users to obtain a reference to
the PHY with or without using phandle.

This framework will be of use only to devices that uses external PHY (PHY
functionality is not embedded within the controller).

The intention of creating this framework is to bring the phy drivers spread
all over the Linux kernel to drivers/phy to increase code re-use and to
increase code maintainability.

Comments to make PHY as bus wasn't done because PHY devices can be part of
other bus and making a same device attached to multiple bus leads to bad
design.

If the PHY driver has to send notification on connect/disconnect, the PHY
driver should make use of the extcon framework. Using this susbsystem 
to use extcon framwork will have to be analysed.

Making omap-usb2 and twl4030 to use this framework is provided as a sample.

This patch series is developed on linux mainline tree.

This framework is already being used by display PHYs
http://www.spinics.net/lists/arm-kernel/msg251666.html

These patches are hosted in git://gitorious.org/linuxphy/linuxphy.git testing

Changes from v8:
* Added phy_set_drvdata and phy_get_drvdata in phy.h.
* Changed phy_create API not to take void *priv. private data should now be set
using phy_set_drvdata now.

Changes from v7:
* Fixed Documentation
* Added to_phy, of_phy_provider_register and devm_of_phy_provider_register
* modified runtime_pm usage in phy_init, phy_exit, phy_power_on and
phy_power_off. Now phy_power_on will enable the clocks and phy_power_off will
disable the clocks.
* pm_runtime_no_callbacks() is added so that pm_runtime_get_sync doesn't fail
* modified other patches to adhere to the changes in the PHY framework
* removed usb: phy: twl4030: twl4030 shouldn't be subsys_initcall as it will
be merged separately.
* reference counting has been added to protect phy ops when the PHY is shared
by multiple consumers.

Changes from v6
* corrected few typos in Documentation
* Changed PHY Subsystem to *bool* in Kconfig (to avoid compilation errors when
  PHY Subsystem is kept as module and the dependent modules are built-in)
* Added if pm_runtime_enabled check before runtime pm calls.

Changes from v5:
* removed the new sysfs entries as it dint have any new information other than
  what is already there in /sys/devices/...
* removed a bunch of APIs added to get the PHY and now only phy_get and
  devm_phy_get are used.
* Added new APIs to register/unregister the PHY provider. This is needed for
  dt boot case.
* Enabled pm runtime and incorporated the comments given by Alan Stern in a
  different patch series by Gautam.
* Removed the *phy_bind* API. Now the phy binding information should be passed
  using the platform data to the controller devices.
* Fixed a few typos.

Changes from v4:
* removed of_phy_get_with_args/devm_of_phy_get_with_args. Now the *phy providers*
  should use their custom implementation of of_xlate or use of_phy_xlate to get
  *phy instance* from *phy providers*.
* Added of_phy_xlate to be used by *phy providers* if it provides only one PHY.
* changed phy_core from having subsys_initcall to module_init.
* other minor fixes.

Changes from v3:
* Changed the return value of PHY APIs to ENOSYS
* Added APIs of_phy_get_with_args/devm_of_phy_get_with_args to support getting
  PHYs if the same IP implements multiple PHYs.
* modified phy_bind API so that the binding information can now be _updated_.
  In effect of this removed the binding information added in board files and
  added only in usb-musb.c. If a particular board uses a different phy binding,
  it can update it in board file after usb_musb_init().
* Added Documentation/devicetree/bindings/phy/phy-bindings.txt for dt binding
  information.

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

Kishon Vijay Abraham I (8):
  drivers: phy: add generic PHY framework
  usb: phy: omap-usb2: use the new generic PHY framework
  usb: phy: twl4030: use the new generic PHY framework
  ARM: OMAP: USB: Add phy binding information
  ARM: dts: omap: update usb_otg_hs data
  usb: musb: omap2430: use the new generic PHY framework
  usb: phy: omap-usb2: remove *set_suspend* callback from omap-usb2
  usb: phy: twl4030-usb: remove *set_suspend* and *phy_init* ops

 .../devicetree/bindings/phy/phy-bindings.txt       |   66 +++
 Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
 Documentation/devicetree/bindings/usb/usb-phy.txt  |    6 +
 Documentation/phy.txt                              |  129 +++++
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    2 +
 arch/arm/boot/dts/omap3-evm.dts                    |    2 +
 arch/arm/boot/dts/omap3-overo.dtsi                 |    2 +
 arch/arm/boot/dts/omap4.dtsi                       |    3 +
 arch/arm/boot/dts/twl4030.dtsi                     |    1 +
 arch/arm/mach-omap2/usb-musb.c                     |    6 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/phy/Kconfig                                |   13 +
 drivers/phy/Makefile                               |    5 +
 drivers/phy/phy-core.c                             |  544 ++++++++++++++++++++
 drivers/usb/musb/Kconfig                           |    1 +
 drivers/usb/musb/musb_core.c                       |    1 +
 drivers/usb/musb/musb_core.h                       |    3 +
 drivers/usb/musb/omap2430.c                        |   26 +-
 drivers/usb/phy/Kconfig                            |    1 +
 drivers/usb/phy/phy-omap-usb2.c                    |   60 ++-
 drivers/usb/phy/phy-twl4030-usb.c                  |   63 ++-
 include/linux/phy/phy.h                            |  344 +++++++++++++
 include/linux/usb/musb.h                           |    3 +
 25 files changed, 1243 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-bindings.txt
 create mode 100644 Documentation/phy.txt
 create mode 100644 drivers/phy/Kconfig
 create mode 100644 drivers/phy/Makefile
 create mode 100644 drivers/phy/phy-core.c
 create mode 100644 include/linux/phy/phy.h

-- 
1.7.10.4
