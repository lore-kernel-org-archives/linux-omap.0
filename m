From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 0/8] arm: dts: dra7: Add PCIe data and PCIe PHY data
Date: Mon, 14 Jul 2014 16:12:15 +0530
Message-ID: <1405334543-25509-1-git-send-email-kishon@ti.com>
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
To: linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: kishon@ti.com
List-Id: linux-omap@vger.kernel.org

[1] is split into separate series in order for individual subsystem
Maintainers to pick up the patches. This series handles the PCIe
dt data for DRA7.

This series has better commit logs than the previous one modified as
suggested by Tero.

[1] -> https://lkml.org/lkml/2014/5/29/258

Keerthy (2):
  ARM: dts: dra7xx-clocks: Add divider table to optfclk_pciephy_div
    clock
  ARM: dts: dra7xx-clocks: Change the parent of apll_pcie_in_clk_mux to
    dpll_pcie_ref_m2ldo_ck

Kishon Vijay Abraham I (6):
  ARM: dts: dra7xx-clocks: Add missing 32KHz clocks used for PHY
  ARM: dts: dra7xx-clocks: rename pcie clocks to accommodate second PHY
    instance
  ARM: dts: dra7xx-clocks: Add missing clocks for second PCIe PHY
    instance
  ARM: dts: dra7: Add dt data for PCIe PHY control module
  ARM: dts: dra7: Add dt data for PCIe PHY
  ARM: dts: dra7: Add dt data for PCIe controller

 arch/arm/boot/dts/dra7.dtsi          |  127 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi |   39 ++++++++++-
 2 files changed, 163 insertions(+), 3 deletions(-)

-- 
1.7.9.5
