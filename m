From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] CLK: TI: add dpll_clksel_mac_clk node
Date: Thu, 18 Jun 2015 13:31:11 +0530
Message-ID: <1434614473-8500-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: galak@codeaurora.org, tony@atomide.com, t-kristo@ti.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-clk@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series adds the missing clock node needed for cpsw.

Keerthy (2):
  CLK: TI: add dpll_clksel_mac_clk node
  ARM: dts: am4372: Set the default clock rate for dpll_clksel_mac_clk
    clock

 arch/arm/boot/dts/am4372.dtsi        | 7 +++++--
 arch/arm/boot/dts/am43xx-clocks.dtsi | 9 +++++++++
 drivers/clk/ti/clk-43xx.c            | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
1.9.1
