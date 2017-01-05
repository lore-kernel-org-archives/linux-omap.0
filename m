From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv3 0/2] Add TI iodelay driver using #pinctrl-cells
Date: Thu,  5 Jan 2017 10:54:12 -0800
Message-ID: <20170105185414.27247-1-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gary Bisson <gary.bisson@boundarydevices.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here's a v3 respin of Nishanth's iodelay driver that I've updated to
use #pinctrl-cells and generic pinctrl group and function code.

Gary, note that this one has an iterator function that you may
be able to use too, and hopefully we can simplify things further
eventually by introducing a generic iterator.

Regards,

Tony

Changes since v1
- Fix compile error if CONFIG_DEBUG_FS is not set

Changes since v2
- Update with Nishanth's kerneldoc comments
- Added Rob's ack

Nishanth Menon (1):
  pinctrl: Introduce TI IOdelay configuration driver

Tony Lindgren (1):
  pinctrl: core: Make dt_free_map optional

 .../devicetree/bindings/pinctrl/ti,iodelay.txt     |  47 +
 drivers/pinctrl/Kconfig                            |   1 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/core.c                             |   3 -
 drivers/pinctrl/devicetree.c                       |   3 +-
 drivers/pinctrl/ti/Kconfig                         |  10 +
 drivers/pinctrl/ti/Makefile                        |   1 +
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 944 +++++++++++++++++++++
 8 files changed, 1006 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,iodelay.txt
 create mode 100644 drivers/pinctrl/ti/Kconfig
 create mode 100644 drivers/pinctrl/ti/Makefile
 create mode 100644 drivers/pinctrl/ti/pinctrl-ti-iodelay.c

-- 
2.11.0
