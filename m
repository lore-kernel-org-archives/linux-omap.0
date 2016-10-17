From: Keerthy <j-keerthy@ti.com>
Subject: [RESEND PATCH v8 0/5] mfd: tps65218: Clean ups
Date: Mon, 17 Oct 2016 21:29:33 +0530
Message-ID: <1476719978-16332-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, tony@atomide.com, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, broonie@kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series cleans up mainly the regulator driver and implements
the device tree parsing using the regulator framework. Removes
all the redundant compatibles for the individual regulators.
Adds platform_device_id table for the gpio and power button modules.

One of the patch removes redundant read wrapper and makes
use of regmap_read wherever necessary.

The series is checked for all the regulator registrations on
am437x-sk-evm.

Changes in v8:

Rebased to latest next branch.

Changes in v7:

Rebasing to latest next branch. GPIO patch of this series
pushed to linux-next by Linus. Hence posting the remaining
patches with respective Acks from the domain Maintainers.

Changes in v6:

Rebased regulator/mfd clean up patches against linux-next +
https://lkml.org/lkml/2016/6/24/122 series.

Changes in v5:

Rebased regulator clean up patch against linux-next.

Changes in v4:

For gpio-tps65218 reatined the compatible table.
Fixed missing ';' in the power button patch.
Fixed comments on the Documentation patch.
Split the Device Tree patches to a separate series.

Changes in v3:

Missed making corresponding changes in the power button and gpio
drivers. Added couple of patches to fix them to use mfd_cell way
of parsing.

 

Keerthy (5):
  mfd: tps65218: Remove redundant read wrapper
  Documentation: regulator: tps65218: Update examples
  input: tps65218-pwrbutton: Add platform_device_id table
  mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
  regulator: tps65218: Remove all the compatibles

 .../devicetree/bindings/regulator/tps65218.txt     |  87 +++++++++---
 drivers/gpio/gpio-tps65218.c                       |   3 +-
 drivers/input/misc/tps65218-pwrbutton.c            |   8 ++
 drivers/mfd/tps65218.c                             |  34 ++---
 drivers/regulator/tps65218-regulator.c             | 153 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   3 +-
 6 files changed, 157 insertions(+), 131 deletions(-)

-- 
1.9.1

