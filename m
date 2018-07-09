From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v5 0/6] Add MCAN Support for dra76x
Date: Mon, 9 Jul 2018 22:18:35 +0530
Message-ID: <20180709164841.14182-1-faiz_abbas@ti.com>
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
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: mark.rutland@arm.com, paul@pwsan.com, tony@atomide.com, faiz_abbas@ti.com, t-kristo@ti.com, sboyd@kernel.org, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

The following patches add dts and sysconfig support
for MCAN on TI's dra76 SOCs

Changes in v5:
 Return from sysc_reset() with error if syss_mask is not
 present. That is the only supported way of reset

Changes in v4:
 1. Rebased to latest kernel
 2. Using ddata->cfg.syss_mask instead of ddata->cfg.quirks
    for checking if poll on reset status is required.

Changes in v3:
 1. Added reset functionality to the ti-sysc
    driver. This enables me to drop the hwmod
    data patch as everything is being done in dt.

 2. Dropped ti,hwmods from the dts nodes

 3. Fixed the unit address of target-module
    and mcan

 4. Removed the status="disabled" in dtsi
    followed by status="okay" in dts.

Changes in v2:
 1. Added Support for mcan in the ti-sysc driver
    Also added the target-module node for the same

 2. Added clkctrl data for mcan clocks

Faiz Abbas (5):
  clk: ti: dra7: Add clkctrl clock data for the mcan clocks
  bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
  bus: ti-sysc: Add support for software reset
  ARM: dts: Add generic interconnect target module node for MCAN
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (1):
  ARM: dts: dra762: Add MCAN clock support

 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 arch/arm/boot/dts/dra76-evm.dts               |  6 ++
 arch/arm/boot/dts/dra76x.dtsi                 | 64 +++++++++++++++++++
 drivers/bus/ti-sysc.c                         | 62 ++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                      |  1 +
 include/dt-bindings/bus/ti-sysc.h             |  2 +
 include/dt-bindings/clock/dra7.h              |  1 +
 include/linux/platform_data/ti-sysc.h         |  1 +
 8 files changed, 138 insertions(+)

-- 
2.17.0
