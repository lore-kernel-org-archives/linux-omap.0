From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [try#1 PATCH 0/7] Introduce device_asset and use to control Panda
 HUB+ETH power and clock
Date: Wed, 28 Nov 2012 12:59:29 +0000
Message-ID: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The following series implements the device_asset addition to
struct device that has been discussed on the usb and omap lists
with Alan Stern and GKH.  Several of the ideas here are from Alan
Stern.

First we add the new struct to linux/device.h and cause it to be
used just before device probe with one device_asset-specific
callback to "enable" the assets and just after device removal
with another device_asset-specific callback to "disable" the
associated assets.

Typical assets are things like regulators and clocks which are
not known to the generic driver but which are bound to the
specific device instance by hardware design.

Second we provide stock, default device_asset callbacks if your
asset is a struct regulator.  You can just use those and the
regulator will have a get and enable until the device instance
is removed, when it will be disabled and put.

Third we provide the same for struct clk.  These stock callbacks
mean there won't be any code duplication caused in the common case.

Fourth we remove all the struct regulator code from ehci-omap.

Fifth we implement Panda HUB+ETH (smsc95xx chip) regulator control
using the device_asset scheme.  Since the right device, ehci-omap.0
is created under mfd, the device_asset array is passed in
platform_data to the right place where it's added to the
platform_device's device before registration.

Sixth we add the Panda's external ULPI PHY clock to the
device_asset array we established for the regulator case above.

The end result is we are able to remove the code about regulator
and don't need any for clock control in the generic drivers.
Instead we are able to associate the board-specific prerequisites
for the drivers to work on a board externally with the enable and
disable hidden in the plumbing.

The end result is power and clock to the HUB+PHY (smsc95xx chip)
remains off until ehci-hcd module is inserted, and both are
disabled again when the module is removed.

---

Andy Green (7):
      drivers: base: introduce device assets
      regulator: core: add default device asset handlers
      clk: add default device asset handlers
      usb: omap ehci: remove all regulator control from ehci omap
      omap4: panda: add smsc95xx regulator and reset dependent on root hub
      omap4 panda add smsc95xx clock dependent on root hub
      config omap2plus add ehci bits


 arch/arm/configs/omap2plus_defconfig   |   42 +++++-------
 arch/arm/mach-omap2/board-omap4panda.c |  113 +++++++++++++++++++++++---------
 arch/arm/mach-omap2/usb-host.c         |    2 -
 arch/arm/plat-omap/include/plat/usb.h  |    9 +--
 drivers/base/dd.c                      |   36 ++++++++++
 drivers/clk/clkdev.c                   |   39 +++++++++++
 drivers/mfd/omap-usb-host.c            |    9 ++-
 drivers/regulator/core.c               |   34 ++++++++++
 drivers/usb/host/ehci-omap.c           |   37 ----------
 include/linux/clk.h                    |   33 +++++++++
 include/linux/device.h                 |   25 +++++++
 include/linux/regulator/machine.h      |   30 ++++++++
 12 files changed, 303 insertions(+), 106 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
