From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 5/8] ARM: dts: am437x-gp-evm: Hook dcdc2 as the cpu0-supply
Date: Wed, 18 May 2016 18:36:30 -0500
Message-ID: <da3d9998f2e71a213e50364fd20b3c94d3403ccd.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hook dcdc2 as the cpu0-supply.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 5bcd3aa025bc..84832bf26b39 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -975,3 +975,7 @@
 	clock-names = "ext-clk", "int-clk";
 	status = "okay";
 };
+
+&cpu {
+	cpu0-supply = <&dcdc2>;
+};
-- 
2.7.3

