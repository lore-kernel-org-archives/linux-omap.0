From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 02/15] ARM: OMAP: Correct interrupt type for ARM TWD
Date: Thu, 17 Mar 2016 14:19:06 +0000
Message-ID: <1458224359-32665-3-git-send-email-jonathanh@nvidia.com>
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
IMPLEMENTATION DEFINED. For OMAP4 devices the PPI type cannot be set and
so when we attempt to set the type for the ARM TWD interrupt it fails.
This has done unnoticed because it fails silently and because we cannot
re-configure the type it has had no impact. Nevertheless fix the type
for the TWD interrupt so that it matches the hardware configuration.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

---

Tony, Grygorii,
Please note that I have not tested this. Can you test this series and
see if you see any warnings on OMAP4? I am guessing that the configuration
should be LEVEL and not EDGE. This was reported here:

http://marc.info/?l=linux-tegra&m=145078316419821&w=2

 arch/arm/boot/dts/omap4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2bd9c83300b2..421fe9f8a9eb 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -70,7 +70,7 @@
 		compatible = "arm,cortex-a9-twd-timer";
 		clocks = <&mpu_periphclk>;
 		reg = <0x48240600 0x20>;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_EDGE_RISING)>;
 		interrupt-parent = <&gic>;
 	};
 
-- 
2.1.4
