From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 0/7] Implement generic regulator constraints parsing for ACPI and OF
Date: Tue, 24 Jan 2017 16:06:34 -0800
Message-ID: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>
List-Id: linux-omap@vger.kernel.org

Until now, the regulator framework assumed that regulators are being
passed in using device tree(OF) only. However, with the recent change
to add ACPI fixed regulator, it is necessary to have all the regulator
init data and regulation constraints parsing performed for ACPI
regulators as well. This is important to ensure that drivers can
properly enable and disable the regulators.

Since regulator properties remain the same across OF and ACPI
regulators, this series of patches provides common routine for
obtaining regulation constraints from device tree and ACPI nodes. In
order to support these common routines, certain device property
functions had to be exported to make the node parsing logic generic
across OF and ACPI.

Since the changes in this patch series are cross-system, it will
require some amount of co-ordination to ensure that it can be applied
at once.

Dmitry Torokhov (3):
  ACPI / property: have acpi_get_next_subnode take fwnode_handle
  device property: introduce fwnode_for_each_child()
  device property: introduce fwnode_get_named_child_node()

Furquan Shaikh (4):
  drivers/regulator: Rename of_map_mode to map_mode in regulator desc
  device property: Export dev_fwnode
  drivers/gpio: Add and export gpiod_lookup[_index]
  drivers/regulator: Initialize regulator init data for ACPI regulators

 drivers/acpi/property.c                 |   8 +-
 drivers/base/property.c                 |  61 ++++++++---
 drivers/gpio/gpiolib.c                  |  75 ++++++++++---
 drivers/regulator/Makefile              |   2 +-
 drivers/regulator/fixed.c               | 100 ++++++-----------
 drivers/regulator/internal.h            |   3 +
 drivers/regulator/max77802-regulator.c  |  12 +-
 drivers/regulator/of_regulator.c        | 156 +-------------------------
 drivers/regulator/qcom_spmi-regulator.c |   2 +-
 drivers/regulator/regulator_props.c     | 189 ++++++++++++++++++++++++++++++++
 drivers/regulator/twl-regulator.c       |   6 +-
 drivers/regulator/twl6030-regulator.c   |   2 +-
 include/linux/acpi.h                    |   5 +-
 include/linux/fwnode.h                  |  10 ++
 include/linux/gpio/consumer.h           |  21 ++++
 include/linux/property.h                |   1 +
 include/linux/regulator/driver.h        |   5 +-
 17 files changed, 386 insertions(+), 272 deletions(-)
 create mode 100644 drivers/regulator/regulator_props.c

-- 
2.11.0.483.g087da7b7c-goog
