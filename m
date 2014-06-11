From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 5/5] ARM: dts: exynos4: Add nodes for L2 cache controller
Date: Wed, 11 Jun 2014 17:30:12 +0200
Message-ID: <1402500612-4778-6-git-send-email-t.figa@samsung.com>
References: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Robin Holt <holt@sgi.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch adds device tree nodes for L2 cache controller present on
Exynos4 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 9 +++++++++
 arch/arm/boot/dts/exynos4x12.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ee3001f..99970ab 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -54,6 +54,15 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
+	l2c: l2-cache-controller@10502000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x10502000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+		arm,tag-latency = <2 2 1>;
+		arm,data-latency = <2 2 1>;
+	};
+
 	gic: interrupt-controller@10490000 {
 		cpu-offset = <0x8000>;
 	};
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c5a943d..9487f9c 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -60,6 +60,15 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
+	l2c: l2-cache-controller@10502000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x10502000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+		arm,tag-latency = <2 2 1>;
+		arm,data-latency = <3 2 1>;
+	};
+
 	clock: clock-controller@10030000 {
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
-- 
1.9.3
