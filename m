From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v7 0/5] mfd: tps65218: Clean ups
Date: Wed, 10 Aug 2016 18:24:01 +0530
Message-ID: <1470833641-29546-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc: gnurou@gmail.com, d-gerlach@ti.com, devicetree@vger.kernel.org, j-keerthy@ti.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-gpio@vger.kernel.org, robh+dt@kernel.org, russ.dill@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The series cleans up mainly the regulator driver and implements
the device tree parsing using the regulator framework. Removes
all the redundant compatibles for the individual regulators.
Adds platform_device_id table for the gpio and power button modules.

One of the patch removes redundant read wrapper and makes
use of regmap_read wherever necessary.

The series is checked for all the regulator registrations on
am437x-gp-evm.

Boot log: http://pastebin.ubuntu.com/22905402/

The series is based on linux-next on top of series titled:
[PATCH v3 0/2] regulator: Enable suspend configuration

Do not have the link of the above series available at the moment.

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
 drivers/input/misc/tps65218-pwrbutton.c            |  10 +-
 drivers/mfd/tps65218.c                             |  34 ++---
 drivers/regulator/tps65218-regulator.c             | 153 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   3 +-
 6 files changed, 158 insertions(+), 132 deletions(-)

-- 
1.9.1
