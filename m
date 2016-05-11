From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/8] regulator: tps65218: Clean ups
Date: Wed, 11 May 2016 11:18:03 +0530
Message-ID: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
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
To: broonie@kernel.org, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org
Cc: nm@ti.com, devicetree@vger.kernel.org, nikita@compulab.co.il, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The series cleans up mainly the regulator driver and implements
the device tree parsing using the regulator framework. Removes
all the redundant compatibles for the individual regulators.

One of the patch removes redundant read wrapper and makes
use of regmap_read wherever necessary.

The series is checked for all the regulator registrations on
am437x-gp-evm and am437x-sk-evm.

Keerthy (8):
  mfd: tps65218: Remove redundant read wrapper
  Documentation: regulator: tps65218: Updates according to changes with
    parsing
  mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
  regulator: tps65218: Remove all the compatibles
  ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
  ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles

 .../devicetree/bindings/regulator/tps65218.txt     |  88 +++++++++++---
 arch/arm/boot/dts/am437x-cm-t43.dts                |   6 -
 arch/arm/boot/dts/am437x-gp-evm.dts                |   6 -
 arch/arm/boot/dts/am437x-sk-evm.dts                |   5 -
 arch/arm/boot/dts/am43x-epos-evm.dts               |   7 --
 drivers/mfd/tps65218.c                             |  24 ++--
 drivers/regulator/tps65218-regulator.c             | 134 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   2 -
 8 files changed, 127 insertions(+), 145 deletions(-)

-- 
1.9.1
