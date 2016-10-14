From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/9] ARM: DRA7: Add support for DRA718-evm
Date: Fri, 14 Oct 2016 18:30:24 +0530
Message-ID: <20161014130033.14172-1-lokeshvutla@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This series does minor dts cleanup for dra72-evm and adds support for
DRA718-evm.

Logs:
DRA718-evm: http://pastebin.ubuntu.com/23323331/
DRA72-evm-revc: http://pastebin.ubuntu.com/23323356/

Lokesh Vutla (7):
  ARM: dts: dra72-evm: Remove pinmux configurations for erratum i869
  ARM: dra72-evm: Fix modelling of regulators
  ARM: dts: dra72: Add separate dtsi for tps65917
  regulator: lp873x: Add support for populating input supply
  ARM: OMAP2+: board-generic: add support for DRA71x family
  ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
  ARM: omap2plus_defconfig: Enable LP873X support

Nishanth Menon (2):
  ARM: DRA7: hwmod: Do not register RTC on DRA71
  ARM: dts: Add support for dra718-evm

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 Documentation/devicetree/bindings/mfd/lp873x.txt   |   8 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/dra71-evm.dts                    | 230 ++++++++++++++
 arch/arm/boot/dts/dra72-evm-common.dtsi            | 348 +++------------------
 arch/arm/boot/dts/dra72-evm-revc.dts               |  21 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          | 134 ++++++++
 arch/arm/boot/dts/dra72-evm.dts                    |  14 +-
 arch/arm/configs/omap2plus_defconfig               |   3 +
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  10 +-
 drivers/regulator/lp873x-regulator.c               |   1 +
 12 files changed, 453 insertions(+), 326 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra71-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72-evm-tps65917.dtsi

-- 
2.9.3
