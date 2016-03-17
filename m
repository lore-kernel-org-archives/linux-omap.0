From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 01/15] ARM: tegra: Correct interrupt type for ARM TWD
Date: Thu, 17 Mar 2016 14:19:05 +0000
Message-ID: <1458224359-32665-2-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

The ARM TWD interrupt is a private peripheral interrupt (PPI) and per
the ARM GIC documentation, whether the type for PPIs can be set is
IMPLEMENTATION DEFINED. For Tegra20/30 devices the PPI type cannot be
set and so when we attempt to set the type for the ARM TWD interrupt it
fails. This has done unnoticed because it fails silently and because we
cannot re-configure the type it has had no impact. Nevertheless fix the
type for the TWD interrupt so that it matches the hardware configuration.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

---
Ideally, we would not be attempting to set the type for an interrupt
where it cannot be programmed but this would require changes to the
device-tree bindings for the GIC. This series adds a WARNING to catch
any of these silent failures.
---
 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 arch/arm/boot/dts/tegra30.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8fb61b93c226..2207c08e3fa3 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -145,7 +145,7 @@
 		interrupt-parent = <&intc>;
 		reg = <0x50040600 0x20>;
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&tegra_car TEGRA20_CLK_TWD>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c6edc8cea34e..5030065cbdfe 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -230,7 +230,7 @@
 		reg = <0x50040600 0x20>;
 		interrupt-parent = <&intc>;
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&tegra_car TEGRA30_CLK_TWD>;
 	};
 
-- 
2.1.4
